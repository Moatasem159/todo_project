import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/Shared_Preferences.dart';
import 'package:todo/app.dart';
import 'package:todo/bloc_observer.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await MyShared.init();
  bool ? isMainDark=MyShared.getData(key: "dark");
  runApp(MyApp(isDark: isMainDark));
}