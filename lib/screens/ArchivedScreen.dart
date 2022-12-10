import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/States.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/Global.dart';

class ArchivedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit,ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks=ToDoCubit.get(context);
        return ConditionalBuilder(condition: tasks.archiveTasks.length>0,
            builder: (context) => ListView.separated(itemCount:tasks.archiveTasks.length,
              itemBuilder: (context, index) {
                return TaskListTile(
                  deleteSnackBar: mySnack(context: context, title: "Deleted"),
                  doneSnackBar:mySnack(context: context, title: "New"),
                  model: tasks.archiveTasks[index],
                  index: 2,
                  leftBackground:doneContainer(icon: Icons.check, title: "Archive"),
                  rightBackground:deleteContainer(icon:Icons.delete_forever,title: "Delete" ),
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
                  Icon(Icons.unarchive,size: 100,color: Theme.of(context).iconTheme.color,),
                  Text('No Archive Tasks',style: Theme.of(context).textTheme.bodyText2,)
                ],
              ),
            ),);
      },);
  }
}
