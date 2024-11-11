String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a name';
  }
  if (value.length < 2) {
    return 'Name must be at least 2 characters';
  }
  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return 'Name can only contain letters and spaces';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  }

  // RegEx pattern for email validation
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    caseSensitive: false,
  );

  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }

  return null;
}
