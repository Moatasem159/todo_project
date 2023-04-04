import 'package:flutter/material.dart';

class ActionContainer extends StatelessWidget {
  final bool isLeft;
  final IconData icon;
  final String title;
  const ActionContainer({
    Key? key,
    required this.isLeft,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20),
      alignment:isLeft? Alignment.centerLeft:Alignment.centerRight,
      color: isLeft?Colors.green:Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: Colors.white,size: 15,),
          Text(title,style: TextStyle(color: Colors.white,fontSize:15 ),)
        ],
      ),
    );
  }
}