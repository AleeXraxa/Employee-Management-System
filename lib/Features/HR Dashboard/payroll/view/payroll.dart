import 'package:employee_management_system/core/app_exports.dart';

class Payroll extends StatefulWidget {
  final UserModel employee;
  const Payroll({super.key, required this.employee});

  @override
  State<Payroll> createState() => _Payroll();
}

class _Payroll extends State<Payroll> {
  final payrollController = Get.find<PayrollController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = widget.employee.uid;
      if (user.isNotEmpty) {
        payrollController.createPayroll(user, 2000);
        payrollController.fetchMonthlyWorkingHours(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.1.sh,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Payroll Management",
            style: AppTextStyles.screenName,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 0.03.sh),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Working Hours: ',
                          style: AppTextStyles.title,
                        ),
                        SizedBox(height: 0.02.sh),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  final total = payrollController.weeklyHours
                                      .fold(0.0, (a, b) => a + b);
                                  final h = total.toInt();
                                  final m = ((total - h) * 60).round();
                                  return Text(
                                    '$h h $m min',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  );
                                }),
                                Text(
                                  'Monthly',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                    color: AppColors.gray,
                                  ),
                                ),
                                SizedBox(height: 0.03.sh),
                                Obx(() => WeeklyBarChart(
                                    hours: payrollController.weeklyHours
                                        .toList())),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 0.02.sh),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Attendance: ',
                                    style: AppTextStyles.title,
                                  ),
                                  Text(
                                    'January 2025 ',
                                    style: AppTextStyles.bodyTextMediumB,
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.02.sh),
                              Obx(() => GridView.count(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    physics: NeverScrollableScrollPhysics(),
                                    childAspectRatio: 1.6,
                                    shrinkWrap: true,
                                    children: [
                                      PayrollCard(
                                          title: 'Present',
                                          value:
                                              '${payrollController.presentDays}'),
                                      PayrollCard(
                                          title: 'Absent',
                                          value:
                                              '${payrollController.absentDays}'),
                                      PayrollCard(
                                          title: 'Leave',
                                          value:
                                              '${payrollController.leaveDays}'),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 0.03.sh),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payroll:  ',
                                style: AppTextStyles.title,
                              ),
                              SizedBox(height: 0.02.sh),
                              Obx(
                                () => GridView.count(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  physics: NeverScrollableScrollPhysics(),
                                  childAspectRatio: 1.6,
                                  shrinkWrap: true,
                                  children: [
                                    PayrollCard(
                                        title: payrollController.basicSalary
                                            .toStringAsFixed(0),
                                        value: 'Basic'),
                                    PayrollCard(
                                        title: payrollController.bonus.value
                                            .toStringAsFixed(0),
                                        value: 'Extra Bonus'),
                                    PayrollCard(
                                        title: payrollController
                                            .totalSalary.value
                                            .toStringAsFixed(0),
                                        value: 'Total'),
                                  ],
                                ),
                              ),
                              SizedBox(height: 0.08.sh),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
