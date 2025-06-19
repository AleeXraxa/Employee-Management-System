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

    Get.put<InternetChecker>(InternetChecker(), permanent: true);
  }
}
