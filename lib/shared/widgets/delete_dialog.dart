import 'package:employee_management_system/core/app_exports.dart';

class DeleteDialog extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String confirmText;
  final Future<void> Function() onConfirmed;

  const DeleteDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.onConfirmed,
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
            FaIcon(icon, size: 50, color: AppColors.primaryColor),
            const SizedBox(height: 20),
            Text(title,
                style: AppTextStyles.screentitle, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Text(message,
                style: AppTextStyles.bodyTextMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    onPressed: onConfirmed,
                    child: Text(
                      confirmText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
