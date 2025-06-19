import 'package:employee_management_system/core/app_exports.dart';

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Attendance :',
                              style: AppTextStyles.title,
                            ),
                            Text(
                              'Janaury 2025',
                              style: AppTextStyles.bodyTextMediumB,
                            ),
                          ],
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
