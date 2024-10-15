import 'package:core_native_app/Helper/Validator.dart';
import 'package:core_native_app/Repository/Student_Repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import '../model/student.dart';
import '../service/log_service.dart';

class AddStudent extends StatefulWidget {
  final User user; // Define the user property

  AddStudent({required this.user}); // Update the constructor

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudent> {

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    _totalFeesController.dispose();
    _contactNumberController.dispose();
    _marksController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedCourse;
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();
  String? _selectedCity;
  final _totalFeesController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _marksController = TextEditingController();

  final List<String> _courses = [
    'Flutter',
    'Python',
    'Kotlin',
    'Java',
    'ReactNative'
  ];
  final List<String> _cities = [
    'Ahmedabad',
    'Surat',
    'Baroda',
    'Gandhinagar',
    'Rajkot'
  ];

  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final studentRepo = Provider.of<StudentRepository>(context, listen: false);
    final logService = LogService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
        backgroundColor: Colors.blue,
      ),
      body: _isSubmitting
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // First Name
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) =>
                      Validators.validateFirstName(value!.trim()),
                ),
                SizedBox(height: 10),
                // Last Name
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) =>
                      Validators.validateNonEmpty(value!.trim(), 'Last name'),
                ),
                SizedBox(height: 10),
                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => Validators.validateEmail(value!.trim()),
                ),
                SizedBox(height: 10),
                // Course Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Course'),
                  value: _selectedCourse,
                  items: _courses
                      .map((course) => DropdownMenuItem(
                    child: Text(course),
                    value: course,
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCourse = value;
                    });
                  },
                  validator: (value) =>
                  value == null ? 'Please select a course' : null,
                ),
                SizedBox(height: 10),
                // Address
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) =>
                      Validators.validateNonEmpty(value!.trim(), 'Address'),
                ),
                SizedBox(height: 10),
                // Pincode
                TextFormField(
                  controller: _pincodeController,
                  decoration: InputDecoration(labelText: 'Pincode'),
                  keyboardType: TextInputType.number,
                  validator: (value) => Validators.validatePincode(value!.trim()),
                ),
                SizedBox(height: 10),
                // City Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'City'),
                  value: _selectedCity,
                  items: _cities
                      .map((city) => DropdownMenuItem(
                    child: Text(city),
                    value: city,
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                    });
                  },
                  validator: (value) =>
                  value == null ? 'Please select a city' : null,
                ),
                SizedBox(height: 10),
                // Total Fees
                TextFormField(
                  controller: _totalFeesController,
                  decoration: InputDecoration(labelText: 'Total Fees'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      Validators.validateNumeric(value!.trim(), 'Total Fees'),
                ),
                SizedBox(height: 10),
                // Contact Number
                TextFormField(
                  controller: _contactNumberController,
                  decoration: InputDecoration(labelText: 'Contact Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      Validators.validateContactNumber(value!.trim()),
                ),
                SizedBox(height: 10),
                // Marks
                TextFormField(
                  controller: _marksController,
                  decoration: InputDecoration(labelText: 'Marks'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      Validators.validateNumeric(value!.trim(), 'Marks'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isSubmitting = true;
                      });
                      try {
                        final newStudent = Student(
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          email: _emailController.text.trim(),
                          course: _selectedCourse!,
                          address: _addressController.text.trim(),
                          pincode: _pincodeController.text.trim(),
                          city: _selectedCity!,
                          totalFees:
                          double.parse(_totalFeesController.text.trim()),
                          contactNumber:
                          _contactNumberController.text.trim(),
                          marks: double.parse(_marksController.text.trim()),
                          facultyId: widget.user.id, // Associate with faculty
                        );

                        studentRepo.addStudent(newStudent);
                        await logService.log(
                            '${widget.user.role == UserRole.Counsellor ? "Counsellor" : "Faculty"} ${widget.user.name} added student ${newStudent.id}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Student added successfully')),
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      } finally {
                        setState(() {
                          _isSubmitting = false;
                        });
                      }
                    }
                  },
                  child: Text('Add Student'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
