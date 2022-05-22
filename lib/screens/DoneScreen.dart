import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
                return doneTasksListTile(model:tasks.doneTasks[index],context:context);
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
                  Text('No Done Tasks',style: Theme.of(context).textTheme.bodyText1,)
                ],
              ),
            ),);
      },);
  }


  Widget doneTasksListTile({required Map model, context,}){
    return Dismissible(
      key:  Key(model['id'].toString()),
      confirmDismiss:(DismissDirection direction)async {
        if(direction ==DismissDirection.endToStart){
          return await
          alert(context: context, title: 'Delete', content:"Are you sure to delete this task ?", action1:"delete", action2: "Cancel");
        }
        else if(direction==DismissDirection.startToEnd){
          return await
          alert(context: context, title: "Archive", content:"Are you Sure to archive this task?", action1: "Yes", action2: "No");
        }
      },
      background:doneContainer(icon: Icons.archive_outlined, title: "Archive",alignment:Alignment.centerLeft,color: Colors.green ) ,
      secondaryBackground:deleteContainer(icon:Icons.delete_forever,title: "Delete" ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(radius: 40,
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(model['time'],style:GoogleFonts.workSans(
                  color: Colors.white,
                  fontSize: 18
              )),),
            SizedBox(width:10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(model['title'],style:Theme.of(context).textTheme.bodyText2),
                  SizedBox(height: 10,),
                  Text(model['date'],style:Theme.of(context).textTheme.subtitle2),
                ],),
            ),
            SizedBox(width:10,),
            // IconButton(icon:Icon(Icons.check_box,color: primaryLight,), onPressed: (){
            //
            // }),
            /* IconButton(icon:Icon(Icons.archive,color: Colors.green,), onPressed: (){
            ToDoCubit.get(context).updateData(status: 'archive', id: model['id']);
          })*/
          ],
        ),
      ),
      onDismissed: (direction) {

        if(direction==DismissDirection.endToStart){
          ToDoCubit.get(context).deleteData(idD: model['id']);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
          mySnack(context: context, title: "Deleted"));
        }
        else if(direction==DismissDirection.startToEnd){
          ToDoCubit.get(context).updateData(status: 'archive', id: model['id']);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            mySnack(context: context, title: 'Archived')
          );
        }
      },
    );
  }
}
