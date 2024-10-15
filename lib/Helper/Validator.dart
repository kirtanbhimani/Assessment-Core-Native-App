class Validators {
  // Validate first name (non-empty and alphabetic)
  static String? validateFirstName(String value) {
    if (value.isEmpty) {
      return 'First name cannot be empty';
    }
    final regex = RegExp(r'^[a-zA-Z]+$');
    if (!regex.hasMatch(value)) {
      return 'First name can contain only letters';
    }
    return null;
  }

  // Validate contact number (exactly 10 digits)
  static String? validateContactNumber(String value) {
    final regex = RegExp(r'^\d{10}$');
    if (!regex.hasMatch(value)) {
      return 'Contact number must be exactly 10 digits';
    }
    return null;
  }

  // Validate email format
  static String? validateEmail(String value) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Validate pincode (exactly 6 digits)
  static String? validatePincode(String value) {
    final regex = RegExp(r'^\d{6}$');
    if (!regex.hasMatch(value)) {
      return 'Pincode must be exactly 6 digits';
    }
    return null;
  }

  // Validate non-empty fields
  static String? validateNonEmpty(String value, String fieldName) {
    if (value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  // Validate numeric fields
  static String? validateNumeric(String value, String fieldName) {
    if (double.tryParse(value) == null) {
      return '$fieldName must be a number';
    }
    return null;
  }
}