import 'package:employee_management_system/core/app_exports.dart';
import 'package:intl/intl.dart';

class AttendanceController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTodayAttendance(UserModel user) async {
    final now = DateTime.now();
    final docId = DateFormat('yyyy-MM-dd').format(now);

    final docRef = _db
        .collection('users')
        .doc(user.uid)
        .collection('attendance')
        .doc(docId);

    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      await docRef.set({
        'date': Timestamp.fromDate(DateTime(now.year, now.month, now.day)),
        'checkIn': null,
        'checkOut': null,
        'status': 'present',
        'employeeId': user.uid,
      });
      print('Attendance Marked');
    } else {
      await docRef.update({
        'status': 'present',
      });
    }
  }

  Future<void> markAbsent(UserModel user) async {
    final now = DateTime.now();
    final docId = DateFormat('yyyy-MM-dd').format(now);

    final docRef = _db
        .collection('users')
        .doc(user.uid)
        .collection('attendance')
        .doc(docId);

    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      await docRef.set({
        'date': Timestamp.fromDate(DateTime(now.year, now.month, now.day)),
        'checkIn': null,
        'checkOut': null,
        'status': 'absent',
        'employeeId': user.uid,
      });
      Get.snackbar('Marked Absent', '${user.username} marked as absent');
    } else {
      await docRef.update({
        'status': 'absent',
        'checkIn': null,
        'checkOut': null,
      });
      showCustomDialog(
          icon: FontAwesomeIcons.solidCircleCheck,
          title: 'Absent Marked',
          message: '${user.username} is Marked absent for Today',
          buttonText: 'Continue',
          onPressed: () {
            Get.back();
          });
    }
  }

  Future<void> markCheckIn() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final now = DateTime.now();
    final docId = DateFormat('yyyy-MM-dd').format(now);

    final docRef =
        _db.collection('users').doc(userId).collection('attendance').doc(docId);

    final snapshot = await docRef.get();
    final data = snapshot.data();

    if (!snapshot.exists || data == null) {
      Get.snackbar('Error', 'Attendance record not found');
      return;
    }

    if (data['status'] == 'absent') {
      showCustomDialog(
          icon: FontAwesomeIcons.solidCircleXmark,
          title: 'Restricted',
          message: 'You are marked absent for today by HR',
          buttonText: 'Continue',
          onPressed: () {
            Get.back();
          });
      return;
    }

    if (data['checkIn'] != null) {
      Get.snackbar('Already Checked In', 'You have already checked in today');
      return;
    }

    await docRef.update({
      'checkIn': Timestamp.fromDate(now),
      'status': 'present',
    });

    showCustomDialog(
        icon: FontAwesomeIcons.solidCircleCheck,
        title: 'CheckIn Recorded',
        message: 'You have succesffuly checkedIn',
        buttonText: 'Continue',
        onPressed: () {
          Get.back();
        });
  }

  Future<void> markCheckOut() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final now = DateTime.now();
    final docId = DateFormat('yyyy-MM-dd').format(now);

    final docRef =
        _db.collection('users').doc(userId).collection('attendance').doc(docId);

    final snapshot = await docRef.get();
    final data = snapshot.data();

    if (!snapshot.exists || data == null) {
      Get.snackbar('Error', 'Attendance record not found');
      return;
    }

    if (data['status'] == 'absent') {
      Get.snackbar('Restricted', 'You are marked absent today');
      return;
    }

    if (data['checkOut'] != null) {
      Get.snackbar('Already Checked Out', 'You have already checked out today');
      return;
    }

    await docRef.update({
      'checkOut': Timestamp.fromDate(now),
    });

    showCustomDialog(
        icon: FontAwesomeIcons.solidCircleCheck,
        title: 'CheckOut Recorded',
        message: 'You have succesffuly checkedOut',
        buttonText: 'Continue',
        onPressed: () {
          Get.back();
        });
  }

  var attendanceList = <AttendanceModel>[].obs;

  var todayAttendanceList = <AttendanceModel>[].obs;

  void bindTodayAttendanceStream() {
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());

    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((usersSnapshot) {
      todayAttendanceList.clear();

      for (var userDoc in usersSnapshot.docs) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userDoc.id)
            .collection('attendance')
            .doc(todayKey)
            .snapshots()
            .listen((attendanceDoc) {
          if (attendanceDoc.exists) {
            final updatedModel = AttendanceModel.fromMap(
                attendanceDoc.id, attendanceDoc.data()!);

            todayAttendanceList
                .removeWhere((att) => att.employeeId == userDoc.id);

            todayAttendanceList.add(updatedModel);
          } else {
            todayAttendanceList
                .removeWhere((att) => att.employeeId == userDoc.id);
          }
        });
      }
    });
  }

  String getWorkedDuration(DateTime? checkIn, DateTime? checkOut) {
    if (checkIn == null) return '–';

    final endTime = checkOut ?? DateTime.now();
    Duration duration = endTime.difference(checkIn);

    if (duration > Duration(hours: 8)) {
      duration = Duration(hours: 8);
    }

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours == 0 && minutes == 0) return '0 mins';

    final hoursStr = hours > 0 ? '$hours hr${hours > 1 ? 's' : ''}' : '';
    final minutesStr =
        minutes > 0 ? '$minutes min${minutes > 1 ? 's' : ''}' : '';

    final result = '$hoursStr ${minutesStr.trim()}'.trim();

    return result;
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  Duration getWorkedDurationRaw(DateTime? checkIn, DateTime? checkOut) {
    if (checkIn == null) return Duration.zero;

    final endTime = checkOut ?? DateTime.now();
    Duration duration = endTime.difference(checkIn);

    if (duration > Duration(hours: 8)) {
      duration = Duration(hours: 8);
    }
    return duration;
  }

  final isLoading = true.obs;

  void fetchAttendance(String employeeId) {
    isLoading.value = true;

    _db
        .collection('users')
        .doc(employeeId)
        .collection('attendance')
        .orderBy('date', descending: true)
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.docs
          .map((doc) => AttendanceModel.fromMap(doc.id, doc.data()))
          .toList();

      attendanceList.value = data;
      filteredAttendanceList.assignAll(data);
      isLoading.value = false;
    });
  }

  final searchController = TextEditingController();
  final filteredAttendanceList = <AttendanceModel>[].obs;

  void filterAttendanceByDate() {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      filteredAttendanceList.assignAll(attendanceList);
      return;
    }

    filteredAttendanceList.assignAll(
      attendanceList.where((att) {
        final formattedDate =
            DateFormat('dd MMM yyyy').format(att.date).toLowerCase();
        final altFormat =
            DateFormat('dd MMMM yyyy').format(att.date).toLowerCase();
        return formattedDate.contains(query) || altFormat.contains(query);
      }).toList(),
    );
  }

  Future<void> requestLeave() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final now = DateTime.now();
    final docId = DateFormat('yyyy-MM-dd').format(now);

    final docRef =
        _db.collection('users').doc(userId).collection('attendance').doc(docId);

    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      await docRef.set({
        'date': Timestamp.fromDate(now),
        'status': 'leaveRequested',
        'checkIn': null,
        'checkOut': null,
        'employeeId': userId,
      });
    } else {
      await docRef.update({'status': 'leaveRequested'});
    }

    Get.snackbar('Leave Requested', 'Leave request sent to admin.');
  }

  Future<void> approveLeave(UserModel user) async {
    final now = DateTime.now();
    final docId = DateFormat('yyyy-MM-dd').format(now);

    await _db
        .collection('users')
        .doc(user.uid)
        .collection('attendance')
        .doc(docId)
        .update({'status': 'leave'});

    Get.snackbar('Leave Approved', '${user.username} leave approved.');
  }

  Future<void> rejectLeave(UserModel user) async {
    final now = DateTime.now();
    final docId = DateFormat('yyyy-MM-dd').format(now);

    await _db
        .collection('users')
        .doc(user.uid)
        .collection('attendance')
        .doc(docId)
        .update({'status': 'present'});

    Get.snackbar('Leave Rejected', '${user.username} leave rejected.');
  }
}
