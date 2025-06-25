import 'package:employee_management_system/core/app_exports.dart';

Future<void> showTimePickerAndSetText({
  required BuildContext context,
  required TextEditingController controller,
}) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (picked != null) {
    final formattedTime = picked.format(context);
    controller.text = formattedTime;
  }
}
