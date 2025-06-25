import 'package:employee_management_system/Features/HR%20Dashboard/payroll/view/weekly_chart.dart';
import 'package:employee_management_system/core/app_exports.dart';
import 'package:employee_management_system/shared/widgets/attendanc_tracker.dart';
import 'package:employee_management_system/shared/widgets/cards.dart';

class Payroll extends StatefulWidget {
  const Payroll({super.key});

  @override
  State<Payroll> createState() => _Payroll();
}

class _Payroll extends State<Payroll> {
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                                Text(
                                  '40 h 45 min',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(
                                  'Weekly',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                    color: AppColors.gray,
                                  ),
                                ),
                                SizedBox(height: 0.03.sh),
                                WeeklyBarChart(),
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
                              GridView.count(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                physics: NeverScrollableScrollPhysics(),
                                childAspectRatio: 1.6,
                                shrinkWrap: true,
                                children: [
                                  payroll_card(title: 'Present', value: '34'),
                                  payroll_card(title: 'Absent', value: '03'),
                                  payroll_card(title: 'Holiday', value: '02'),
                                  payroll_card(title: 'Half Day', value: '07'),
                                  payroll_card(title: 'Week Off', value: '03'),
                                  payroll_card(title: 'Leave', value: '05'),
                                ],
                              )
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
                              GridView.count(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                physics: NeverScrollableScrollPhysics(),
                                childAspectRatio: 1.6,
                                shrinkWrap: true,
                                children: [
                                  payroll_card(title: '50,000', value: 'Basic'),
                                  payroll_card(
                                      title: '20,000', value: 'Extra Bonus'),
                                  payroll_card(title: '70,000', value: 'Total'),
                                ],
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
