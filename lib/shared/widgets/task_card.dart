import 'package:employee_management_system/core/app_exports.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffe0fbf2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${task.time}',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.01.sh),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Task',
                        style: AppTextStyles.bodyText,
                      ),
                      if (task.progressStatus == 'completed')
                        const FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: AppColors.primaryColor,
                        ),
                    ],
                  ),
                  SizedBox(height: 0.01.sh),
                  Text(
                    '${task.title}',
                    style: AppTextStyles.bodyTextMedium,
                  ),
                ],
              ),
              SizedBox(height: 0.01.sh),
              secondaryBtn(
                btnText: 'Edit Task',
                bgcolor: AppColors.primaryColor,
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
