import 'package:employee_management_system/core/app_exports.dart';
import 'package:intl/intl.dart';

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
    _taskController.fetchTasksForEmployee(employee.uid);

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
                Container(
                  height: 0.6.sh,
                  child: Obx(() {
                    if (_taskController.isTaskLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (_taskController.taskError.value.isNotEmpty) {
                      return Center(
                          child: Text(_taskController.taskError.value));
                    }

                    if (_taskController.taskList.isEmpty) {
                      return const Center(child: Text("No tasks found"));
                    }

                    return ListView.builder(
                      itemCount: _taskController.taskList.length,
                      itemBuilder: (context, index) {
                        final task = _taskController.taskList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: ListTile(
                            leading: const Icon(Icons.task,
                                color: AppColors.primaryColor),
                            title: Text(task.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Date: ${DateFormat.yMMMd().format(task.date)}"),
                                Text("Time: ${task.time}"),
                                Text("Location: ${task.location}"),
                                Text("Status: ${task.status}"),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
