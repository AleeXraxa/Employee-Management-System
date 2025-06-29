import 'package:employee_management_system/core/app_exports.dart';

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
          radius: const Radius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                SizedBox(height: 0.03.sh),
                const FaIcon(
                  FontAwesomeIcons.upload,
                  size: 30,
                ),
                SizedBox(height: 0.03.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Choose Images to ",
                      style: AppTextStyles.bodyText,
                    ),
                    Text(
                      "Upload",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.03.sh),
                Obx(
                  () => controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : SecondaryBtn(
                          btnText: 'Choose Image',
                          bgcolor: AppColors.primaryColor,
                          onTap: () async {
                            final file = await ImageHelper.pickImage();
                            if (file != null) {
                              await controller.uploadSingleImage(task, file);
                            }
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
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
                      onTap: () {
                        Get.dialog(
                          DeleteDialog(
                            icon: FontAwesomeIcons.circleXmark,
                            title: 'Are You Sure?',
                            message: "This action can't be undone",
                            confirmText: 'Delete',
                            onConfirmed: () async {
                              await controller.deleteImageFromTask(task, url);
                              Get.back();
                            },
                          ),
                        );
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
