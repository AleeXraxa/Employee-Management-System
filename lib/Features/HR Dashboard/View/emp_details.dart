import 'package:employee_management_system/core/app_exports.dart';

class EmpDetails extends StatelessWidget {
  final UserModel employee;
  const EmpDetails({
    required this.employee,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _empController = Get.find<EmpController>();
    final _authController = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0.03.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning, HR!',
                          style: AppTextStyles.bodyTextMedium,
                        ),
                        Text(
                          "Let's Start Your Day",
                          style: AppTextStyles.bodyText,
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          _authController.logout();
                        },
                        icon: FaIcon(FontAwesomeIcons.rightToBracket))
                  ],
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                onTap: () {
                                  _empController.approveReject(
                                      employee.uid, true);
                                }),
                            SizedBox(width: 0.05.sw),
                            secondaryBtn(
                                btnText: 'Reject',
                                bgcolor: AppColors.red,
                                onTap: () {
                                  _empController.approveReject(
                                      employee.uid, false);
                                }),
                          ],
                        ),
                      ),
                SizedBox(height: 0.02.sh),
                // Obx(() {
                //   return Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       if (_taskController.completedTask != null) ...[
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               "Employee's Taks",
                //               style: AppTextStyles.bodyText,
                //             ),
                //             secondaryBtn(
                //                 btnText: 'View All',
                //                 bgcolor: AppColors.primaryColor,
                //                 onTap: () {}),
                //           ],
                //         ),
                //         TaskCard(
                //             task: _taskController.completedTask!,
                //             onEdit: () {}),
                //       ],
                //       if (_taskController.tomorrowTask != null) ...[
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               "Tommorow's Taks",
                //               style: AppTextStyles.bodyText,
                //             ),
                //             secondaryBtn(
                //                 btnText: 'View All',
                //                 bgcolor: AppColors.primaryColor,
                //                 onTap: () {}),
                //           ],
                //         ),
                //         TaskCard(
                //             task: _taskController.tomorrowTask!, onEdit: () {}),
                //       ],
                //     ],
                //   );
                // }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
