import 'package:flutter/material.dart';
import '../model/student.dart';
class StudentRepository with ChangeNotifier {
  final List<Student> _students = [];

  List<Student> get students => _students;

  // Add a new student
  void addStudent(Student student) {
    _students.add(student);
    notifyListeners();
  }

  // Remove a student by ID
  bool removeStudent(String id) {
    final student = getStudentById(id);
    if (student != null) {
      _students.remove(student);
      notifyListeners();
      return true;
    }
    return false;
  }

  // Get a student by ID using a for-loop
  Student? getStudentById(String id) {
    for (var student in _students) {
      if (student.id == id) {
        return student;
      }
    }
    return null; // Student not found
  }

  // Get students by Faculty ID
  List<Student> getStudentsByFaculty(String facultyId) {
    return _students.where((s) => s.facultyId == facultyId).toList();
  }

  // Update student marks
  bool updateStudentMarks(String id, double marks) {
    final student = getStudentById(id);
    if (student != null) {
      student.marks = marks;
      notifyListeners();
      return true;
    }
    return false;
  }
}