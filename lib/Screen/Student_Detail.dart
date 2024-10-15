import 'package:core_native_app/Model/Student.dart';
import 'package:flutter/material.dart';

import '../Model/User.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({super.key});

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {

  late final User user;
  late final Student student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
        backgroundColor: Colors.blue,
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DetailRow(label: 'ID', value: student.id),
            DetailRow(label: 'First Name', value: student.firstName),
            DetailRow(label: 'Last Name', value: student.lastName),
            DetailRow(label: 'Email', value: student.email),
            DetailRow(label: 'Course', value: student.course),
            DetailRow(label: 'Address', value: student.address),
            DetailRow(label: 'Pincode', value: student.pincode),
            DetailRow(label: 'City', value: student.city),
            DetailRow(label: 'Total Fees', value: '\$${student.totalFees}'),
            DetailRow(label: 'Contact Number', value: student.contactNumber),
            DetailRow(label: 'Marks', value: student.marks.toString()),
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