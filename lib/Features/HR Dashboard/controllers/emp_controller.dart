import 'package:employee_management_system/core/app_exports.dart';

class EmpController extends GetxController {
  var employeeList = <UserModel>[].obs;
  var isloading = false.obs;
  final _hrService = HrServices();
  final _authController = Get.find<AuthController>();

  @override
  void onInit() {
    fetchAllEmp();
    super.onInit();
  }

  void fetchAllEmp() async {
    try {
      isloading.value = true;
      final employees = await _hrService.getAllEmp();
      employeeList.assignAll(employees);
    } catch (e) {
      _authController.handleFirebaseError(e);
    } finally {
      isloading.value = false;
    }
  }
}
