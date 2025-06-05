import 'package:employee_management_system/constant/app_typography.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Employee Management System',
              style: AppTextStyles.splash,
            ),
          ],
        ),
      ),
    );
  }
}
