import 'package:core_native_app/Screen/Marks_Updation.dart';
import 'package:core_native_app/Screen/View_Student.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class FacultyDashboard extends StatelessWidget {
  final User user;

  FacultyDashboard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Dashboard - ${user.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text('View My Students'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewStudent()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Update Student Marks'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MarksUpdation(user: user)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}