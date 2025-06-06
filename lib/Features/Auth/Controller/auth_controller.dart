import 'package:employee_management_system/core/app_exports.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();

  void clearFields() {
    emailController.clear();
    passController.clear();
    nameController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
