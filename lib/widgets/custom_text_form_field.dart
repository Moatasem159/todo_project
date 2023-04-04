import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        errorStyle: Theme.of(context).textTheme.titleMedium,
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