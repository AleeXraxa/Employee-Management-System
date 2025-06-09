import 'package:employee_management_system/core/app_exports.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class AddTaskScreen extends StatefulWidget {
  final UserModel emp;
  const AddTaskScreen({super.key, required this.emp});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskController = Get.find<TaskController>();
  DateTime _selectedDate = DateTime.now();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController =
      TextEditingController(text: "01:30 - 03:30 PM");
  final TextEditingController _locationController =
      TextEditingController(text: "Site 1");
  final TextEditingController _statusController =
      TextEditingController(text: "Routine event");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(color: Color(0xFF00C853)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child:
                        const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Text("Add Task", style: AppTextStyles.screenName),
                ],
              ),
            ),

            Expanded(
              child: ClipPath(
                clipper: TopRoundedClipper(),
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Calendar
                        SizedBox(
                          height: 360,
                          child: CalendarCarousel(
                            onDayPressed: (date, _) {
                              setState(() => _selectedDate = date);
                            },
                            selectedDateTime: _selectedDate,
                            weekendTextStyle:
                                const TextStyle(color: Colors.black),
                            thisMonthDayBorderColor: Colors.transparent,
                            daysHaveCircularBorder: true,
                            todayButtonColor: Colors.transparent,
                            selectedDayButtonColor: const Color(0xFF00C853),
                            selectedDayBorderColor: Colors.transparent,
                            selectedDayTextStyle:
                                const TextStyle(color: Colors.white),
                            todayTextStyle:
                                const TextStyle(color: Colors.black),
                            daysTextStyle: const TextStyle(color: Colors.black),
                            weekdayTextStyle:
                                const TextStyle(fontWeight: FontWeight.w500),
                            headerTextStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            leftButtonIcon: const Icon(Icons.chevron_left,
                                color: Colors.black),
                            rightButtonIcon: const Icon(Icons.chevron_right,
                                color: Colors.black),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text("Information", style: AppTextStyles.title),
                        const SizedBox(height: 16),
                        _buildInputField("Title", _titleController),
                        _buildInputField("Time", _timeController),
                        _buildInputField("Location", _locationController),
                        _buildInputField("Status", _statusController),

                        const SizedBox(height: 40),

                        PrimaryButton(
                            text: 'Add Task',
                            bgColor: AppColors.primaryColor,
                            ontap: () {
                              final task = TaskModel(
                                  title: _titleController.text,
                                  time: _timeController.text,
                                  location: _locationController.text,
                                  status: _statusController.text,
                                  date: _selectedDate,
                                  createdBy: 'HR',
                                  assignedTo: widget.emp.uid);
                              _taskController.addTask(task);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.title),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            style: AppTextStyles.field,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              border: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class TopRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const radius = 32.0;
    final path = Path();
    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
