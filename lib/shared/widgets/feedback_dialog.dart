import '../../core/app_exports.dart';

void showFeedbackDialog({
  required String employeeId,
  required String taskId,
}) async {
  final feedbackSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(employeeId)
      .collection('tasks')
      .doc(taskId)
      .collection('feedback')
      .orderBy('timestamp', descending: true)
      .get();

  if (feedbackSnapshot.docs.isEmpty) {
    showCustomDialog(
      icon: FontAwesomeIcons.circleInfo,
      title: 'No Feedback',
      message: 'No feedback has been submitted for this task yet.',
      buttonText: 'Close',
      onPressed: () => Get.back(),
    );
    return;
  }

  final feedback = feedbackSnapshot.docs.first.data();

  showCustomDialog(
    icon: FontAwesomeIcons.commentDots,
    title: 'Feedback',
    message: '⭐ Rating: ${feedback['rating']}\n\n📝 ${feedback['feedback']}',
    buttonText: 'Close',
    onPressed: () => Get.back(),
  );
}
