import 'package:employee_management_system/core/app_exports.dart';

class TaskController extends GetxController {
  final _authController = Get.find<AuthController>();
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
      showCustomDialog(
        icon: FontAwesomeIcons.solidCircleCheck,
        title: 'Task Added',
        message: 'New ${titleController.text} has been added successfully',
        buttonText: 'Continue',
        onPressed: () {
          Get.back();
          Get.back();
        },
      );
      clearFields();
    } catch (e) {
      _authController.handleFirebaseError(e);
    } finally {
      isLoading.value = false;
    }
  }

  var taskList = <TaskModel>[].obs;
  var isTaskLoading = true.obs;
  var taskError = ''.obs;

  void fetchTasksForEmployee(String employeeID) {
    try {
      isTaskLoading.value = true;
      taskError.value = '';

      _db
          .collection('tasks')
          .where('assignedTo', isEqualTo: employeeID)
          .orderBy('date', descending: false)
          .snapshots()
          .listen((snapshot) {
        taskList.value = snapshot.docs
            .map((doc) => TaskModel.fromMap(doc.id, doc.data()))
            .toList();
        isTaskLoading.value = false;
      }, onError: (e) {
        taskError.value = 'Something went wrong $e';
        print(e);
        isTaskLoading.value = false;
      });
    } catch (e) {
      taskError.value = e.toString();
      isTaskLoading.value = false;
    }
  }
}
