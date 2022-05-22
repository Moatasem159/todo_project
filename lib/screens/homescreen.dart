import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              unselectedItemColor: Theme.of(context).primaryColorLight,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Theme.of(context).primaryColorDark,
              unselectedLabelStyle: Theme.of(context).textTheme.subtitle1,
              selectedLabelStyle:Theme.of(context).textTheme.subtitle1,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              onTap: (value) {
                cubit.changeIndex(value);
              },
              currentIndex: cubit.current,
              items: cubit.navigationItems),
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


