import 'package:employee_management_system/Features/HR%20Dashboard/View/task/update_task.dart';
import 'package:employee_management_system/Features/HR%20Dashboard/View/task/view_all.dart';
import 'package:employee_management_system/core/app_exports.dart';
import 'package:employee_management_system/shared/widgets/task_card.dart';

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
    final _taskController = Get.find<TaskController>();
    _taskController.fetchTasks(employeeID: employee.uid);

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
                          backgroundImage: AssetImage('assets/images/logo.png'),
                        ),
                      ),
                      const SizedBox(width: 12),
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
                Container(child: Obx(() {
                  final completedTask = _taskController.oneCompletedTask;
                  final tomorrowTask = _taskController.oneTomorrowPendingTask;

                  if (_taskController.isTaskLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_taskController.taskError.value.isNotEmpty) {
                    return Center(child: Text(_taskController.taskError.value));
                  }
                  if (completedTask == null && tomorrowTask == null) {
                    return Center(
                      child: Text(
                        'No Task yet',
                        style: AppTextStyles.bodyText,
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (completedTask != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Completed Task",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            secondaryBtn(
                                btnText: 'View All',
                                bgcolor: AppColors.primaryColor,
                                onTap: () {
                                  Get.to(ViewAllTasks());
                                }),
                          ],
                        ),
                        TaskCard(
                          task: completedTask,
                          onTap: () {
                            Get.to(UpdateTask(tasks: completedTask));
                          },
                        ),
                      ],
                      const SizedBox(height: 16),
                      if (tomorrowTask != null) ...[
                        Text("Tomorrow's Pending Task",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        TaskCard(
                          task: tomorrowTask,
                          onTap: () {
                            Get.to(UpdateTask(tasks: tomorrowTask));
                          },
                        ),
                      ]
                    ],
                  );
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
