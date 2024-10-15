import 'package:uuid/uuid.dart';

class Student {
  final String id;
  String firstName;
  String lastName;
  String email;
  String course;
  String address;
  String pincode;
  String city;
  double totalFees;
  String contactNumber;
  double marks;
  String facultyId; // To associate student with faculty

  Student({
    String? id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.course,
    required this.address,
    required this.pincode,
    required this.city,
    required this.totalFees,
    required this.contactNumber,
    required this.marks,
    required this.facultyId,
  }) : this.id = id ?? Uuid().v4();
}