import 'package:employee_management_system/Features/HR%20Dashboard/payroll/controller/payroll_controller.dart';
import 'package:employee_management_system/core/app_exports.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PassController());
    Get.put(AuthController());
    Get.put(EmpController());
    Get.put(TaskController());
    Get.put(BottomNavBarController());
    Get.put(AttendanceController());
    Get.put(PayrollController());

    Get.put<InternetChecker>(InternetChecker(), permanent: true);
  }
}
