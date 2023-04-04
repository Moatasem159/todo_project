import 'package:flutter/material.dart';

SnackBar mySnack({required BuildContext context,required String title}){
  return SnackBar(
    backgroundColor: Theme.of(context).primaryColor,
    content: Text(title,style: Theme.of(context).textTheme.titleMedium),
    duration: Duration(seconds: 1),
    behavior: SnackBarBehavior.fixed,
  );
}