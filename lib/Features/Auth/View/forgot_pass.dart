import 'package:employee_management_system/core/app_exports.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 0.1.sh),
                  width: 0.3.sw,
                  height: 0.1.sh,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 0.02.sh),
                Text(
                  'Forgot Password',
                  style: AppTextStyles.screentitle,
                ),
                SizedBox(height: 0.01.sh),
                Text(
                  'Enter your email to reset your password',
                  style: AppTextStyles.bodyTextMedium,
                ),
                SizedBox(height: 0.025.sh),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          CustomTextField(
                            prefix: FontAwesomeIcons.solidEnvelope,
                            labelText: 'Email',
                            type: TextInputType.emailAddress,
                            controller: _authController.emailController,
                            validator: AppValidators.validateEmail,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.02.sh),
                Obx(
                  () => _authController.isloading.value
                      ? CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      : PrimaryButton(
                          text: 'Reset',
                          bgColor: AppColors.lightGreen,
                          ontap: () {
                            if (_formKey.currentState!.validate()) {
                              _authController.forgotPass();
                            }
                          },
                        ),
                ),
                TextButton(
                  onPressed: () {
                    _authController.clearFields();
                    Get.offAll(Login());
                  },
                  child: Text(
                    "Back to Login",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
