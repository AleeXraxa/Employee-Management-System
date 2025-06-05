class AppValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is Required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid Email';
    }
    return null;
  }

  static String? validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is Required';
    }
    if (value.length < 6) {
      return 'Password must be atleast 6 characters long';
    }
    return null;
  }

  static String? validateName(String? value, String field) {
    if (value == null || value.isEmpty) {
      return '$field is Required';
    }
    return null;
  }

  static String? requiredFiled(String? value, String field) {
    if (value == null || value.isEmpty) {
      return '$field is Required';
    }
    return null;
  }
}
