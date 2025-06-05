import 'package:employee_management_system/core/app_exports.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextInputType type;
  final TextEditingController controller;
  final IconData? suffix;
  final VoidCallback? onTap;
  final bool isPass;

  const CustomTextField({
    required this.labelText,
    required this.type,
    required this.controller,
    this.suffix,
    this.onTap,
    this.isPass = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      controller: controller,
      obscureText: isPass,
      decoration: InputDecoration(
        enabledBorder: AppTextFieldStyles.enabledBorder,
        focusedBorder: AppTextFieldStyles.focusedBorder,
        errorBorder: AppTextFieldStyles.errorBorder,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        labelText: labelText,
        labelStyle: AppTextStyles.textField,
        suffixIcon: IconButton(onPressed: onTap, icon: Icon(suffix)),
      ),
    );
  }
}
