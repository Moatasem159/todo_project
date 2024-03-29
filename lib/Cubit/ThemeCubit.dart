import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/Cubit/Shared_Preferences.dart';
import 'package:todo/Cubit/States.dart';
var primaryLight=Colors.purple;
var primaryDark=Colors.orange;
class ThemeCubit extends Cubit<ThemesStates>{
  ThemeCubit() : super(AppThemeInitialState());
  static ThemeCubit get(context)=>BlocProvider.of(context);

  ThemeData darkTheme = ThemeData(
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.deepOrange,
    floatingActionButtonTheme:
    FloatingActionButtonThemeData(
        backgroundColor:primaryDark,
        foregroundColor: Colors.white,
    ),
    primaryIconTheme: IconThemeData(color: Colors.white),
    iconTheme: IconThemeData(
      color: Colors.white60,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.workSans(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w600
      ),
      titleMedium: GoogleFonts.workSans(
        color: Colors.white,
        fontSize: 15,
      ),
      bodyMedium: GoogleFonts.workSans(
        color: Colors.white,
        fontSize: 20,
      ),
      titleSmall: GoogleFonts.workSans(
        color: Colors.white70,
        fontSize: 15,
      ),
      displayLarge: GoogleFonts.workSans(
        color: Colors.white,
        fontSize: 18,
      ),
      displayMedium: GoogleFonts.workSans(
        color: Colors.white,
        fontSize: 25,
      ),
      labelSmall: GoogleFonts.workSans(),
      headlineMedium: GoogleFonts.workSans(),
      displaySmall: GoogleFonts.workSans(),
      headlineSmall: GoogleFonts.workSans(),
      titleLarge: GoogleFonts.workSans(),
      labelLarge: GoogleFonts.workSans(),
      bodySmall: GoogleFonts.workSans(),
    ),
    primaryColor: primaryDark,
    primarySwatch:primaryDark ,
    scaffoldBackgroundColor: Color(0xFF191919),
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.workSans(fontSize: 22, color: Colors.white),
      elevation: 20,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF323232),
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: Color(0xFF323232),
    ),
  );

  ThemeData lightTheme=ThemeData(
    primaryColorLight:Colors.black45,
    primaryColorDark: Colors.white,
    primaryIconTheme: IconThemeData(color: Colors.white),
    iconTheme: IconThemeData(
      color: Colors.grey,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: Colors.white
    ),
    primaryColor: primaryLight,
    primarySwatch: primaryLight,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.workSans(
            fontSize: 22,
            color: Colors.white
        ),
        elevation: 20,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:primaryLight,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: primaryLight
    ),
    textTheme: TextTheme(
      bodyLarge:GoogleFonts.workSans(
        color: Colors.white,
          fontSize:25,
          fontWeight: FontWeight.w600
      ),
      titleMedium: GoogleFonts.workSans(
        color: Colors.white,
        fontSize:15,
      ),
      bodyMedium: GoogleFonts.workSans(
        color: Colors.black,
        fontSize: 20,
      ),
      titleSmall: GoogleFonts.workSans(
        color: Colors.grey[500],
        fontSize: 15,
      ),
      displayLarge:  GoogleFonts.workSans(
        color: Colors.white,
        fontSize:18,
      ),
      displayMedium:  GoogleFonts.workSans(
        color: Colors.white,
        fontSize:25,
      ),
      labelSmall: GoogleFonts.workSans(),
      headlineMedium: GoogleFonts.workSans(),
      displaySmall: GoogleFonts.workSans(),
      headlineSmall: GoogleFonts.workSans(),
    ),
  );

  Widget icon=Icon(Icons.brightness_7);
  bool dark=false;
  void changeThemeMode({bool? fromShared}) async{
    if(fromShared!=null){
      dark = fromShared;
      icon=dark?Icon(CommunityMaterialIcons.weather_night):Icon(Icons.brightness_7);

      emit(ChangeAppThemeState());
    }
    else {
      dark = !dark;
      MyShared.saveData(key: "dark", value: dark).then((value) {
        icon=dark?Icon(CommunityMaterialIcons.weather_night):Icon(Icons.brightness_7);
        emit(ChangeAppThemeState());
      });
    }

  }
}