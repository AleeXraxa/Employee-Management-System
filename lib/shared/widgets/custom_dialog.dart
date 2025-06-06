import 'package:employee_management_system/core/app_exports.dart';

class CustomDialog extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  const CustomDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: 50,
              color: AppColors.primaryColor,
            ), // Success Icon
            const SizedBox(height: 20),
            Text(title,
                style: AppTextStyles.screentitle, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Text(message,
                style: AppTextStyles.bodyTextMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            PrimaryButton(
                text: buttonText,
                bgColor: AppColors.primaryColor,
                ontap: onPressed),
          ],
        ),
      ),
    );
  }
}
