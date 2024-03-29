import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/States.dart';
import 'package:todo/Cubit/ThemeCubit.dart';
import 'package:todo/Cubit/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:todo/Cubit/todo_cubit.dart';
import 'package:todo/screens/homescreen.dart';
class MyApp extends StatelessWidget {
  final bool ? isDark;
  const MyApp({ this.isDark});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => ToDoCubit()..createDataBase()),
        BlocProvider(create: (context) => ThemeCubit()..changeThemeMode(fromShared: isDark))
      ],
      child: BlocConsumer<ThemeCubit,ThemesStates>(
        listener: (BuildContext context, ThemesStates state) {},
        builder: (BuildContext context, ThemesStates state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:ThemeCubit.get(context).lightTheme,
            darkTheme:ThemeCubit.get(context).darkTheme,
            themeMode: ThemeCubit.get(context).dark? ThemeMode.dark: ThemeMode.light,
            home:Home()
          );
        },
      ), );
  }
}