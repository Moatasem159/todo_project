import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/States.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/widgets/empty_list_widget.dart';
import 'package:todo/widgets/tasks_list.dart';
class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit,ToDoStates>(
      builder: (context, state) {
        var tasks=ToDoCubit.get(context);
        if(tasks.doneTasks.length>0)
          {
            return TasksList(
              leftTitle:"Archive",
              rightTitle:"Delete",
              deleteSnackBarTitle:"Deleted",
              doneSnackBarTitle:"Archived",
              tasks: tasks.doneTasks,
              taskTileIndex: 1,
            );
          }
        if(tasks.doneTasks.length<0)
          {
            return EmptyListWidget(
              icon:Icons.clear,
              title:'No done tasks',
            );
          }
        return EmptyListWidget(
          icon:Icons.clear,
          title:'No done tasks',
        );
      },);
  }
}