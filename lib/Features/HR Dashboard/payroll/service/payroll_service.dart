import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_management_system/Features/HR%20Dashboard/payroll/model/payroll_model.dart';
import 'package:intl/intl.dart';

class PayrollService {
  static Future<Map<String, dynamic>> generatePayrollForEmployee({
    required String employeeId,
    required double dailyWage,
  }) async {
    final now = DateTime.now();
    final String month = DateFormat('MMMM').format(now);
    final String year = now.year.toString();

    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(employeeId)
        .collection('payroll')
        .doc('$month-$year');

    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(employeeId)
        .collection('attendance')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(firstDay))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(lastDay))
        .get();

    int present = 0;
    int absent = 0;
    int leave = 0;
    double totalHours = 0.0;

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final status = data['status'];
      final checkIn = (data['checkIn'] as Timestamp?)?.toDate();
      final checkOut = (data['checkOut'] as Timestamp?)?.toDate();

      switch (status) {
        case 'present':
          present++;
          break;
        case 'absent':
          absent++;
          break;
        case 'leave':
          leave++;
          break;
      }

      if (checkIn != null && checkOut != null) {
        double hours = checkOut.difference(checkIn).inMinutes / 60.0;
        if (hours > 8) hours = 8;
        totalHours += hours;
      }
    }

    final payableDays = present + leave;
    final double basicSalary = payableDays * dailyWage;
    final double hourlyRate = dailyWage / 8;
    final double expectedHours = payableDays * 8;

    double bonus = 0;
    if (absent == 0 && leave == 0) bonus += 1000;
    final overtime = totalHours - expectedHours;
    if (overtime > 0) bonus += overtime * hourlyRate;

    final totalSalary = basicSalary + bonus;

    final payroll = PayrollModel(
      employeeId: employeeId,
      presentDays: present,
      absentDays: absent,
      leaveDays: leave,
      basicSalary: basicSalary,
      bonus: bonus,
      totalSalary: totalSalary,
      month: month,
      year: year,
    );

    await docRef.set(payroll.toMap(), SetOptions(merge: true));

    return {
      'present': present,
      'absent': absent,
      'leave': leave,
      'basic': basicSalary,
      'bonus': bonus,
      'total': totalSalary,
      'month': month,
      'year': year,
    };
  }

  static Future<List<double>> getWeeklyAverageWorkingHours(
      String employeeId) async {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(employeeId)
        .collection('attendance')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(firstDay))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(lastDay))
        .get();

    Map<int, List<double>> dailyHours = {
      1: [],
      2: [],
      3: [],
      4: [],
      5: [],
      6: [],
      7: [],
    };

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final checkIn = (data['checkIn'] as Timestamp?)?.toDate();
      final checkOut = (data['checkOut'] as Timestamp?)?.toDate();

      if (checkIn != null && checkOut != null) {
        double hours = checkOut.difference(checkIn).inMinutes / 60.0;
        if (hours > 8) hours = 8;
        final dayOfWeek = checkIn.weekday;
        dailyHours[dayOfWeek]?.add(hours);
      }
    }

    List<double> averageHours = [];
    for (int i = 1; i <= 7; i++) {
      final hoursList = dailyHours[i]!;
      final avg = hoursList.isEmpty
          ? 0.0
          : hoursList.reduce((a, b) => a + b) / hoursList.length;
      averageHours.add(double.parse(avg.toStringAsFixed(1))); // round
    }

    return averageHours;
  }
}
