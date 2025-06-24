import 'dart:io';
import 'package:employee_management_system/core/app_exports.dart';
import 'package:employee_management_system/shared/widgets/upload_box.dart';

class UploadTaskImagesScreen extends StatelessWidget {
  final TaskController controller = Get.find<TaskController>();
  final Rx<TaskModel?> selectedTask = Rx<TaskModel?>(null);

  UploadTaskImagesScreen({super.key}) {
    controller.fetchTasks(); // Fetch tasks on screen init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Task Images'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Obx(() {
        final pendingTasks = controller.taskList
            .where((task) => task.progressStatus != 'completed')
            .toList();

        if (controller.isTaskLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<TaskModel>(
                value: selectedTask.value,
                isExpanded: true,
                hint: const Text("Select a Task"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                items: pendingTasks.map((task) {
                  return DropdownMenuItem<TaskModel>(
                    value: task,
                    child: Text(task.title),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedTask.value = value;
                },
              ),
              const SizedBox(height: 20),

              // UploadBox only shown if a task is selected
              Obx(() {
                final currentTask = controller.taskList.firstWhereOrNull(
                  (t) => t.id == selectedTask.value?.id,
                );
                if (currentTask != null) {
                  return UploadBox(task: currentTask);
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        );
      }),
    );
  }
}
