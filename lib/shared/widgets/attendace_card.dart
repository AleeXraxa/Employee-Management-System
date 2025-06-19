import 'package:employee_management_system/core/app_exports.dart';

class AttendaceCard extends StatelessWidget {
  final String status;
  final String dateDay;
  final String timeIn;
  final String timeOut;
  const AttendaceCard({
    required this.status,
    required this.dateDay,
    required this.timeIn,
    required this.timeOut,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: SizedBox(
          width: double.infinity,
          height: 0.1.sh,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 0.02.sw,
                height: 0.09.sh,
                decoration: BoxDecoration(
                  color: status == 'Present'
                      ? AppColors.lightGreen
                      : AppColors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(width: 0.02.sw),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status,
                    style: AppTextStyles.bodyTextMedium,
                  ),
                  Text(
                    dateDay,
                    style: AppTextStyles.bodyText,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            timeIn,
                            style: AppTextStyles.bodyTextMedium,
                          ),
                          Text(
                            timeOut,
                            style: AppTextStyles.bodyTextMediumB,
                          ),
                        ],
                      ),
                      SizedBox(width: 0.05.sw),
                      Row(
                        children: [
                          Text(
                            'Clock In',
                            style: AppTextStyles.bodyTextMedium,
                          ),
                          Text(
                            '05: 02 PM',
                            style: AppTextStyles.bodyTextMediumB,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
