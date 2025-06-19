import 'package:employee_management_system/core/app_exports.dart';

class SmallCard extends StatelessWidget {
  const SmallCard({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.25.sw,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 0.005.sh),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontFamily: 'Poppins',
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
