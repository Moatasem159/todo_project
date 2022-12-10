
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/States.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/Global.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit,ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks=ToDoCubit.get(context);
        return ConditionalBuilder(
            condition: tasks.doneTasks.length>0,
            builder: (context) => ListView.separated(itemCount:tasks.doneTasks.length,
              itemBuilder: (context, index) {
                return TaskListTile(
                   deleteSnackBar:mySnack(context: context, title: "Deleted"),
                  doneSnackBar:mySnack(context: context, title: 'Archived'),
                  index: 1,
                  leftBackground:doneContainer(icon: Icons.archive_outlined, title: "Archive",alignment:Alignment.centerLeft,color: Colors.green),
                  model:tasks.doneTasks[index],
                  rightBackground: deleteContainer(icon:Icons.delete_forever,title: "Delete" ),
                );
              },
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),

            ),
            fallback: (context) => Center(
              child: Column(
                children: [
                  SizedBox(height: 150,),
                  Icon(Icons.clear,size: 100,color: Theme.of(context).iconTheme.color,),
                  Text('No Done Tasks',style: Theme.of(context).textTheme.bodyText2,)
                ],
              ),
            ),);
      },);
  }
}
