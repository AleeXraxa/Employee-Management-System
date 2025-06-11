import 'package:employee_management_system/core/app_exports.dart';
import 'package:table_calendar/table_calendar.dart';

class AddTask extends StatefulWidget {
  final UserModel employee;
  const AddTask({super.key, required this.employee});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _taskController = Get.find<TaskController>();
  var _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();

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
          'Add Task',
          style: AppTextStyles.screenName,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: TableCalendar(
                      firstDay: DateTime.utc(2000, 1, 1),
                      lastDay: DateTime.utc(2100, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDate, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDate = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: const Color(0xFF00C853),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.circle,
                        ),
                        weekendTextStyle: const TextStyle(color: Colors.black),
                        defaultTextStyle: const TextStyle(color: Colors.black),
                        todayTextStyle: const TextStyle(color: Colors.black),
                        selectedTextStyle: const TextStyle(color: Colors.white),
                      ),
                      headerStyle: HeaderStyle(
                        titleTextStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronIcon:
                            const Icon(Icons.chevron_left, color: Colors.black),
                        rightChevronIcon: const Icon(Icons.chevron_right,
                            color: Colors.black),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(fontWeight: FontWeight.w500),
                        weekendStyle: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 0.02.sh),
                  Text(
                    'Information',
                    style: AppTextStyles.bodyText,
                  ),
                  SizedBox(height: 0.02.sh),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          labelText: 'Title',
                          type: TextInputType.text,
                          controller: _taskController.titleController,
                          validator: (value) =>
                              AppValidators.validateName(value, 'Title'),
                        ),
                        SizedBox(height: 0.02.sh),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                isReadOnly: true,
                                labelText: 'Start Time',
                                type: TextInputType.datetime,
                                controller: _taskController.startController,
                                validator: (value) =>
                                    AppValidators.validateTimeField(
                                  value: value,
                                  label: 'Start Time',
                                  startTimeText: null,
                                ),
                                onTapField: () async {
                                  final TimeOfDay? pickedTime =
                                      await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedTime != null) {
                                    _taskController.startController.text =
                                        pickedTime.format(context);
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 0.02.sw),
                            Expanded(
                              child: CustomTextField(
                                isReadOnly: true,
                                labelText: 'End Time',
                                type: TextInputType.datetime,
                                controller: _taskController.endController,
                                validator: (value) =>
                                    AppValidators.validateTimeField(
                                  value: value,
                                  label: 'End Time',
                                  startTimeText:
                                      _taskController.startController.text,
                                ),
                                onTapField: () async {
                                  final TimeOfDay? pickedTime =
                                      await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedTime != null) {
                                    _taskController.endController.text =
                                        pickedTime.format(context);
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 0.02.sh),
                          ],
                        ),
                        SizedBox(height: 0.02.sh),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                labelText: 'Location',
                                type: TextInputType.text,
                                controller: _taskController.locationController,
                                validator: (value) =>
                                    AppValidators.validateName(
                                        value, 'Location'),
                              ),
                            ),
                            SizedBox(width: 0.02.sw),
                            Expanded(
                              child: CustomTextField(
                                labelText: 'Status',
                                type: TextInputType.text,
                                controller: _taskController.statusController,
                                validator: (value) =>
                                    AppValidators.validateName(value, 'Status'),
                              ),
                            ),
                            SizedBox(height: 0.02.sh),
                          ],
                        ),
                        SizedBox(height: 0.03.sh),
                        Obx(
                          () => _taskController.isLoading.value
                              ? CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : PrimaryButton(
                                  text: 'Add Task',
                                  bgColor: AppColors.primaryColor,
                                  ontap: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (_selectedDate == null) {
                                        Get.snackbar('Date Missing',
                                            'Please Select a date for the Task.');
                                        return;
                                      }
                                      _taskController.addTask(
                                          selectedDate: _selectedDate!,
                                          employeeID: widget.employee.uid);
                                    }
                                  }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
