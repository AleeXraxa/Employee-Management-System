import 'package:employee_management_system/core/app_exports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
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
                  'HR DASHBOARD',
                  style: AppTextStyles.title,
                ),
                SizedBox(height: 0.01.sh),
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        labelText: 'Email/ Phone Number',
                        type: TextInputType.emailAddress,
                        controller: _email,
                        validator: AppValidators.validateEmail,
                      ),
                      SizedBox(height: 0.01.sh),
                      CustomTextField(
                        validator: AppValidators.validatePass,
                        labelText: 'Password',
                        type: TextInputType.emailAddress,
                        controller: _email,
                        suffix: Icons.visibility,
                        isPass: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.03.sh),
                PrimaryButton(
                  text: 'Sign In',
                  bgColor: AppColors.lightGreen,
                  ontap: () {},
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
                ),
                SizedBox(height: 0.02.sh),
                SocialButton(
                  btnText: 'Connect with Apple',
                  img: 'assets/images/apple-logo.png',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
