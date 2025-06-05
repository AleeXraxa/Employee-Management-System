import '../../core/app_exports.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final VoidCallback ontap;

  const PrimaryButton({
    required this.text,
    required this.bgColor,
    required this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: bgColor,
        padding: EdgeInsets.symmetric(horizontal: 140.w, vertical: 15.h),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
