import 'package:flutter/material.dart';
import 'package:full_app2/module/ArchivedScreen/ArchivedScreen.dart';
import 'package:full_app2/module/DoneScreen/DoneScreen.dart';
import 'package:full_app2/module/TasksScreen/TasksScreen.dart';

class TodoHomescreen extends StatefulWidget {
  @override
  State<TodoHomescreen> createState() => _TodoHomescreenState();
}

class _TodoHomescreenState extends State<TodoHomescreen> {
  int Index = 0;
  List<Widget> Screen_Selected = [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen()
  ];

  List<String> SelectedTitle = ["TasksScreen", "DoneScreen", "ArchivedScreen"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SelectedTitle[Index]),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
        splashColor: Colors.tealAccent,
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

  void Create_DataBase() {}

  void InsertTo_DataBase() {}
}
