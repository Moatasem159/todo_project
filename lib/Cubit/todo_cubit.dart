import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/screens/ArchivedScreen.dart';
import 'package:todo/Cubit/States.dart';
import 'package:todo/screens/DoneScreen.dart';
import 'package:todo/screens/TasksScreen.dart';

class ToDoCubit extends Cubit<ToDoStates>{
  ToDoCubit() : super(ToDoInitialState());
   static ToDoCubit get(context)=>BlocProvider.of(context);

  int current = 0;
  List<BottomNavigationBarItem> navigationItems =
  [
    BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.tasks), label: "Tasks"),
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
    emit(ToDoChangeBottomNavBarState());
  }


  bool isBottomSheetShown=false;
  IconData fabIcon=Icons.edit;
  void changeBottomSheet({bool? isShow, IconData? icon}){

    isBottomSheetShown=isShow!;
    fabIcon=icon!;
    emit(ToDoChangeBottomSheetState());
  }



  Database? dataBase;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archiveTasks=[];



  void createDataBase(){
     openDatabase('todo.db', version: 1,
      onCreate: (db, version) {
        print('database created');
        db.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((onError) {
          print(onError.toString());
        });
      },
      onOpen: (db) {
        getAllDataFromDataBase(db);
        print('database opened');
      },
    ).then((value){
      dataBase=value;
      emit(ToDoCreateDataBaseState());
     });
  }

   insertInDataBase({required String titleT,required String timeT,required String dateT})async{
    return await dataBase!.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$titleT","$dateT","$timeT","new")')
          .then((value) {
        print("$value inserted successfully ");
        emit(ToDoInsertInDataBaseState());
        getAllDataFromDataBase(dataBase);
      });

    });
  }


  void getAllDataFromDataBase(database){

    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    emit(ToDoGetAllDataFromDataBaseLoadingState());

    database!.rawQuery('SELECT * FROM tasks').then((value){

      value.forEach((element) {
        if(element['status']=='new'){
          newTasks.add(element);
        }
        else if(element['status']=='done')
          {
            doneTasks.add(element);
          }
        else if(element['status']=='archive')
        {
          archiveTasks.add(element);
        }
      });
      emit(ToDoGetAllDataFromDataBaseState());
    });

  }

  void updateData({required String status,required int id})async{
     dataBase!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
     ['$status',id],
     ).then((value){
       getAllDataFromDataBase(dataBase);
       emit(ToDoUpDateDataBaseState());
     });
  }

  void deleteData({required int idD})async{
     dataBase!.rawDelete('DELETE FROM tasks WHERE id = ?',
     [idD],
     ).then((value){
       getAllDataFromDataBase(dataBase);
       emit(ToDoDeleteDataBaseState());
     });
  }
}


