import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/Cubit/bottom_nav_cubit/bottom_nav_state.dart';
import 'package:todo/screens/ArchivedScreen.dart';
import 'package:todo/screens/DoneScreen.dart';
import 'package:todo/screens/TasksScreen.dart';

class BottomNavCubit extends Cubit<BottomNavStates> {
  BottomNavCubit() : super(BottomNavInitialState());
  static BottomNavCubit get(context)=>BlocProvider.of(context);

  TextEditingController titleController=TextEditingController();
  TextEditingController timeController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  var scaffoldKey=GlobalKey<ScaffoldState>();
  int current = 0;
  List<BottomNavigationBarItem> navigationItems =
  [
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.listCheck), label: "Tasks"),
    BottomNavigationBarItem(icon: Icon(Icons.check_box_outlined), label: "Done Tasks"),
    BottomNavigationBarItem(icon: Icon(Icons.archive_outlined), label: "Archive"),];
  List<Widget> screens =
  [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen()
  ];
  List<String>title =
  [
    "Tasks",
    "Done Tasks",
    "Archive Tasks",
  ];

  void changeIndex(int index){
    current=index;
    emit(ChangeBottomNavBarState());
  }


  bool isBottomSheetShown=false;
  IconData fabIcon=Icons.edit;
  void changeBottomSheet({bool? isShow, IconData? icon}){

    isBottomSheetShown=isShow!;
    fabIcon=icon!;
    emit(ChangeBottomSheetState());
  }
}
