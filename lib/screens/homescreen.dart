import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:todo/Cubit/States.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/Cubit/ThemeCubit.dart';
import 'package:todo/Global.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController=TextEditingController();
    TextEditingController timeController=TextEditingController();
    TextEditingController dateController=TextEditingController();
    var scaffoldKey=GlobalKey<ScaffoldState>();
    var formKey=GlobalKey<FormState>();
    return BlocProvider(create:(context) => ToDoCubit()..createDataBase(),
      child:BlocConsumer<ToDoCubit,ToDoStates>(listener:(context, state) {},
      builder: (context, state) {
        ToDoCubit cubit=ToDoCubit.get(context);
        return  Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            actions: [
              cubit.isBottomSheetShown?
             Container(): IconButton(
                  splashRadius: 20,
                  icon: ThemeCubit.get(context).icon,
                  onPressed:(){
                    ThemeCubit.get(context).changeThemeMode();
                  })
            ],
            automaticallyImplyLeading: false,
            title: Text(cubit.title[cubit.current]),),
          body: cubit.screens[cubit.current],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(3.0).copyWith(left: 6,right: 6,bottom: 9),
            child: GNav(
              rippleColor: Theme.of(context).primaryColor.withOpacity(0.1), // tab button ripple color when pressed
              hoverColor: Theme.of(context).primaryColorLight, // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 15,
              tabActiveBorder: Border.all(color: Theme.of(context).primaryColor, width: 1.3), // tab button border
              tabBorder: Border.all(color: Theme.of(context).primaryColorLight.withOpacity(0.4), width: 1.5), // tab button border
              tabShadow: [BoxShadow(color: Theme.of(context).primaryColorLight.withOpacity(0.10), blurRadius: 10)], // tab button shadow
              curve: Curves.easeOutExpo, // tab animation curves
              duration: Duration(milliseconds: 500), // tab animation duration
              gap: 20, // the tab button gap between icon and text
              color: Theme.of(context).primaryColorLight, // unselected icon color
              activeColor: Theme.of(context).primaryColorDark, // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.10), // selected tab background color
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
              selectedIndex:cubit.current ,// navigation bar padding
              tabs: [
                GButton(
                  icon: Icons.add,
                  text: 'New',
                ),
                GButton(
                  icon: Icons.check_circle_outline_rounded,
                  text: 'Done',
                ),
                GButton(
                  icon: Icons.archive,
                  text: 'Archive',
                ),
              ],
              onTabChange: (value) {
                cubit.changeIndex(value);
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(cubit.fabIcon),
            onPressed: () {
              if(cubit.isBottomSheetShown)
              {
                if(formKey.currentState!.validate()){
                  cubit.insertInDataBase(
                      titleT: titleController.text,
                      dateT: dateController.text,
                      timeT: timeController.text.toString()
                  ).then((value){
                    Navigator.pop(context);
                    titleController.clear();
                    dateController.clear();
                    timeController.clear();
                    cubit.changeBottomSheet(isShow:false,icon:Icons.edit);
                  });
                }
              }
              else
              {
                scaffoldKey.currentState!.showBottomSheet((context){
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          myTextFormField(
                            context: context,
                            labelText: 'Task Title',
                            controller: titleController,
                            prefixIcon: Icons.title,
                            validator: (value) {
                              if(value!.isEmpty){
                                return'title must be not empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 5,),
                          myTextFormField(
                            context: context,
                            labelText: 'Task time',
                            readOnly: true,
                            controller: timeController,
                            prefixIcon: Icons.watch_later_outlined,
                            onTap: () {
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now()
                              ).then((value){
                                timeController.text=value!.format(context).toString();
                              });
                            },
                            validator: (value) {
                              if(value!.isEmpty){
                                return'time must be not empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 5,),
                          myTextFormField(
                            context: context,
                            labelText: 'Task date',
                            controller: dateController,
                            readOnly: true,
                            inputType: TextInputType.datetime,
                            prefixIcon: Icons.calendar_today_outlined,
                            onTap: (){
                              showDatePicker(context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse("2028-12-31"))
                                  .then((value){
                                dateController.text=DateFormat.yMMMd().format(value!);
                              });
                            },
                            validator: (value) {
                              if(value!.isEmpty){
                                return'date must be not empty';
                              }
                              return null;
                            },),
                        ],
                      ),
                    ),
                  );}).closed.then((value){
                  cubit.changeBottomSheet(isShow:false,icon:Icons.edit);
                });
                cubit.changeBottomSheet(isShow:true,icon:Icons.add);
              }
            },
          ),
        );
      },
      ),);
  }
}


