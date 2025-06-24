import 'package:dotted_border/dotted_border.dart';
import 'package:employee_management_system/core/app_exports.dart';
import 'package:employee_management_system/shared/utils/img_picker.dart';

class UploadBox extends StatelessWidget {
  final TaskModel task;

  const UploadBox({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DottedBorder(
          color: Colors.grey,
          strokeWidth: 1,
          dashPattern: [6, 3],
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const Icon(Icons.upload_file, size: 48, color: Colors.grey),
                const SizedBox(height: 8),
                const Text("Choose Image to Upload",
                    style: TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          final file = await ImageHelper.pickImage();
                          if (file != null) {
                            await controller.uploadSingleImage(task, file);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        child: const Text("Choose Image"),
                      )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Live updated images
        Obx(() {
          final updatedTask = controller.taskList
              .firstWhere((t) => t.id == task.id, orElse: () => task);
          final images = updatedTask.imgUrls ?? [];

          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: images.map((url) {
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      url,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: () async {
                        await controller.deleteImageFromTask(task, url);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(Icons.close,
                            size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
