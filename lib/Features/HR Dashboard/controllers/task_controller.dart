import 'package:employee_management_system/core/app_exports.dart';
import 'package:firebase_core/firebase_core.dart';

class TaskController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var isLoading = false.obs;

  final titleController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();
  final locationController = TextEditingController();
  final statusController = TextEditingController();

  void clearFields() {
    titleController.clear();
    startController.clear();
    endController.clear();
    locationController.clear();
    statusController.clear();
  }

  Future<void> addTask({
    required DateTime selectedDate,
    required String employeeID,
  }) async {
    try {
      isLoading.value = true;

      final String timeRange =
          "${startController.text.trim()} - ${endController.text.trim()}";

      final task = TaskModel(
        title: titleController.text,
        time: timeRange,
        location: locationController.text,
        status: statusController.text,
        date: selectedDate,
        createdBy: FirebaseAuth.instance.currentUser!.uid,
        assignedTo: employeeID,
      );

      await _db.collection('tasks').add(task.toMap());
      Get.snackbar("Success", 'Added');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
