import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/States.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/widgets/empty_list_widget.dart';
import 'package:todo/widgets/tasks_list.dart';

class ArchivedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit,ToDoStates>(
      builder: (context, state) {
        var tasks=ToDoCubit.get(context);
        if(tasks.archiveTasks.length>0)
          {
            return TasksList(
              leftTitle:"Done",
              rightTitle:"Delete",
              deleteSnackBarTitle:"Deleted",
              doneSnackBarTitle:"Done",
              tasks: tasks.archiveTasks,
              taskTileIndex: 2,
            );
          }
        if(tasks.archiveTasks.length<0)
          {
            return EmptyListWidget(
              icon:Icons.unarchive ,
              title:'No archive tasks',
            );
          }
        return EmptyListWidget(
          icon:Icons.unarchive ,
          title:'No archive tasks',
        );
      },);
  }
}