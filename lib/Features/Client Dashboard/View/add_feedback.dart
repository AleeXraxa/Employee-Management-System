import 'package:employee_management_system/core/app_exports.dart';

class AddFeedback extends StatefulWidget {
  final UserModel client;
  final TaskModel task;
  const AddFeedback({super.key, required this.client, required this.task});

  @override
  State<AddFeedback> createState() => _AddFeedbackState();
}

class _AddFeedbackState extends State<AddFeedback> {
  final clientTaskController = Get.find<ClientTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.1.sh,
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: FaIcon(
            FontAwesomeIcons.circleChevronLeft,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Add Feedback',
          style: AppTextStyles.screenName,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task: ${widget.task.title}',
                style: AppTextStyles.bodyText,
              ),
              SizedBox(height: 20),
              CustomTextField(
                labelText: 'Enter your feedback',
                type: TextInputType.multiline,
                controller: clientTaskController.feedbackTextController,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please write your feedback';
                  }
                  return null;
                },
                isReadOnly: false,
                onChange: null,
              ),
              SizedBox(height: 0.02.sh),
              Text(
                'Rate this task',
                style: AppTextStyles.bodyText,
              ),
              SizedBox(height: 10),
              Center(
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 32,
                  unratedColor: Colors.grey.shade300,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: AppColors.primaryColor,
                  ),
                  onRatingUpdate: (rating) {
                    // Save this to controller
                    clientTaskController.rating.value = rating;
                  },
                ),
              ),
              SizedBox(height: 30),
              PrimaryButton(
                  text: 'Add Feeedback',
                  bgColor: AppColors.primaryColor,
                  ontap: () {
                    clientTaskController.addFeedback(
                        employeeId: widget.task.assignedTo,
                        taskId: widget.task.id!);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
