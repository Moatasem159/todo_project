import 'package:flutter/material.dart';

Future<dynamic> alert(
    {required BuildContext context,
      required String title,
      required String content,
      required String action1,
      required String action2})async{
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(title,style: Theme.of(context).textTheme.displayMedium,),
        content:Text(content,style: Theme.of(context).textTheme.displayLarge,),
        actions:[
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(action1,style: Theme.of(context).textTheme.titleMedium,)
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(action2,style: Theme.of(context).textTheme.titleMedium),
          ),
        ],
      );
    },
  );
}