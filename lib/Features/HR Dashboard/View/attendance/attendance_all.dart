import 'package:employee_management_system/core/app_exports.dart';

class ViewAllAttendance extends StatefulWidget {
  const ViewAllAttendance({super.key});

  @override
  State<ViewAllAttendance> createState() => _ViewAllAttendanceState();
}

class _ViewAllAttendanceState extends State<ViewAllAttendance> {
  final TextEditingController _controller = TextEditingController();
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
            child: SingleChildScrollView(
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
                    controller: _controller,
                    validator: (value) =>
                        AppValidators.validateName(value, 'Search'),
                  ),
                  SizedBox(height: 0.03.sh),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Attendance List :',
                          style: AppTextStyles.title,
                        ),
                        AttendaceCard(
                          status: 'Present',
                          dateDay: 'Janaury 01, 2025',
                          timeIn: '08:57 AM',
                          timeOut: '05: 32 PM',
                        ),
                        AttendaceCard(
                          status: 'Absent',
                          dateDay: 'Janaury 02, 2025',
                          timeIn: '08:57 AM',
                          timeOut: '05:32 PM',
                        ),
                        AttendaceCard(
                          status: 'Present',
                          dateDay: 'Janaury 03, 2025',
                          timeIn: '08:57 AM',
                          timeOut: '05: 32 PM',
                        ),
                        AttendaceCard(
                          status: 'Present',
                          dateDay: 'Janaury 04, 2025',
                          timeIn: '08:57 AM',
                          timeOut: '05: 32 PM',
                        ),
                        AttendaceCard(
                          status: 'Present',
                          dateDay: 'Janaury 05, 2025',
                          timeIn: '08:57 AM',
                          timeOut: '05: 32 PM',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
