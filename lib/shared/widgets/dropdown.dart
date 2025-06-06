import 'package:employee_management_system/core/app_exports.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final void Function(T?) onChanged;
  final String Function(T)? getLabel;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.getLabel,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.textField,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        enabledBorder: AppTextFieldStyles.enabledBorder,
        focusedBorder: AppTextFieldStyles.focusedBorder,
        filled: true,
        fillColor: Colors.transparent,
      ),
      icon: const FaIcon(FontAwesomeIcons.circleChevronDown),
      style: AppTextStyles.bodyTextMedium,
      isExpanded: true,
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child:
                    Text(getLabel != null ? getLabel!(item) : item.toString()),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
