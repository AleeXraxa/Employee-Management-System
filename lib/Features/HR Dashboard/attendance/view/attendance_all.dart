import 'package:employee_management_system/core/app_exports.dart';

class ViewAllAttendance extends StatefulWidget {
  final String employeeID;
  const ViewAllAttendance({super.key, required this.employeeID});

  @override
  State<ViewAllAttendance> createState() => _ViewAllAttendanceState();
}

class _ViewAllAttendanceState extends State<ViewAllAttendance> {
  final attendanceController = Get.find<AttendanceController>();

  @override
  void initState() {
    super.initState();
    attendanceController.fetchAttendance(widget.employeeID);
    attendanceController.searchController
        .addListener(attendanceController.filterAttendanceByDate);
  }

  @override
  void dispose() {
    attendanceController.searchController
        .removeListener(attendanceController.filterAttendanceByDate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.1.sh,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Employee's Attendance",
            style: AppTextStyles.screenName,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  prefix: FontAwesomeIcons.magnifyingGlass,
                  labelText: 'Search Day',
                  type: TextInputType.text,
                  controller: attendanceController.searchController,
                  validator: (value) =>
                      AppValidators.validateName(value, 'Search'),
                ),
                SizedBox(height: 0.03.sh),
                Text(
                  'Attendance List :',
                  style: AppTextStyles.title,
                ),
                Expanded(
                  child: Obx(() {
                    if (attendanceController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (attendanceController.filteredAttendanceList.isEmpty) {
                      return Center(child: Text("No Attendance Found"));
                    }

                    return ListView.builder(
                      itemCount:
                          attendanceController.filteredAttendanceList.length,
                      itemBuilder: (context, index) {
                        final att =
                            attendanceController.filteredAttendanceList[index];
                        return AttendaceCard(
                          status: att.status.capitalizeFirst ?? '-',
                          dateDay: attendanceController.formatDate(att.date),
                          timeIn: att.checkIn != null
                              ? attendanceController.formatTime(att.checkIn!)
                              : '--',
                          timeOut: att.checkOut != null
                              ? attendanceController.formatTime(att.checkOut!)
                              : '--',
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        )));
  }
}
