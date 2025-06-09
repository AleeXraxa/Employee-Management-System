import 'package:employee_management_system/core/app_exports.dart';

class TaskController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var isLoading = false.obs;

  Future<void> addTask(TaskModel task) async {
    try {
      isLoading.value = true;
      await _db.collection('tasks').add(task.toMap());
      Get.snackbar("Success", "Task added successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
