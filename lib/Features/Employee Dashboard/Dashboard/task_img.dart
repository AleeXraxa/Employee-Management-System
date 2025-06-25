import 'package:employee_management_system/core/app_exports.dart';

class UploadTaskImagesScreen extends StatefulWidget {
  const UploadTaskImagesScreen({super.key});

  @override
  State<UploadTaskImagesScreen> createState() => _UploadTaskImagesScreenState();
}

class _UploadTaskImagesScreenState extends State<UploadTaskImagesScreen> {
  final TaskController controller = Get.find<TaskController>();

  final Rx<TaskModel?> selectedTask = Rx<TaskModel?>(null);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.1.sh,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(
          'Upload Task Images',
          style: AppTextStyles.screenName,
        ),
        centerTitle: true,
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
              SizedBox(height: 0.03.sh),
              Text(
                'Add new Images',
                style: AppTextStyles.bodyText,
              ),
              SizedBox(height: 0.02.sh),
              CustomDropdown<TaskModel>(
                label: 'Select a Task',
                value: selectedTask.value,
                items: pendingTasks,
                getLabel: (task) => task.title,
                onChanged: (value) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    selectedTask.value = value as TaskModel?;
                  });
                },
              ),
              const SizedBox(height: 20),
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
