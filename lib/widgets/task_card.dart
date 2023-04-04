import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/widgets/custom_alert.dart';
import 'package:todo/widgets/custom_snack_bar.dart';

class TaskCard extends StatelessWidget {

  final Map model;
  final Widget leftBackground;
  final Widget rightBackground;
  final int index;
  final SnackBar deleteSnackBar;
  final SnackBar doneSnackBar;
  const TaskCard(
      {Key? key,
        required this.model,
        required this.leftBackground,
        required this.rightBackground,
        required this.index,
        required this.deleteSnackBar,
        required this.doneSnackBar
      }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key:  Key(model['id'].toString()),
      confirmDismiss:(DismissDirection direction)async {
        if(direction ==DismissDirection.endToStart){
          return await alert(context: context, title: 'Delete', content:"Are you sure to delete this task ?", action1:"delete", action2: "Cancel");
        }
        else if(direction==DismissDirection.startToEnd){
          if(index ==0||index ==2)
          {
            return await alert(context: context, title: "done", content:"Are you Sure to continue?", action1: "Yes", action2: "No");
          }
          else {
            return await
            alert(context: context, title: "Archive", content:"Are you Sure to archive this task?", action1: "Yes", action2: "No");
          }

        }
        return null;
      },
      background:leftBackground,
      secondaryBackground:rightBackground,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,backgroundColor:Theme.of(context).primaryColor,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(model['time'],style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 14,
                  ),),
                ),
              ),),
            SizedBox(width:10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(model['title'],style:Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 10,),
                  Text(model['date'],style:Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
            SizedBox(width:10,),
            if(index==0)
              IconButton(icon:Icon(Icons.archive,color: Colors.green,), onPressed: (){
                ToDoCubit.get(context).updateData(status: 'archive', id: model['id']);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                    mySnack(context: context, title: 'Archived')
                );
              }),
            if(index==2)
              IconButton(
                  tooltip: "new tasks",
                  icon:Icon(LineAwesomeIcons.tasks,color: Colors.green,), onPressed: (){
                ToDoCubit.get(context).updateData(status: 'new', id: model['id']);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                    mySnack(context: context, title: "New task")

                );
              }),
          ],
        ),
      ),
      onDismissed: (direction) {
        if(direction==DismissDirection.endToStart)
        {
          ToDoCubit.get(context).deleteData(idD: model['id']);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(deleteSnackBar);
        }
        else if(direction==DismissDirection.startToEnd)
        {
          if(index==0||index ==2){
            ToDoCubit.get(context).updateData(
                status: 'done',
                id: model['id']);
          }
          else if(index==1){
            ToDoCubit.get(context).updateData(
                status: 'archive',
                id: model['id']);
          }
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(doneSnackBar);
        }
      },
    );
  }
}