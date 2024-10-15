import 'package:core_native_app/Helper/Validator.dart';
import 'package:core_native_app/Repository/Student_Repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import '../model/student.dart';
import '../service/log_service.dart';

class MarksUpdation extends StatefulWidget {
  final User user; // User property to identify the faculty

  MarksUpdation({required this.user}); // Constructor accepting User

  @override
  _MarksUpdationState createState() => _MarksUpdationState();
}

class _MarksUpdationState extends State<MarksUpdation> {

  @override
  void dispose() {
    _idController.dispose();
    _marksController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _idController = TextEditingController();
  final _marksController = TextEditingController();

  bool _isUpdating = false; // Flag to manage loading state

  @override
  Widget build(BuildContext context) {
    final studentRepo = Provider.of<StudentRepository>(context, listen: false);
    final logService = LogService(); // Instantiate LogService
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student Marks'),
      ),
      body: _isUpdating
          ? Center(child: CircularProgressIndicator()) // Show loader if updating
          : Padding(
              padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey, // Assign form key
                  child: Column(
                    children: [
                    // Student ID Field
                    TextFormField(
                      controller: _idController,
                      decoration: InputDecoration(
                        labelText: 'Enter Student ID',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                        return 'Student ID cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // Marks Field
                    TextFormField(
                      controller: _marksController,
                      decoration: InputDecoration(
                        labelText: 'Enter New Marks',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                        Validators.validateNumeric(value!.trim(), 'Marks'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                      // Validate the form fields
                      if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isUpdating = true; // Show loader
                      });
                      try {
                        final id = _idController.text.trim();
                        final marksStr = _marksController.text.trim();
                        final marks = double.parse(marksStr);

                      // Retrieve the student by ID
                      final student = studentRepo.getStudentById(id);
                      if (student == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Student not found')),
                        );
                        setState(() {
                          _isUpdating = false;
                        });
                        return;
                      }

                      // Check if the faculty can update this student's marks
                      if (widget.user.role == UserRole.Faculty &&
                          student.facultyId != widget.user.id) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Access denied to update marks')),
                        );
                        setState(() {
                          _isUpdating = false;
                        });
                        return;
                      }

                      // Update the student's marks
                      final success =
                      studentRepo.updateStudentMarks(id, marks);
                      if (success) {
                        await logService.log(
                            '${widget.user.role == UserRole.Counsellor ? "Counsellor" : "Faculty"} ${widget.user.name} updated marks for student $id to $marks');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Marks updated successfully')),
                        );
                        // Clear the input fields
                        _idController.clear();
                        _marksController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to update marks')),
                        );
                      }
                    } catch (e) {
                      // Handle unexpected errors
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    } finally {
                      setState(() {
                        _isUpdating = false; // Hide loader
                      });
                    }
                  }
                },
                      child: Text('Update Marks'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
