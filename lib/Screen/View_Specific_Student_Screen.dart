import 'package:core_native_app/Repository/Student_Repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import '../model/student.dart';

class ViewSpecificStudentScreen extends StatefulWidget {
  final User user; // Define the user property

  ViewSpecificStudentScreen({required this.user}); // Update the constructor

  @override
  _ViewSpecificStudentScreenState createState() => _ViewSpecificStudentScreenState();
}

class _ViewSpecificStudentScreenState extends State<ViewSpecificStudentScreen> {
  final _idController = TextEditingController();
  Student? _student; // Nullable Student
  bool _isFetching = false;


  @override
  Widget build(BuildContext context) {
    final studentRepo = Provider.of<StudentRepository>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('View Specific Student'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'Enter Student ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isFetching
                  ? null
                  : () async {
                final id = _idController.text.trim();
                if (id.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Student ID cannot be empty')),
                  );
                  return;
                }

                setState(() {
                  _isFetching = true;
                  _student = null;
                });

                final student = studentRepo.getStudentById(id);
                if (student != null) {
                  // For Faculty, ensure they can only view their own students
                  if (widget.user.role == UserRole.Faculty && student.facultyId != widget.user.id) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Access denied to view this student')),
                    );
                  } else {
                    setState(() {
                      _student = student;
                    });
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Student not found')),
                  );
                }

                setState(() {
                  _isFetching = false;
                });
              },
              child: Text('View Student'),
            ),
            SizedBox(height: 20),
            _student != null
                ? Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          DetailRow(label: 'ID', value: _student!.id),
                          DetailRow(label: 'First Name', value: _student!.firstName),
                          DetailRow(label: 'Last Name', value: _student!.lastName),
                          DetailRow(label: 'Email', value: _student!.email),
                          DetailRow(label: 'Course', value: _student!.course),
                          DetailRow(label: 'Address', value: _student!.address),
                          DetailRow(label: 'Pincode', value: _student!.pincode),
                          DetailRow(label: 'City', value: _student!.city),
                          DetailRow(label: 'Total Fees', value: '\$${_student!.totalFees}'),
                          DetailRow(label: 'Contact Number', value: _student!.contactNumber),
                          DetailRow(label: 'Marks', value: _student!.marks.toString()),
                          ],
                      ),
                    ),
                  ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
