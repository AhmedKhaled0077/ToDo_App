import 'package:flutter/material.dart';
import 'package:full_app2/shared/Components/components.dart';
import 'package:full_app2/shared/Components/constants.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        itemBuilder: (context, index) => BuildTaskItems(
              title: tasks[index]["title"] ?? "",
              time: tasks[index]["time"] ?? "",
              date: tasks[index]["date"] ?? "",
            ),
        separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
        itemCount: tasks.length);
  }
}
