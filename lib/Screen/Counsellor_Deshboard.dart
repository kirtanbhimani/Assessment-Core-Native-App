import 'package:core_native_app/Screen/Add_Student.dart';
import 'package:core_native_app/Screen/Remove_Student.dart';
import 'package:core_native_app/Screen/Student_Detail.dart';
import 'package:core_native_app/Screen/View_Student.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class CounsellorDashboard extends StatelessWidget {
  final User user;

  CounsellorDashboard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counsellor Dashboard - ${user.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text('Add Student'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddStudent(user: user)),
                );
              },
            ),
            ElevatedButton(
              child: Text('View All Students'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewStudent()),
                );
              },
            ),
            ElevatedButton(
              child: Text('View Specific Student'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentDetail()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Remove Student'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RemoveStudentScreen(user: user)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}