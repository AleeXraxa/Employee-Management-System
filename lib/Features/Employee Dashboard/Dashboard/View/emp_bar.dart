import 'package:employee_management_system/core/app_exports.dart';

class EmployeeDashboard extends StatelessWidget {
  final UserModel employee;
  EmployeeDashboard({required this.employee, super.key});

  final BottomNavBarController controller = Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: _getScreen(controller.selectedIndex.value),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => UploadTaskImagesScreen(
                    employee: employee,
                  ));
            },
            backgroundColor: Colors.green,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, size: 32, color: Colors.white),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavBar(
            icons: [
              FontAwesomeIcons.house,
              FontAwesomeIcons.listCheck,
              FontAwesomeIcons.clipboardUser,
              FontAwesomeIcons.moneyCheck,
            ],
          ),
        ));
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return EmpDetails(employee: employee);
      case 1:
        return ViewAllTasks(
          employee: employee,
        );
      case 2:
        return ViewAllAttendance(
          employeeID: employee.uid,
        );
      case 3:
        return UploadTaskImagesScreen(
          employee: employee,
        );
      default:
        return EmpDetails(employee: employee);
    }
  }
}
