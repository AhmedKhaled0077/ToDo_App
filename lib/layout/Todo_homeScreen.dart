import 'package:flutter/material.dart';
import 'package:full_app2/module/ArchivedScreen/ArchivedScreen.dart';
import 'package:full_app2/module/DoneScreen/DoneScreen.dart';
import 'package:full_app2/module/TasksScreen/TasksScreen.dart';
import 'package:full_app2/shared/Components/components.dart';
import 'package:full_app2/shared/Components/constants.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class TodoHomescreen extends StatefulWidget {
  const TodoHomescreen({super.key});

  @override
  State<TodoHomescreen> createState() => _TodoHomescreenState();
}

class _TodoHomescreenState extends State<TodoHomescreen> {
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var taskController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  bool isOpened_State = false;
  int Index = 0;
  IconData actionButton = Icons.edit;
  Database? database;
  List<Widget> Screen_Selected = [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen()
  ];

  List<String> SelectedTitle = ["TaskScreen", "DoneScreen", "ArchivedScreen"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Create_DataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScaffoldKey,
      appBar: AppBar(
        title: Text(SelectedTitle[Index]),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isOpened_State == true) {
            if (formKey.currentState!.validate()) {
              InsertTo_Database(taskController, dateController, timeController)
                  .then((value) {
                GetFrom_Database(database).then((value) {
                  setState(() {
                    tasks = value;
                    isOpened_State = false;
                    actionButton = Icons.edit;
                  });
                  Navigator.pop(context);
                });
              });
            }
          } else {
            setState(() {
              actionButton = Icons.add;
              taskController.clear();
              dateController.clear();
              timeController.clear();
            });
            isOpened_State = true;
            ScaffoldKey.currentState
                ?.showBottomSheet((context) => Container(
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultTextFormField(
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Task Title is required";
                                  }
                                  return null;
                                },
                                controller: taskController,
                                labelText: "Task Title",
                                textType: TextInputType.datetime,
                                prefixIcon: Icons.task_sharp),
                            SizedBox(
                              height: 25,
                            ),
                            defaultTextFormField(
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "date is required";
                                }
                                return null;
                              },
                              controller: dateController,
                              labelText: "Date",
                              textType: TextInputType.datetime,
                              prefixIcon: Icons.date_range,
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2050))
                                    .then((value) {
                                  if (value != null) {
                                    {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value);
                                    }
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            defaultTextFormField(
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "date is required";
                                }
                                return null;
                              },
                              controller: timeController,
                              labelText: "Time",
                              textType: TextInputType.datetime,
                              prefixIcon: Icons.lock_clock,
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  if (value != null) {
                                    timeController.text =
                                        value!.format(context).toString();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ))
                .closed
                .then((value) {
              setState(() {
                actionButton = Icons.edit;
              });

              isOpened_State = false;
            });
          }

          // InsertTo_Database("task1", "jan2000", "12PM");
        },
        backgroundColor: Colors.teal,
        splashColor: Colors.tealAccent,
        child: Icon(
          actionButton,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
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
      body: tasks.length == 0
          ? Center(child: CircularProgressIndicator())
          : Screen_Selected[Index],
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
    }, onOpen: (database) async {
      await GetFrom_Database(database).then((value) {
        setState(() {
          tasks = value;
        });
        print("table is Opened");
      });
    });
  }

  Future InsertTo_Database(
      @required task, @required date, @required time) async {
    return await database?.transaction((txn) async {
      await txn
          .rawInsert(
              "INSERT INTO tasks(title, date,time,status) VALUES ('${task.text}','${date.text}','${time.text}','NEW')")
          .then((value) {
        print("$value Inserted Sucessfully");
      }).catchError((error) {
        print("Error when inserting data ${error.toString()}");
      });
    });
  }

  Future<List<Map>> GetFrom_Database(database) async {
    return await database!.rawQuery("SELECT * FROM tasks");
  }
}
