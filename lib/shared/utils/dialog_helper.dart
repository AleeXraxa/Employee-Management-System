import 'package:employee_management_system/core/app_exports.dart';

void showCustomDialog({
  required IconData icon,
  required String title,
  required String message,
  String buttonText = 'OK',
  VoidCallback? onPressed,
}) {
  showDialog(
    context: Get.context!,
    builder: (_) => CustomDialog(
      icon: icon,
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed ?? () => Get.back(),
    ),
  );
}
