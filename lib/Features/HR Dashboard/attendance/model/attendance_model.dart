import 'package:employee_management_system/core/app_exports.dart';

class AttendanceModel {
  final String id;
  final String employeeId;
  final DateTime date;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String status;

  AttendanceModel({
    required this.id,
    required this.employeeId,
    required this.date,
    this.checkIn,
    this.checkOut,
    required this.status,
  });

  factory AttendanceModel.fromMap(String id, Map<String, dynamic> map) {
    return AttendanceModel(
      id: id,
      employeeId: map['employeeId'],
      date: (map['date'] as Timestamp).toDate(),
      checkIn: map['checkIn'] != null
          ? (map['checkIn'] as Timestamp).toDate()
          : null,
      checkOut: map['checkOut'] != null
          ? (map['checkOut'] as Timestamp).toDate()
          : null,
      status: map['status'] ?? 'present',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'date': Timestamp.fromDate(date),
      'checkIn': checkIn != null ? Timestamp.fromDate(checkIn!) : null,
      'checkOut': checkOut != null ? Timestamp.fromDate(checkOut!) : null,
      'status': status,
    };
  }
}
