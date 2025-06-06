import 'package:employee_management_system/core/app_exports.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                  'Create Account',
                  style: AppTextStyles.screentitle,
                ),
                SizedBox(height: 0.01.sh),
                Text(
                  'Discover your social by Creating Account',
                  style: AppTextStyles.bodyTextMedium,
                ),
                SizedBox(height: 0.025.sh),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            prefix: FontAwesomeIcons.user,
                            labelText: 'Username',
                            type: TextInputType.name,
                            controller: _authController.nameController,
                            validator: (value) =>
                                AppValidators.validateName(value, 'Username'),
                          ),
                          SizedBox(height: 0.01.sh),
                          CustomTextField(
                            prefix: FontAwesomeIcons.envelope,
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
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              isPass: _passController.ispass.value,
                              onTap: () => _passController.togglePass(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.02.sh),
                PrimaryButton(
                  text: 'Sign Up',
                  bgColor: AppColors.lightGreen,
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      Get.snackbar('Success', 'working');
                    }
                  },
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
                      'Or Sign Up with',
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
                      "Already have an account?",
                      style: AppTextStyles.bodyTextMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        _authController.clearFields();
                        Get.offAll(Login());
                      },
                      child: Text(
                        "Sign In Now",
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
