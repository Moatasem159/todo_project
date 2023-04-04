import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:todo/Cubit/bottom_nav_cubit/bottom_nav_state.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/widgets/create_task_form.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavStates>(
      builder: (context, state) {
        BottomNavCubit cubit=BottomNavCubit.get(context);
        return FloatingActionButton(
          child: Icon(cubit.fabIcon),
          onPressed: () {
            if(cubit.isBottomSheetShown)
            {
              if(cubit.formKey.currentState!.validate()){
                ToDoCubit.get(context).insertInDataBase(
                    titleT: cubit.titleController.text,
                    dateT: cubit.dateController.text,
                    timeT: cubit.timeController.text.toString()
                ).then((value){
                  Navigator.pop(context);
                  cubit.titleController.clear();
                  cubit.dateController.clear();
                  cubit.timeController.clear();
                  cubit.changeBottomSheet(isShow:false,icon:Icons.edit);
                });
              }
            }
            else
            {
              cubit.scaffoldKey.currentState!.showBottomSheet((context){
                return CreateTaskForm(
                  formKey: cubit.formKey,
                  title: cubit.titleController,
                  time: cubit.timeController,
                  date: cubit.dateController,
                );

              }).closed.then((value){
                cubit.changeBottomSheet(isShow:false,icon:Icons.edit);
              });
              cubit.changeBottomSheet(isShow:true,icon:Icons.add);
            }
          },
        );
      },
    );
  }
}