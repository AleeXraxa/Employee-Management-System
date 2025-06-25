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
    final authController = Get.find<AuthController>();

    final dateStr = attendanceController.formatDate(attendance.date);
    final checkInStr = attendance.checkIn != null
        ? attendanceController.formatTime(attendance.checkIn!)
        : 'Pending';
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

    final isPending = attendance.checkIn == null && attendance.checkOut == null;
    final isCheckedIn =
        attendance.checkIn != null && attendance.checkOut == null;
    // final isCheckedOut =
    //     attendance.checkIn != null && attendance.checkOut != null;

    final isAdmin = authController.currentUser.value?.role == 'Admin';
    final isAbsent = attendance.status == 'absent';

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          children: [
            // Avatar & Name
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                ),
                SizedBox(width: 0.02.sw),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.title),
                    Text(employee.role, style: AppTextStyles.bodyTextMedium),
                  ],
                ),
              ],
            ),
            SizedBox(height: 0.02.sh),

            // Date, CheckIn, CheckOut
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallCard(title: 'Date', value: dateStr),
                SmallCard(title: 'In Time', value: checkInStr),
                SmallCard(title: 'Out Time', value: checkOutStr),
              ],
            ),
            SizedBox(height: 0.03.sh),

            // Work Progress & Action Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    WorkProgressIndicator(
                      timeSpent: attendanceController.getWorkedDurationRaw(
                        attendance.checkIn,
                        attendance.checkOut,
                      ),
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

                /// 👇 Action Area: Dynamic Button or Nothing
                Builder(
                  builder: (_) {
                    if (isAdmin) {
                      if (isPending && !isAbsent) {
                        return SecondaryBtn(
                          btnText: 'Mark Absent',
                          bgcolor: Colors.red,
                          onTap: () {
                            attendanceController.markAbsent(employee);
                          },
                        );
                      } else if (isAbsent) {
                        return SecondaryBtn(
                          btnText: 'Present',
                          bgcolor: AppColors.primaryColor,
                          onTap: () {
                            attendanceController.addTodayAttendance(employee);
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    } else {
                      // EMPLOYEE side
                      if (isAbsent) {
                        return const SizedBox(); // 🔒 No Check In or Out
                      } else if (isPending) {
                        return SecondaryBtn(
                          btnText: 'Check In',
                          bgcolor: AppColors.primaryColor,
                          onTap: () {
                            attendanceController.markCheckIn();
                          },
                        );
                      } else if (isCheckedIn) {
                        return SecondaryBtn(
                          btnText: 'Check Out',
                          bgcolor: AppColors.primaryColor,
                          onTap: () {
                            attendanceController.markCheckOut();
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
