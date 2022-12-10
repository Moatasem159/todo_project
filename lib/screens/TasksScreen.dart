import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/States.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/Global.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit,ToDoStates>(
      listener: (context, state) {},
    builder: (context, state) {
      ToDoCubit tasks=ToDoCubit.get(context);
      return ConditionalBuilder(
          condition: tasks.newTasks.isNotEmpty,
          builder: (context) => ListView.separated(itemCount:tasks.newTasks.length,
            itemBuilder: (context, index) {
              return TaskListTile(
                  model: tasks.newTasks[index],
                  leftBackground: doneContainer(icon: Icons.check, title: "Done"),
                  rightBackground:deleteContainer(icon:Icons.delete_forever,title: "Delete" ),
                  index: 0,
                  deleteSnackBar:mySnack(context: context, title: "Deleted"),
                  doneSnackBar: mySnack(context: context, title: "Done"));
            },
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
          ),
          fallback:(context) => Center(
            child: Column(
              children: [
                SizedBox(height: 150,),
                Icon(Icons.menu,size: 100,color: Theme.of(context).iconTheme.color,),
                Text('No Tasks yet',style: Theme.of(context).textTheme.bodyText2, )
              ],
            ),
          ),);
    },);
  }

}



