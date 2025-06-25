import 'package:employee_management_system/core/app_exports.dart';

class WorkProgressIndicator extends StatelessWidget {
  final Duration timeSpent;
  const WorkProgressIndicator({super.key, required this.timeSpent});

  @override
  Widget build(BuildContext context) {
    const shiftDuration = Duration(hours: 8);

    final percent = timeSpent.inSeconds / shiftDuration.inSeconds;
    // final hours = timeSpent.inHours;
    // final minutes = timeSpent.inMinutes.remainder(60);

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
