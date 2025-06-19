import 'package:employee_management_system/Features/HR%20Dashboard/Main%20Dashboard/view/navbar.dart';
import 'package:employee_management_system/core/app_exports.dart';

class HRDashboard extends StatefulWidget {
  const HRDashboard({super.key});

  @override
  State<HRDashboard> createState() => _HRDashboardState();
}

class _HRDashboardState extends State<HRDashboard> {
  final _empController = Get.find<EmpController>();
  @override
  void initState() {
    super.initState();
    _empController.fetchAllEmp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Logo(),
              SizedBox(height: 0.02.sh),
              Text(
                'EMPLOYEE MANAGEMENT SYSTEM',
                style: AppTextStyles.title,
              ),
              SizedBox(height: 0.02.sh),
              Text(
                'Employee ID Login',
                style: AppTextStyles.screentitle,
              ),
              SizedBox(height: 0.01.sh),
              Text(
                "Enter Your Employee's Profile",
                style: AppTextStyles.bodyTextMedium,
              ),
              SizedBox(height: 0.025.sh),
              Container(
                height: 0.5.sh,
                child: Obx(
                  () {
                    if (_empController.isloading.value) {
                      return CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      );
                    }
                    if (_empController.employeeList.isEmpty) {
                      return Center(child: Text('No employees found'));
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: _empController.employeeList.length,
                        itemBuilder: (context, index) {
                          final emp = _empController.employeeList[index];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.cardColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            width: 350,
                            height: 120,
                            child: Row(
                              children: [
                                // Profile Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    'assets/images/logo.png', // Replace with your image path
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                // Text Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Employee ${index + 1} ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${emp.username.toUpperCase()}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Contact : 03030286354',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Select Button
                                secondaryBtn(
                                    btnText: 'Select',
                                    bgcolor: AppColors.primaryColor,
                                    onTap: () {
                                      Get.offAll(Dashboard(employee: emp));
                                    }),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
