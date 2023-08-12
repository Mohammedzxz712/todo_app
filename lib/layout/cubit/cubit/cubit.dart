import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/layout/cubit/states/states.dart';
import 'package:todo_app/modules/archive_screen/archive_screen.dart';
import 'package:todo_app/modules/done_screen/done_screen.dart';
import 'package:todo_app/modules/new_screen/new_screen.dart';

import '../../../modules/setting_screen/setting_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Iconsax.home),
      label: 'Task',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Iconsax.activity),
      label: 'Done',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Iconsax.archive),
      label: 'Archive',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Iconsax.setting),
      label: 'Setting',
    ),
  ];

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasks(),
    DoneScreen(),
    ArchiveScreen(),
    SettingScreen(),
  ];

  List<String> titles = [
    'NewTasks',
    'DoneScreen',
    'ArchiveScreen',
    'SettingScreen',
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeNavAppState());
  }

  IconData changeFab = Iconsax.edit;
  bool changeFloatingButton = false;

  void changeFabIcon({required bool isShow, required IconData icon}) {
    changeFab = icon;
    changeFloatingButton = isShow;
    emit(ChangeFapAppState());
  }

  late Database database;

  List<dynamic> newTasks = [];
  List<dynamic> doneTasks = [];
  List<dynamic> archiveTasks = [];
  void createDatabase() async {
    database = await openDatabase(
      'todoApp.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                'CREATE TABLE TASKS (id integer primary key , taskName text , date text , startTime text, endTime text ,description text , status text)')
            .then((value) {
          print('table created');
          emit(OnCreateSuccessState());
        }).catchError((error) {
          emit(OnCreateErrorState());
          throw Exception(error.toString());
        });
      },
      onOpen: (database) {
        getData(database);
        emit(OnOpenState());
      },
    );
  }

  void insertDatabase({
    required String taskName,
    required String date,
    required String startTime,
    required String endTime,
    required String description,
  }) {
    database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO TASKS(taskName, date, startTime,endTime,description , status)'
              ' VALUES("$taskName", "$date", "$startTime" ,"$endTime" , "$description" ,"new")')
          .then((value) {
        emit(InsertDataState());
        print('task $value');
      });
    }).then((value) {
      getData(database);
      emit(GetDataSuccessState());
    });
  }

  void getData(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    database.rawQuery('SELECT * FROM TASKS').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else if (element['status'] == 'archive') {
          archiveTasks.add(element);
        } else if (element['status'] == 'delete') {
          deleteRecord(id: element['id']).then((value) {
            print('record deleted ${element['id']}');
          });
        }
      });
      emit(GetDataSuccessState());
    });
  }

  void updateData({required String status, required int id}) {
    database.rawUpdate('UPDATE TASKS SET status = ?  WHERE id = ?',
        [status, id]).then((value) {
      getData(database);
      emit(UpdateState());
    });
  }

  Future<dynamic> deleteRecord({required int id}) {
    return database
        .rawDelete('DELETE FROM TASKS  WHERE id = ?', [id]).then((value) {
      emit(DeleteState());
      print('the record $value deleted');
    });
  }
}
