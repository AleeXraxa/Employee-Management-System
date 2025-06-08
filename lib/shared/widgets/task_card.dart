import 'package:employee_management_system/core/app_exports.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onEdit;

  const TaskCard({
    super.key,
    required this.task,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF4FBF7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day and Time
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFD6FFE0),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                '${task.day}, ${task.startTime} – ${task.endTime}',
                style: const TextStyle(
                  color: Color(0xFF00B44D),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Task title and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.taskTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  task.status == 'completed'
                      ? Icons.check_circle
                      : Icons.pending_actions,
                  color: task.status == 'completed'
                      ? const Color(0xFF00B44D)
                      : Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 4),
            Text(
              task.description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),

            const SizedBox(height: 20),

            // Edit Button
            Center(
              child: secondaryBtn(
                btnText: 'Edit Task',
                bgcolor: AppColors.primaryColor,
                onTap: onEdit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
