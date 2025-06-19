import 'package:employee_management_system/core/app_exports.dart';

class Attendance_pcard extends StatelessWidget {
  const Attendance_pcard({
    super.key,
    required this.employee,
  });

  final UserModel employee;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                ),
                SizedBox(width: 0.02.sw),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${employee.fname} ${employee.lname}',
                      style: AppTextStyles.title,
                    ),
                    Text(
                      '${employee.role}',
                      style: AppTextStyles.bodyTextMedium,
                    ),
                  ],
                ),
                SizedBox(height: 0.02.sh),
              ],
            ),
            SizedBox(height: 0.02.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallCard(
                  title: 'Date',
                  value: '03 Feb 2025',
                ),
                SmallCard(
                  title: 'In Time',
                  value: '09: 00 AM',
                ),
                SmallCard(
                  title: 'Out Time',
                  value: '05:00 PM',
                ),
              ],
            ),
            SizedBox(height: 0.03.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    WorkProgressIndicator(),
                    SizedBox(width: 0.02.sw),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '4h 12m 44s',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          'Of 8 Hours',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                secondaryBtn(
                  btnText: 'Present',
                  bgcolor: AppColors.primaryColor,
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
