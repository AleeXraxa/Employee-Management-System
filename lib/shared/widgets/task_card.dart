import 'package:employee_management_system/core/app_exports.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

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
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFFD6FFE0),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'Monday, 09:00 Am–05:00 PM',
                style: TextStyle(
                  color: Color(0xFF00B44D),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.check_circle, color: Color(0xFF00B44D)),
              ],
            ),
            SizedBox(height: 4),
            Text(
              'Transport solar panels & equipment to Site 1',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            SizedBox(height: 20),
            Center(
              child: secondaryBtn(
                  btnText: 'Edit Taks',
                  bgcolor: AppColors.primaryColor,
                  onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
