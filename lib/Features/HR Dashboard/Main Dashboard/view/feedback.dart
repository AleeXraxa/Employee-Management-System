import 'package:employee_management_system/core/app_exports.dart';
import 'package:employee_management_system/shared/widgets/feedback_card.dart';

class AllFeedbackScreen extends StatelessWidget {
  final UserModel employee;
  const AllFeedbackScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.1.sh,
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const FaIcon(
            FontAwesomeIcons.circleChevronLeft,
            color: Colors.white,
          ),
        ),
        title: Text(
          'All Feedbacks',
          style: AppTextStyles.screenName,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: FutureBuilder<List<TaskFeedbackData>>(
          future: taskController.getAllTaskFeedbacks(employee.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return const Center(child: Text('No feedbacks found.'));
            }

            final feedbackList = snapshot.data!;
            return ListView.builder(
              itemCount: feedbackList.length,
              itemBuilder: (context, index) {
                final feedbackItem = feedbackList[index];
                return FeedbackCard(
                  taskName: feedbackItem.taskTitle,
                  feedback: feedbackItem.feedback.comment,
                  rating: feedbackItem.feedback.rating,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
