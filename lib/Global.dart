import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:todo/Cubit/todo_cubit.dart';


var  primaryLight=Colors.purple;

var primaryDark=Colors.orange;



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
        title: Text(title,style: Theme.of(context).textTheme.headline2,),
        content:Text(content,style: Theme.of(context).textTheme.headline1,),
        actions:[
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(action1,style: Theme.of(context).textTheme.subtitle1,)
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(action2,style: Theme.of(context).textTheme.subtitle1),
          ),
        ],
      );
    },
  );
}


SnackBar mySnack({required BuildContext context,required String title}){
  return SnackBar(
    backgroundColor: Theme.of(context).primaryColor,
    content: Text(title,style: Theme.of(context).textTheme.subtitle1),
    duration: Duration(seconds: 1),
    behavior: SnackBarBehavior.fixed,
  );
}




Widget myTextFormField(
    {required BuildContext context,
      String? labelText,
      IconData? prefixIcon,
      TextEditingController? controller,
      String ? validator(String? value)?,
      onTap()?,
      bool obscure = false,
      Widget? suffixIcon,
      Color focusedBorderColor=Colors.black45,
      Color  enabledBorderColor=Colors.black45,
      Color   inputTextColor= Colors.white,
      bool readOnly=false,
      TextInputType? inputType,
      bool clickable=true,
    })
{
  return Padding(
    padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
    child: TextFormField(
      enabled:clickable,
      onTap:onTap ,
      keyboardType: inputType,
      onChanged: (value) => print(value),
      autocorrect: true,
      obscureText: obscure,
      validator: validator,
      controller: controller,
      style: GoogleFonts.aBeeZee(
          color: inputTextColor
      ),
      readOnly: readOnly,
      textInputAction: TextInputAction.done,
      cursorColor: inputTextColor,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, style: BorderStyle.solid, color:  Theme.of(context).primaryColorDark,),
            borderRadius: BorderRadius.circular(15)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 3, style: BorderStyle.solid, color: Theme.of(context).primaryColorDark,),
            borderRadius: BorderRadius.circular(15)),
        errorStyle: Theme.of(context).textTheme.subtitle1,
        labelStyle: GoogleFonts.aBeeZee(
          color:  Theme.of(context).primaryIconTheme.color,
        ),
        labelText: labelText,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, style: BorderStyle.solid, color:Theme.of(context).primaryColorDark,),
            borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 3, style: BorderStyle.solid, color: enabledBorderColor),
            borderRadius: BorderRadius.circular(15)),
        prefixIcon: Icon(
          prefixIcon,
          color: Theme.of(context).primaryIconTheme.color,
        ),
      ),
    ),
  );
}





Widget deleteContainer({required IconData icon,required String title}){
  return Container(
    padding: EdgeInsets.all(20),
    alignment: Alignment.centerRight,
    color: Colors.red,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,color: Colors.white,size: 30,),
      Text(title,style: TextStyle(color: Colors.white,fontSize:20 ),)

      ],
    ),
  );
}
Widget doneContainer({required IconData icon,required String title,Alignment ? alignment=Alignment.centerLeft,Color color=Colors.green}){
  return Container(
    padding: EdgeInsets.all(20),
    alignment: alignment,
    color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,color: Colors.white,size: 30,),
      Text(title,style: TextStyle(color: Colors.white,fontSize:20 ),)

      ],
    ),
  );
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
class TaskListTile extends StatelessWidget {

  final Map model;
  final Widget leftBackground;
  final Widget rightBackground;
  final int index;
  final SnackBar deleteSnackBar;
  final SnackBar doneSnackBar;


  const TaskListTile(
      {Key? key,
        required this.model,
        required this.leftBackground,
        required this.rightBackground,
        required this.index,
        required this.deleteSnackBar,
        required this.doneSnackBar
      })
      : super(key: key);

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
              child: Text(model['time'],style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 14,
              ),),),
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
        if(direction==DismissDirection.endToStart){
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