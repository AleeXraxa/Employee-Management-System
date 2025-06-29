import 'package:employee_management_system/core/app_exports.dart';

class PayrollController extends GetxController {
  final isLoading = false.obs;

  final presentDays = 0.obs;
  final absentDays = 0.obs;
  final leaveDays = 0.obs;
  final basicSalary = 0.0.obs;
  final totalSalary = 0.0.obs;
  final bonus = 0.0.obs;

  Future<void> createPayroll(String employeeId, double dailyWage) async {
    try {
      isLoading.value = true;

      final data = await PayrollService.generatePayrollForEmployee(
        employeeId: employeeId,
        dailyWage: dailyWage,
      );
      presentDays.value = data['present'];
      absentDays.value = data['absent'];
      leaveDays.value = data['leave'];
      basicSalary.value = data['basic'];
      totalSalary.value = data['total'];
      bonus.value = data['bonus'];
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate payroll: $e');
    } finally {
      isLoading.value = false;
    }
  }

  final RxList<double> weeklyHours = List.filled(7, 0.0).obs;

  Future<void> fetchMonthlyWorkingHours(String empId) async {
    weeklyHours.value =
        await PayrollService.getWeeklyAverageWorkingHours(empId);
  }
}
