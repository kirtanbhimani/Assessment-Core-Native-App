import 'package:core_native_app/Repository/Student_Repo.dart';
import 'package:core_native_app/Screen/Confirm_Delete_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';

import '../service/log_service.dart';


class RemoveStudentScreen extends StatefulWidget {
  final User user; // Define the user property

  RemoveStudentScreen({required this.user}); // Update the constructor

  @override
  _RemoveStudentScreenState createState() => _RemoveStudentScreenState();
}

class _RemoveStudentScreenState extends State<RemoveStudentScreen> {
  final _idController = TextEditingController();
  bool _isRemoving = false;

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentRepo = Provider.of<StudentRepository>(context, listen: false);
    final logService = LogService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove Student'),
        backgroundColor: Colors.blue,
      ),
      body: _isRemoving
          ? Center(child: CircularProgressIndicator())
          : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
              TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'Enter Student ID to Remove',
                border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
              onPressed: () async {
                final id = _idController.text.trim();
                if (id.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Student ID cannot be empty')),
                  );
                  return;
                }

                final student = studentRepo.getStudentById(id);
                if (student == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Student not found')),
                  );
                  return;
                }

                // Show confirmation dialog
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => ConfirmDeleteDialog(),
                );

                if (confirm == true) {
                  setState(() {
                    _isRemoving = true;
                  });
                  final success = studentRepo.removeStudent(id);
                  if (success) {
                    await logService.log(
                        '${widget.user.role == UserRole.Counsellor ? "Counsellor" : "Faculty"} ${widget.user.name} removed student $id');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Student removed successfully')),
                    );
                    _idController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to remove student')),
                    );
                  }
                  setState(() {
                    _isRemoving = false;
                  });
                }
              },
                child: Text('Remove Student'),
            ),
          ],
        ),
      ),
    );
  }
}
