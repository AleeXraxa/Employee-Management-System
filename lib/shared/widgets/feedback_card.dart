import 'package:employee_management_system/core/app_exports.dart';

class FeedbackCard extends StatelessWidget {
  final String feedback;
  final int rating;
  final String taskName;

  const FeedbackCard({
    required this.feedback,
    this.rating = 5,
    required this.taskName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final safeRating = rating.clamp(0, 5);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF5E3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            taskName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.chat_bubble, color: Colors.green),
              SizedBox(width: 8),
              Text(
                'Client Feedback',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                color: index < safeRating ? Colors.amber : Colors.grey[300],
              );
            }),
          ),
          const SizedBox(height: 8),
          SelectableText(
            feedback,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
