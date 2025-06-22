import 'package:employee_management_system/core/app_exports.dart';
import 'package:intl/intl.dart';

class AttendanceController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> markCheckIn() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final now = DateTime.now();
    final docId = DateFormat('yyyy-MM-dd').format(now);

    final docRef =
        _db.collection('users').doc(userId).collection('attendance').doc(docId);

    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      await docRef.set({
        'date': Timestamp.fromDate(DateTime(now.year, now.month, now.day)),
        'checkIn': Timestamp.fromDate(now),
        'checkOut': null,
        'status': 'present',
      });
      Get.snackbar('Success', 'Check-in recorded');
    } else {
      Get.snackbar('Already Checked In', 'You have already checked in today.');
    }
  }

  Future<void> markCheckOut() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final now = DateTime.now();
    final docId = DateFormat('yyyy-MM-dd').format(now);

    final docRef =
        _db.collection('users').doc(userId).collection('attendance').doc(docId);

    final snapshot = await docRef.get();

    if (snapshot.exists && snapshot.data()?['checkOut'] == null) {
      await docRef.update({
        'checkOut': Timestamp.fromDate(now),
      });
      Get.snackbar('Success', 'Check-out recorded');
    } else {
      Get.snackbar(
          'Already Checked Out', 'You have already checked out today.');
    }
  }

  var attendanceList = <AttendanceModel>[].obs;

  void bindAttendanceStreamForEmployee(String employeeId) {
    final attendanceRef = _db
        .collection('users')
        .doc(employeeId)
        .collection('attendance')
        .orderBy('date', descending: true);

    attendanceRef.snapshots().listen((snapshot) {
      attendanceList.value = snapshot.docs
          .map((doc) => AttendanceModel.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  var todayAttendanceList = <AttendanceModel>[].obs;

  void bindTodayAttendanceStream() {
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());

    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((usersSnapshot) {
      todayAttendanceList.clear(); // reset list before repopulating

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

            // remove old if exists
            todayAttendanceList
                .removeWhere((att) => att.employeeId == userDoc.id);

            // add updated
            todayAttendanceList.add(updatedModel);
          } else {
            // If deleted or missing, remove from list
            todayAttendanceList
                .removeWhere((att) => att.employeeId == userDoc.id);
          }
        });
      }
    });
  }

  String getWorkedDuration(DateTime? checkIn, DateTime? checkOut) {
    print('📍 checkIn: $checkIn');
    print('📍 checkOut: $checkOut');

    if (checkIn == null) return '–';

    final endTime = checkOut ?? DateTime.now();
    Duration duration = endTime.difference(checkIn);

    if (duration > Duration(hours: 8)) {
      duration = Duration(hours: 8);
    }

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    print('⏱ Duration: $hours hrs, $minutes mins');

    if (hours == 0 && minutes == 0) return '0 mins';

    final hoursStr = hours > 0 ? '$hours hr${hours > 1 ? 's' : ''}' : '';
    final minutesStr =
        minutes > 0 ? '$minutes min${minutes > 1 ? 's' : ''}' : '';

    final result = '$hoursStr ${minutesStr.trim()}'.trim();
    print('🟢 Final duration string: "$result"');
    return result;
  }

  // dummy record adding
  Future<void> addDummyAttendance({required String userId}) async {
    try {
      final now = DateTime.now();
      final todayKey = DateFormat('yyyy-MM-dd').format(now); // Used as doc ID

      final attendance = AttendanceModel(
        id: todayKey,
        employeeId: userId,
        date: now,
        checkIn: now, // ✅ Correct type (DateTime)
        checkOut: null,
        status: 'present',
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('attendance')
          .doc(todayKey)
          .set(attendance.toMap());
      print("✅ Dummy attendance added for user: $userId");
    } catch (e) {
      print('❌ Error: $e');
    }
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

  @override
  void onInit() {
    super.onInit();
    bindTodayAttendanceStream();
  }
}
