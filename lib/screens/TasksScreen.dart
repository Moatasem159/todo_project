import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/States.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/widgets/empty_list_widget.dart';
import 'package:todo/widgets/tasks_list.dart';
class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit,ToDoStates>(
    builder: (context, state) {
      ToDoCubit tasks=ToDoCubit.get(context);
      if(tasks.newTasks.isNotEmpty)
        {
          return TasksList(
            leftTitle:"Done",
            rightTitle:"Delete",
            deleteSnackBarTitle:"Deleted",
            doneSnackBarTitle:"Done",
            tasks: tasks.newTasks,
            taskTileIndex: 0,
          );
        }
      if(tasks.newTasks.isEmpty)
        {
          return EmptyListWidget(
            icon:Icons.menu ,
            title:'No tasks yet',
          );
        }
      return EmptyListWidget(
        icon:Icons.menu ,
        title:'No tasks yet',
      );
    },);
  }
}