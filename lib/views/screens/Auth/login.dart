import 'package:employee_management_system/core/app_exports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
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
                  width: 0.5.sw,
                  height: 0.2.sh,
                  color: AppColors.darkGreen,
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
                CustomTextField(
                  labelText: 'Email/ Phone Number',
                  type: TextInputType.emailAddress,
                  controller: _email,
                ),
                SizedBox(height: 0.03.sh),
                CustomTextField(
                  labelText: 'Password',
                  type: TextInputType.emailAddress,
                  controller: _email,
                  suffix: Icons.visibility,
                  isPass: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
