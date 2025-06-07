import 'package:employee_management_system/core/app_exports.dart';
import 'package:employee_management_system/shared/widgets/secondary_btn.dart';

class EmpDetails extends StatelessWidget {
  final UserModel employee;
  const EmpDetails({
    required this.employee,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0.03.sh),
                Text(
                  'Good Morning, HR!',
                  style: AppTextStyles.bodyTextMedium,
                ),
                Text(
                  "Let's Start Your Day",
                  style: AppTextStyles.bodyText,
                ),
                SizedBox(height: 0.02.sh),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4FBF7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.grey.shade200, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                              'assets/images/logo.png'), // Update your image path
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Name and Role
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${employee.username.toUpperCase()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Employee',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            employee.isApproved ? '' : 'Status: Pending',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                employee.isApproved
                    ? SizedBox()
                    : SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            secondaryBtn(
                                btnText: 'Approve',
                                bgcolor: AppColors.primaryColor,
                                onTap: () {}),
                            SizedBox(width: 0.05.sw),
                            secondaryBtn(
                                btnText: 'Reject',
                                bgcolor: AppColors.red,
                                onTap: () {}),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
