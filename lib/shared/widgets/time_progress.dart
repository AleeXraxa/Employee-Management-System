import 'package:employee_management_system/core/app_exports.dart';

class WorkProgressIndicator extends StatelessWidget {
  const WorkProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    const shiftDuration = Duration(hours: 8);
    const timeSpent = Duration(hours: 5, minutes: 30);

    final percent = timeSpent.inSeconds / shiftDuration.inSeconds;
    final hours = timeSpent.inHours;
    final minutes = timeSpent.inMinutes.remainder(60);

    return Center(
      child: CircularPercentIndicator(
        radius: 35.0,
        lineWidth: 5.0,
        animation: true,
        percent: percent.clamp(0.0, 1.0),
        center: Text(
          'P',
          style: TextStyle(
            fontSize: 40.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
            fontFamily: 'Poppins',
          ),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: Colors.grey[300]!,
        progressColor: AppColors.primaryColor,
      ),
    );
  }
}
