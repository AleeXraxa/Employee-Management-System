import '../../../core/app_exports.dart';

class ClientTaskController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final tasks = <TaskModel>[].obs;
  final isLoading = true.obs;

  void fetchTasks(String clientId) {
    try {
      isLoading.value = true;
      tasks.clear();

      _db
          .collectionGroup('tasks')
          .where('clientId', isEqualTo: clientId)
          .orderBy('date')
          .snapshots()
          .listen((snapshot) {
        tasks.value = snapshot.docs.map((doc) {
          return TaskModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
        }).toList();
        isLoading.value = false;
      });
    } catch (e) {
      isLoading.value = false;
      debugPrint('🔥 Error fetching client tasks: $e');
    }
  }

  final feedbackTextController = TextEditingController();
  final rating = 0.0.obs;

  Future<void> addFeedback({
    required String employeeId,
    required String taskId,
  }) async {
    final feedback = feedbackTextController.text.trim();
    final ratingValue = rating.value;

    if (feedback.isEmpty || ratingValue == 0.0) {
      showCustomDialog(
        icon: FontAwesomeIcons.triangleExclamation,
        title: 'Incomplete',
        message: 'Please write feedback and give rating',
        buttonText: 'Okay',
        onPressed: () => Get.back(),
      );
      return;
    }

    try {
      await _db
          .collection('users')
          .doc(employeeId)
          .collection('tasks')
          .doc(taskId)
          .collection('feedback')
          .add({
        'comment': feedback,
        'rating': ratingValue,
        'givenAt': Timestamp.now(),
        'givenBy': FirebaseAuth.instance.currentUser?.uid ?? 'anonymous',
      });

      feedbackTextController.clear();
      rating.value = 0.0;

      showCustomDialog(
        icon: FontAwesomeIcons.solidCircleCheck,
        title: 'Feedback Submitted',
        message: 'Thanks for your feedback!',
        buttonText: 'Close',
        onPressed: () {
          Get.back();
          Get.back();
          final client = Get.find<AuthController>().currentUser.value!;
          fetchTasks(client.uid);
        },
      );
    } catch (e) {
      showCustomDialog(
        icon: FontAwesomeIcons.triangleExclamation,
        title: 'Error',
        message: 'Something went wrong while submitting feedback.',
        buttonText: 'Close',
        onPressed: () => Get.back(),
      );
    }
  }
}
