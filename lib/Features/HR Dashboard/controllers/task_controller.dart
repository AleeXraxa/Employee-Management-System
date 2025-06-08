import 'package:employee_management_system/core/app_exports.dart';

class TaskController extends GetxController {
  final String empId; // The employee ID to load tasks for
  final TaskService _taskService = TaskService();

  var tasks = <TaskModel>[].obs;
  var isLoading = false.obs;

  TaskController({required this.empId});

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      final result = await _taskService.getTasks(empId);
      tasks.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      isLoading.value = true;
      await _taskService.addTask(empId, task);
      await fetchTasks(); // refresh
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      isLoading.value = true;
      await _taskService.updateTask(empId, task);
      await fetchTasks(); // refresh
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      isLoading.value = true;
      await _taskService.deleteTask(empId, taskId);
      await fetchTasks(); // refresh
    } finally {
      isLoading.value = false;
    }
  }
}
