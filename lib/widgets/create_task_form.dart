import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/widgets/custom_text_form_field.dart';

class CreateTaskForm extends StatelessWidget {
  final GlobalKey formKey;
  final TextEditingController title;
  final TextEditingController time;
  final TextEditingController date;
  const CreateTaskForm({
    Key? key,
    required this.formKey,
    required this.title,
    required this.time,
    required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      padding: EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            myTextFormField(
              context: context,
              labelText: 'Task Title',
              controller: title,
              prefixIcon: Icons.title,
              validator: (value) {
                if(value!.isEmpty){
                  return'title must be not empty';
                }
                return null;
              },
            ),
            SizedBox(height: 5,),
            myTextFormField(
              context: context,
              labelText: 'Task time',
              readOnly: true,
              controller: time,
              prefixIcon: Icons.watch_later_outlined,
              onTap: () {
                showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now()
                ).then((value){
                  time.text=value!.format(context).toString();
                });
              },
              validator: (value) {
                if(value!.isEmpty){
                  return'time must be not empty';
                }
                return null;
              },
            ),
            SizedBox(height: 5,),
            myTextFormField(
              context: context,
              labelText: 'Task date',
              controller: date,
              readOnly: true,
              inputType: TextInputType.datetime,
              prefixIcon: Icons.calendar_today_outlined,
              onTap: (){
                showDatePicker(context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.parse("2030-12-31"))
                    .then((value){
                  date.text=DateFormat.yMMMd().format(value!);
                });
              },
              validator: (value) {
                if(value!.isEmpty){
                  return'date must be not empty';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}