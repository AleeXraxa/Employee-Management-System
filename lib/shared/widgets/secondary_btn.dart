import 'package:employee_management_system/core/app_exports.dart';

class SecondaryBtn extends StatelessWidget {
  final String btnText;
  final Color bgcolor;
  final VoidCallback onTap;

  const SecondaryBtn(
      {super.key,
      required this.btnText,
      required this.bgcolor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
      ),
      child: Text(
        btnText,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
