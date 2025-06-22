import 'package:employee_management_system/core/app_exports.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextInputType type;
  final TextEditingController controller;
  final IconData? suffix;
  final IconData? prefix;
  final VoidCallback? onTap;
  final bool isPass;
  final String? Function(String?)? validator;
  final VoidCallback? onTapField;
  final bool isReadOnly;
  final void Function(String)? onChange;
  const CustomTextField({
    required this.labelText,
    required this.type,
    required this.controller,
    this.suffix,
    this.prefix,
    this.onTap,
    this.isPass = false,
    required this.validator,
    this.onTapField,
    this.isReadOnly = false,
    this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      onTap: onTapField,
      keyboardType: type,
      controller: controller,
      obscureText: isPass,
      validator: validator,
      onChanged: onChange,
      decoration: InputDecoration(
        prefixIcon: prefix != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                child: FaIcon(prefix),
              )
            : null,
        enabledBorder: AppTextFieldStyles.enabledBorder,
        focusedBorder: AppTextFieldStyles.focusedBorder,
        errorBorder: AppTextFieldStyles.errorBorder,
        focusedErrorBorder: AppTextFieldStyles.focusedBorder,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        labelText: labelText,
        labelStyle: AppTextStyles.textField,
        suffixIcon: suffix != null
            ? IconButton(onPressed: onTap, icon: FaIcon(suffix))
            : null,
      ),
    );
  }
}
