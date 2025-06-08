import 'package:employee_management_system/core/app_exports.dart';

class EmpController extends GetxController {
  var employeeList = <UserModel>[].obs;
  final _hrService = HrServices();
  final _authController = Get.find<AuthController>();

  var isloading = false.obs;
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

  Future<void> approveReject(String id, bool isApproved) async {
    try {
      await _hrService.updateApprovalStatus(id, isApproved);
      fetchAllEmp();
      showCustomDialog(
        icon: FontAwesomeIcons.solidCircleCheck,
        title: isApproved ? 'Employee Approved' : 'Employee Rejected',
        message: 'Now Employee got Authorities',
        buttonText: 'Continue',
        onPressed: () => Get.offAll(HRDashboard()),
      );
    } catch (e) {
      _authController.handleFirebaseError(e);
    } finally {
      isloading.value = false;
    }
  }
}
