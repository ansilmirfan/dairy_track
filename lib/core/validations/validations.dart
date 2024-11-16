class Validations {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone number must contain only digits';
    }
    return null;
  }

  static String? validateLicense(String? value) {
    if (value == null || value.isEmpty) {
      return 'License number is required for drivers';
    }
    if (value.length < 10) {
      return 'License number must be at least 10 characters long';
    }
    return null;
  }

  static String? validatePlace(String? value) {
    if (value == null || value.isEmpty) {
      return 'Place name is required';
    }
    if (value.length < 3) {
      return 'Place name must be at least 3 characters long';
    }
    if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
      return 'Place name can only contain letters, numbers, and spaces';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }
    final number = num.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    return null;
  }
}
