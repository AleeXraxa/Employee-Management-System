import 'package:employee_management_system/core/app_exports.dart';

class AppTextFieldStyles {
  static OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: const BorderSide(
      color: AppColors.gray,
      width: 0.5,
    ),
  );
  static OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: const BorderSide(
      color: AppColors.primaryColor,
      width: 1,
    ),
  );
  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: const BorderSide(
      color: AppColors.red,
      width: 1,
    ),
  );
}
