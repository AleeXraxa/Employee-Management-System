import 'dart:io';

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
    required String clientId,
    String? imageURL,
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
        clientId: clientId,
      );

      await _db
          .collection('users')
          .doc(employeeID)
          .collection('tasks')
          .add(task.toMap());

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

  Future<void> updateTask(
    String employeeID,
    String taskID,
    DateTime selectedDate, {
    String? imgURL,
  }) async {
    try {
      isLoading.value = true;

      final updatedTask = {
        'title': titleController.text.trim(),
        'time': "${startController.text.trim()} - ${endController.text.trim()}",
        'location': locationController.text.trim(),
        'status': statusController.text.trim(),
        'date': Timestamp.fromDate(selectedDate),
        if (imgURL != null) 'imageUrl': imgURL,
      };

      await _db
          .collection('users')
          .doc(employeeID)
          .collection('tasks')
          .doc(taskID)
          .update(updatedTask);

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
      clearFields();
    } catch (e) {
      _authController.handleFirebaseError(e);
    } finally {
      isLoading.value = false;
    }
  }

  void fetchTasks({required String employeeID}) {
    try {
      isTaskLoading.value = true;
      taskError.value = '';

      final query = _db
          .collection('users')
          .doc(employeeID)
          .collection('tasks')
          .orderBy('date');

      query.snapshots().listen((snapshot) {
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
      'Saturday': [],
    };

    for (final task in tasks) {
      final String? dayName = switch (task.date.weekday) {
        1 => 'Monday',
        2 => 'Tuesday',
        3 => 'Wednesday',
        4 => 'Thursday',
        5 => 'Friday',
        6 => 'Saturday',
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

  void deleteTask(String employeeID, String taskID) async {
    try {
      await _db
          .collection('users')
          .doc(employeeID)
          .collection('tasks')
          .doc(taskID)
          .delete();

      Get.back();
    } catch (e) {
      _authController.handleFirebaseError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markTaskCompleted({
    required String employeeId,
    required String taskId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(employeeId)
          .collection('tasks')
          .doc(taskId)
          .update({
        'progressStatus': 'completed',
      });

      Get.snackbar('Task Completed', 'You marked your task as completed');
    } catch (e) {
      Get.snackbar('Error', 'Could not update task');
    }
  }

  Future<void> uploadSingleImage(TaskModel task, File image) async {
    isLoading.value = true;

    final url = await CloudinaryService.uploadImage(image);
    if (url != null) {
      final updatedList = [...(task.imgUrls ?? []), url];

      await FirebaseFirestore.instance
          .collection('users')
          .doc(task.assignedTo)
          .collection('tasks')
          .doc(task.id)
          .update({'imgUrls': updatedList});

      final index = taskList.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        taskList[index] = TaskModel(
          id: task.id,
          title: task.title,
          time: task.time,
          location: task.location,
          status: task.status,
          date: task.date,
          createdBy: task.createdBy,
          assignedTo: task.assignedTo,
          progressStatus: task.progressStatus,
          imgUrls: List<String>.from(updatedList),
          clientId: task.clientId,
        );

        taskList.refresh();
      }

      Get.snackbar('Image Uploaded', 'Image uploaded and task updated');
    } else {
      Get.snackbar('Failed', 'Image upload failed');
    }

    isLoading.value = false;
  }

  Future<void> deleteImageFromTask(TaskModel task, String url) async {
    final updatedList = (task.imgUrls ?? [])..remove(url);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(task.assignedTo)
        .collection('tasks')
        .doc(task.id)
        .update({'imgUrls': updatedList});

    final index = taskList.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      taskList[index] = TaskModel(
        id: task.id,
        title: task.title,
        time: task.time,
        location: task.location,
        status: task.status,
        date: task.date,
        createdBy: task.createdBy,
        assignedTo: task.assignedTo,
        progressStatus: task.progressStatus,
        imgUrls: updatedList,
        clientId: task.clientId,
      );
    }

    Get.snackbar('Deleted', 'Image removed from task');
  }

  final RxList<UserModel> clientList = <UserModel>[].obs;

  Future<void> fetchClients() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'Client')
        .where('isApproved', isEqualTo: true)
        .get();

    final clients = snapshot.docs.map((doc) {
      return UserModel.fromMap(doc.id, doc.data());
    }).toList();

    clientList.assignAll(clients);
  }

  Future<TaskFeedbackData?> getMostRecentFeedbackOfEmployee(
      String employeeId) async {
    try {
      final taskSnapshot = await _db
          .collection('users')
          .doc(employeeId)
          .collection('tasks')
          .orderBy('date', descending: true)
          .get();

      for (final taskDoc in taskSnapshot.docs) {
        final taskId = taskDoc.id;
        final taskTitle = taskDoc['title'] ?? 'Unnamed Task';
        debugPrint('📌 Task Found: $taskTitle');

        final feedbackSnapshot = await _db
            .collection('users')
            .doc(employeeId)
            .collection('tasks')
            .doc(taskId)
            .collection('feedback')
            .orderBy('givenAt', descending: true)
            .limit(1)
            .get();

        debugPrint(
            '📄 Feedback count for task $taskTitle: ${feedbackSnapshot.docs.length}');

        if (feedbackSnapshot.docs.isNotEmpty) {
          final doc = feedbackSnapshot.docs.first;
          final feedback = FeedbackModel.fromMap(doc.id, doc.data());
          debugPrint(
              '🟢 Feedback: ${feedback.comment} | Rating: ${feedback.rating}');
          return TaskFeedbackData(taskTitle: taskTitle, feedback: feedback);
        }
      }

      return null;
    } catch (e) {
      debugPrint('🔥 Error fetching most recent feedback: $e');
      return null;
    }
  }

  Future<List<TaskFeedbackData>> getAllTaskFeedbacks(String employeeId) async {
    final List<TaskFeedbackData> result = [];

    try {
      final taskSnapshot = await _db
          .collection('users')
          .doc(employeeId)
          .collection('tasks')
          .get();

      for (final taskDoc in taskSnapshot.docs) {
        final taskTitle = taskDoc['title'] ?? 'Unnamed Task';

        final feedbackSnapshot = await _db
            .collection('users')
            .doc(employeeId)
            .collection('tasks')
            .doc(taskDoc.id)
            .collection('feedback')
            .get();

        for (final doc in feedbackSnapshot.docs) {
          final data = FeedbackModel.fromMap(doc.id, doc.data());
          result.add(TaskFeedbackData(taskTitle: taskTitle, feedback: data));
        }
      }

      return result;
    } catch (e) {
      debugPrint('🔥 Error fetching task feedbacks: $e');
      return [];
    }
  }
}

class FeedbackWithTask {
  final String taskTitle;
  final FeedbackModel feedback;

  FeedbackWithTask({
    required this.taskTitle,
    required this.feedback,
  });
}
