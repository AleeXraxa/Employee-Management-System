import 'package:employee_management_system/core/app_exports.dart';

class PassController extends GetxController {
  final RxBool ispass = true.obs;

  void togglePass() {
    ispass.value = !ispass.value;
  }
}
