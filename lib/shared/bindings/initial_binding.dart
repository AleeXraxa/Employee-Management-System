import 'package:employee_management_system/Features/HR%20Dashboard/controllers/emp_controller.dart';
import 'package:employee_management_system/core/app_exports.dart';
import 'package:employee_management_system/shared/controllers/internet_checker.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PassController());
    Get.put(AuthController());
    Get.put(EmpController());
    Get.put<InternetChecker>(InternetChecker(), permanent: true);
  }
}
