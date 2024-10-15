import 'package:core_native_app/Model/User.dart';
import 'package:core_native_app/Repository/Student_Repo.dart';
import 'package:core_native_app/Screen/Student_Detail.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../model/student.dart';

class ViewStudent extends StatefulWidget {
  const ViewStudent({super.key});

  @override
  State<ViewStudent> createState() => _ViewStudentState();
}

class _ViewStudentState extends State<ViewStudent> {

  late final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Student'),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<StudentRepository>(
        builder: (context, repo, child) {
          List<Student> students = user.role == UserRole.Counsellor
              ? repo.students
              : repo.getStudentsByFaculty(user.id);

          if (students.isEmpty) {
            return Center(child: Text('No students found.'));
          }

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return ListTile(
                title: Text('${student.firstName} ${student.lastName}'),
                subtitle: Text('Course: ${student.course} | Marks: ${student.marks}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentDetail()),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
