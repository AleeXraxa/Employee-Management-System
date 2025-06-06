import '../../core/app_exports.dart';

class SocialButton extends StatelessWidget {
  final String btnText;
  final String img;
  final VoidCallback? ontap;

  const SocialButton({
    required this.btnText,
    required this.img,
    this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.gray,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                img,
                width: 0.08.sw,
              ),
              SizedBox(width: 0.05.sw),
              Text(
                btnText,
                style: AppTextStyles.bodyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
