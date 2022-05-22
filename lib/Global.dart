import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


var  primaryLight=Colors.deepOrange;

Color primaryDark=Color(0xFF128C7E);



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
    // action:SnackBarAction(label: "Undo", onPressed:
    //     () {
    //   ToDoCubit.get(context).undoDelete(title:model['time'], time:model['date'], date: model['date']);
    //
    //
    // }
    //
    // ),
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
