
import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const EmptyListWidget({
    Key? key,
    required this.icon,
    required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 150,),
          Icon(icon,size: 100,color: Theme.of(context).iconTheme.color,),
          Text(title,style: Theme.of(context).textTheme.bodyMedium,)
        ],
      ),
    );
  }
}