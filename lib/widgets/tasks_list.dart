import 'package:flutter/material.dart';
import 'package:todo/widgets/action_container.dart';
import 'package:todo/widgets/custom_snack_bar.dart';
import 'package:todo/widgets/task_card.dart';

class TasksList extends StatelessWidget {

  final List<Map> tasks;
  final String leftTitle;
  final String rightTitle;
  final int taskTileIndex;
  final String deleteSnackBarTitle;
  final String doneSnackBarTitle;
  const TasksList({
    Key? key,
    required this.tasks,
    required this.leftTitle,
    required this.rightTitle,
    required this.taskTileIndex,
    required this.deleteSnackBarTitle,
    required this.doneSnackBarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount:tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(
            index: taskTileIndex,
            model: tasks[index],
            leftBackground:ActionContainer(
              isLeft: true,
              icon: Icons.check,
              title: leftTitle,),
            rightBackground:ActionContainer(
              isLeft: false,
              title:rightTitle,
              icon: Icons.delete_forever,),
            deleteSnackBar:mySnack(context: context, title: deleteSnackBarTitle),
            doneSnackBar: mySnack(context: context, title: doneSnackBarTitle));
      },
      separatorBuilder: (context, index) => Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );
  }
}