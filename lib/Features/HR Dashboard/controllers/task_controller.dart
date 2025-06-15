import 'package:employee_management_system/core/app_exports.dart';

class TaskController extends GetxController {
  final _authController = Get.find<AuthController>();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final isLoading = false.obs;
  final isTaskLoading = true.obs;
  final taskError = ''.obs;

  final titleController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();
  final locationController = TextEditingController();
  final statusController = TextEditingController();
  final searchController = TextEditingController();

  final taskList = <TaskModel>[].obs;
  final filteredTasks = <TaskModel>[].obs;

  void clearFields() {
    titleController.clear();
    startController.clear();
    endController.clear();
    locationController.clear();
    statusController.clear();
    searchController.clear();
  }

  Future<void> addTask({
    required DateTime selectedDate,
    required String employeeID,
  }) async {
    try {
      isLoading.value = true;

      final task = TaskModel(
        title: titleController.text.trim(),
        time: "${startController.text.trim()} - ${endController.text.trim()}",
        location: locationController.text.trim(),
        status: statusController.text.trim(),
        date: selectedDate,
        createdBy: FirebaseAuth.instance.currentUser!.uid,
        assignedTo: employeeID,
        progressStatus: 'pending',
      );

      await _db.collection('tasks').add(task.toMap());

      showCustomDialog(
        icon: FontAwesomeIcons.solidCircleCheck,
        title: 'Task Added',
        message: 'New "${task.title}" has been added successfully',
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

  Future<void> updateTask(String taskID, DateTime selectedDate) async {
    try {
      isLoading.value = true;

      final updatedTask = {
        'title': titleController.text.trim(),
        'time': "${startController.text.trim()} - ${endController.text.trim()}",
        'location': locationController.text.trim(),
        'status': statusController.text.trim(),
        'date': selectedDate,
      };

      await _db.collection('tasks').doc(taskID).update(updatedTask);

      showCustomDialog(
        icon: FontAwesomeIcons.solidCircleCheck,
        title: 'Task Updated',
        message: 'Task "${titleController.text}" has been updated successfully',
        buttonText: 'Back',
        onPressed: () {
          Get.back();
          Get.back();
        },
      );
    } catch (e) {
      _authController.handleFirebaseError(e);
    } finally {
      isLoading.value = false;
    }
  }

  void fetchTasks({String? employeeID}) {
    try {
      isTaskLoading.value = true;
      taskError.value = '';

      Query query = _db.collection('tasks');

      if (employeeID != null) {
        query = query.where('assignedTo', isEqualTo: employeeID);
      }

      query.orderBy('date').snapshots().listen((snapshot) {
        taskList.value = snapshot.docs
            .map((doc) =>
                TaskModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
            .toList();

        filteredTasks.assignAll(taskList);
        isTaskLoading.value = false;
      }, onError: (e) {
        taskError.value = 'Something went wrong: $e';
        isTaskLoading.value = false;
      });
    } catch (e) {
      taskError.value = e.toString();
      isTaskLoading.value = false;
    }
  }

  TaskModel? get mostRecentTask {
    if (taskList.isEmpty) return null;

    try {
      final sortedList = [...taskList]
        ..sort((a, b) => b.date.compareTo(a.date));
      return sortedList.first;
    } catch (_) {
      return null;
    }
  }

  TaskModel? get oneTomorrowPendingTask {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return taskList.firstWhereOrNull(
      (task) =>
          task.progressStatus == 'pending' &&
          task.date.year == tomorrow.year &&
          task.date.month == tomorrow.month &&
          task.date.day == tomorrow.day,
    );
  }

  Map<String, List<TaskModel>> getWeekdayWiseTasks(List<TaskModel> tasks) {
    final Map<String, List<TaskModel>> groupedTasks = {
      'Monday': [],
      'Tuesday': [],
      'Wednesday': [],
      'Thursday': [],
      'Friday': [],
    };

    for (final task in tasks) {
      final String? dayName = switch (task.date.weekday) {
        1 => 'Monday',
        2 => 'Tuesday',
        3 => 'Wednesday',
        4 => 'Thursday',
        5 => 'Friday',
        _ => null,
      };

      if (dayName != null) {
        groupedTasks[dayName]!.add(task);
      }
    }

    return groupedTasks;
  }

  void filterTasksByName() {
    final query = searchController.text.toLowerCase().trim();

    if (query.isEmpty) {
      filteredTasks.assignAll(taskList);
    } else {
      filteredTasks.assignAll(
        taskList
            .where((task) => task.title.toLowerCase().contains(query))
            .toList(),
      );
    }
  }
}
