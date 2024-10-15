import 'package:core_native_app/Screen/Counsellor_Deshboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import 'faculty_dashboard.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  void _navigate(BuildContext context, UserRole role) {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Name cannot be empty')),
      );
      return;
    }

    final user = User(id: UniqueKey().toString(), name: name, role: role);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => role == UserRole.Counsellor
            ? CounsellorDashboard(user: user)
            : FacultyDashboard(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Student Management System - Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Select Role and Enter Name', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _navigate(context, UserRole.Counsellor),
                child: Text('Login as Counsellor'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _navigate(context, UserRole.Faculty),
                child: Text('Login as Faculty'),
              ),
            ],
          ),
        ));
  }
}