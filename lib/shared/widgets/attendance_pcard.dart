import 'package:employee_management_system/core/app_exports.dart';

class Attendancepcard extends StatelessWidget {
  const Attendancepcard({
    super.key,
    required this.employee,
    required this.attendance,
  });

  final UserModel employee;
  final AttendanceModel attendance;

  @override
  Widget build(BuildContext context) {
    final attendanceController = Get.find<AttendanceController>();

    final dateStr = attendanceController.formatDate(attendance.date);
    final checkInStr = attendanceController.formatTime(attendance.checkIn!);
    final checkOutStr = attendance.checkOut != null
        ? attendanceController.formatTime(attendance.checkOut!)
        : 'Pending';

    final workedDuration = attendanceController.getWorkedDuration(
      attendance.checkIn,
      attendance.checkOut,
    );

    final String name = (employee.fname.isEmpty && employee.lname.isEmpty)
        ? employee.username
        : '${employee.fname} ${employee.lname}';

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
                      name,
                      style: AppTextStyles.title,
                    ),
                    Text(
                      '${employee.role}',
                      style: AppTextStyles.bodyTextMedium,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 0.02.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallCard(title: 'Date', value: dateStr),
                SmallCard(title: 'In Time', value: checkInStr),
                SmallCard(title: 'Out Time', value: checkOutStr),
              ],
            ),
            SizedBox(height: 0.03.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    WorkProgressIndicator(
                      timeSpent: attendanceController.getWorkedDurationRaw(
                          attendance.checkIn, attendance.checkOut),
                    ),
                    SizedBox(width: 0.02.sw),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workedDuration,
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
                attendance.status == 'present'
                    ? SizedBox.shrink()
                    : secondaryBtn(
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
