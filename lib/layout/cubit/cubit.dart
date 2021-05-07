import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/layout/cubit/states.dart';
import 'package:flutter_app/modules/archive_tasks/archive_tasks_screen.dart';
import 'package:flutter_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:flutter_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class TodoCubit extends Cubit<TodoStates> {

  TodoCubit() : super(TodoInitialState());

  static TodoCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> myWidgets = [
    NewTasks(),
    DoneTasks(),
    ArchiveTasks(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(TodoChangeBottomNavState());
  }

  Database database;
  List<Map> newTasks;
  List<Map> doneTasks;
  List<Map> archivedTasks;


  void openDb()
  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, data TEXT, status TEXT)');
        print('database created');
      },
      onOpen: (Database db)
      {
        print('database opened');
        getData(db);
      },
    ).then((value) {
      database = value;
      emit(TodoCreateDatabaseSuccessState());
    }).catchError((error) {
      emit(TodoCreateDatabaseErrorState());
    });
  }

  void insertToDb({
    @required String title,
    @required String date,
  })
  {
    database.transaction((txn) async
    {
      int id = await txn.rawInsert(
          'INSERT INTO tasks(title, data, status) VALUES("$title", "$date", "new")');
      print('inserted: $id');
    }).then((value) {
      getData(database);
      emit(TodoInsertDatabaseSuccessState());
    }).catchError((error) {
      emit(TodoInsertDatabaseErrorState());
    });
  }

  void getData(db) {
    newTasks =[];
    doneTasks=[];
    archivedTasks=[];

    db.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element)
      {
          if(element['status'] == 'new')
            {
              newTasks.add(element);
            }
          if(element['status'] == 'done')
          {
            doneTasks.add(element);
          }
          if(element['status'] == 'archived')
          {
            archivedTasks.add(element);
          }
      });

      emit(TodoGetDatabaseSuccessState());
    }).catchError((error) {
      emit(TodoGetDatabaseErrorState());
    });
  }

  void updateData({
    @required int id,
    @required String status,
  }) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', '$id']).then((value) {
      getData(database);
      emit(TodoUpdateDatabaseSuccessState());
    }).catchError((error) {
      emit(TodoUpdateDatabaseErrorState());
    });
  }

  void deleteData(int id) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value) {
      getData(database);
      emit(TodoDeleteDatabaseSuccessState());
    }).catchError((error) {
      emit(TodoDeleteDatabaseErrorState());
    });
  }
}

