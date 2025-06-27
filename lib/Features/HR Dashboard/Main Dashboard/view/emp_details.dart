import 'package:employee_management_system/core/app_exports.dart';

class EmpDetails extends StatelessWidget {
  final UserModel employee;
  const EmpDetails({
    required this.employee,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final empController = Get.find<EmpController>();
    final authController = Get.find<AuthController>();
    final taskController = Get.find<TaskController>();
    final attendanceController = Get.find<AttendanceController>();

    taskController.fetchTasks(employeeID: employee.uid);
    attendanceController.bindTodayAttendanceStream();

    final user = authController.currentUser;

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
                          user.value?.role == 'Admin'
                              ? 'Good Morning, HR'
                              : 'Good Morning, Employee',
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
                          authController.logout();
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
                            employee.username.toUpperCase(),
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
                            SecondaryBtn(
                                btnText: 'Approve',
                                bgcolor: AppColors.primaryColor,
                                onTap: () {
                                  empController.approveReject(
                                      employee.uid, true);
                                }),
                            SizedBox(width: 0.05.sw),
                            SecondaryBtn(
                                btnText: 'Reject',
                                bgcolor: AppColors.red,
                                onTap: () {
                                  empController.approveReject(
                                      employee.uid, false);
                                }),
                          ],
                        ),
                      ),
                SizedBox(height: 0.02.sh),
                Container(child: Obx(() {
                  final completedTask = taskController.mostRecentTask;
                  final tomorrowTask = taskController.oneTomorrowPendingTask;

                  if (taskController.isTaskLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (taskController.taskError.value.isNotEmpty) {
                    return Center(child: Text(taskController.taskError.value));
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
                              user.value?.role == 'Admin'
                                  ? "Employee's Tasks"
                                  : "Your Task's",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SecondaryBtn(
                                btnText: 'View All',
                                bgcolor: AppColors.primaryColor,
                                onTap: () {
                                  Get.to(ViewAllTasks(
                                    employee: employee,
                                  ));
                                }),
                          ],
                        ),
                        TaskCard(
                          user: user,
                          task: completedTask,
                          onTap: () {
                            Get.to(UpdateTask(
                              tasks: completedTask,
                              employee: employee,
                            ));
                          },
                          onDelete: () {
                            showCustomDialog(
                              icon: FontAwesomeIcons.solidCircleCheck,
                              title: 'Confirm Delete',
                              message: 'Do you want to Delete this Task?',
                              buttonText: 'Delete',
                              onPressed: () {
                                taskController.deleteTask(
                                    employee.uid, completedTask.id!);
                              },
                            );
                          },
                        ),
                      ],
                      const SizedBox(height: 16),
                      if (tomorrowTask != null) ...[
                        Text("Tomorrow's Pending Task",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        TaskCard(
                          user: user,
                          task: tomorrowTask,
                          onTap: () {
                            Get.to(UpdateTask(
                              tasks: tomorrowTask,
                              employee: employee,
                            ));
                          },
                          onDelete: () {
                            showCustomDialog(
                              icon: FontAwesomeIcons.solidCircleCheck,
                              title: 'Confirm Delete',
                              message: 'Do you want to Delete this Task?',
                              buttonText: 'Delete',
                              onPressed: () {
                                taskController.deleteTask(
                                    employee.uid, tomorrowTask.id!);
                              },
                            );
                          },
                        ),
                      ]
                    ],
                  );
                })),
                Obx(() {
                  final attendance =
                      attendanceController.todayAttendanceList.firstWhereOrNull(
                    (a) => a.employeeId == employee.uid,
                  );
                  return Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user.value?.role == 'Admin'
                                  ? "Employee's Attendance"
                                  : "Your Attendance",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SecondaryBtn(
                                btnText: 'View All',
                                bgcolor: AppColors.primaryColor,
                                onTap: () {
                                  Get.to(() => ViewAllAttendance(
                                      employeeID: employee.uid));
                                }),
                          ],
                        ),
                        SizedBox(height: 0.02.sh),
                        if (attendance != null)
                          Attendancepcard(
                              employee: employee, attendance: attendance)
                        else
                          Text('No Attendance for today yet.'),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
