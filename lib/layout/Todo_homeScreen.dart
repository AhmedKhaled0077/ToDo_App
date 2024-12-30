import 'package:flutter/material.dart';
import 'package:full_app2/module/ArchivedScreen/ArchivedScreen.dart';
import 'package:full_app2/module/DoneScreen/DoneScreen.dart';
import 'package:full_app2/module/TasksScreen/TasksScreen.dart';
import 'package:sqflite/sqflite.dart';

class TodoHomescreen extends StatefulWidget {
  const TodoHomescreen({super.key});

  @override
  State<TodoHomescreen> createState() => _TodoHomescreenState();
}

class _TodoHomescreenState extends State<TodoHomescreen> {
  int Index = 0;
  Database? database;
  List<Widget> Screen_Selected = [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen()
  ];

  List<String> SelectedTitle = ["TasksScreen", "DoneScreen", "ArchivedScreen"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Create_DataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SelectedTitle[Index]),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // InsertTo_Database("task1", "jan2000", "12PM");
          InsertTo_Database();
        },
        backgroundColor: Colors.teal,
        splashColor: Colors.tealAccent,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.task_alt_outlined), label: "Done"),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: "Archived"),
        ],
        currentIndex: Index,
        onTap: (value) {
          setState(() {
            Index = value;
          });
        },
        fixedColor: Colors.teal,
        unselectedItemColor: Colors.black,
      ),
      body: Screen_Selected[Index],
    );
  }

  void Create_DataBase() async {
    database = await openDatabase("Todo.db", version: 1,
        onCreate: (database, version) async {
      print("database is created");
      await database
          .execute(
              "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)")
          .then((value) {
        print("table is created");
      }).catchError((error) {
        print("Error while creating table  ${error.toString()}");
      });
    }, onOpen: (database) {
      print("database is opend");
    });
  }

  Future InsertTo_Database(
      //  @required task, @required date, @required time
      ) async {
    return await database?.transaction((txn) async {
      await txn
          .rawInsert(
              //    "INSERT INTO tasks(title, date,time,status) VALUES ('$task', '$date','$time','New')")
              "INSERT INTO tasks(title, date,time,status) VALUES ('taskkk', 'ddate','ttime','New')")
          .then((value) {
        print("$value Inserted Sucessfully");
      }).catchError((error) {
        print("Error when inserting data ${error.toString()}");
      });
    });
  }
}
