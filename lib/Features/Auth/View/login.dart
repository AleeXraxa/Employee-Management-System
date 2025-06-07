import 'package:employee_management_system/core/app_exports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _passController = Get.find<PassController>();
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
                Logo(),
                SizedBox(height: 0.02.sh),
                Text(
                  'Login Account',
                  style: AppTextStyles.screentitle,
                ),
                SizedBox(height: 0.01.sh),
                Text(
                  'Discover your social & Try to Login',
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
                            labelText: 'Email/ Phone Number',
                            type: TextInputType.emailAddress,
                            controller: _authController.emailController,
                            validator: AppValidators.validateEmail,
                          ),
                          SizedBox(height: 0.01.sh),
                          Obx(
                            () => CustomTextField(
                              prefix: FontAwesomeIcons.lock,
                              validator: AppValidators.validatePass,
                              labelText: 'Password',
                              type: TextInputType.emailAddress,
                              controller: _authController.passController,
                              suffix: _passController.ispass.value
                                  ? FontAwesomeIcons.solidEyeSlash
                                  : FontAwesomeIcons.solidEye,
                              isPass: _passController.ispass.value,
                              onTap: () => _passController.togglePass(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.to(ForgotPass()),
                      child: Text(
                        'Forgot Password?',
                        style: AppTextStyles.bodyTextMedium,
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
                          text: 'Sign In',
                          bgColor: AppColors.lightGreen,
                          ontap: () {
                            if (_formKey.currentState!.validate()) {
                              _authController.loginUser();
                            }
                          },
                        ),
                ),
                SizedBox(height: 0.02.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.gray,
                        thickness: 0.3,
                      ),
                    ),
                    SizedBox(width: 0.05.sw),
                    Text(
                      'Or Sign in with',
                      style: AppTextStyles.bodyTextMedium,
                    ),
                    SizedBox(width: 0.05.sw),
                    Expanded(
                      child: Divider(
                        color: AppColors.gray,
                        thickness: 0.3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.02.sh),
                SocialButton(
                  btnText: 'Connect with Google',
                  img: 'assets/images/google.png',
                  ontap: () {
                    _authController.signInWithGoogle();
                  },
                ),
                SizedBox(height: 0.02.sh),
                SocialButton(
                  btnText: 'Connect with Apple',
                  img: 'assets/images/apple-logo.png',
                ),
                SizedBox(height: 0.001.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: AppTextStyles.bodyTextMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        _authController.clearFields();
                        Get.offAll(Register());
                      },
                      child: Text(
                        "Sign Up Now",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
