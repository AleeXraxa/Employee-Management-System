import 'package:employee_management_system/core/app_exports.dart';

class AttendanceModel {
  final String id;
  final String employeeID;
  final DateTime date;
  final String status;
  final String? checkIn;
  final String? checkOut;
  final String markedBy;

  AttendanceModel({
    required this.id,
    required this.employeeID,
    required this.date,
    required this.status,
    this.checkIn,
    this.checkOut,
    required this.markedBy,
  });

  factory AttendanceModel.fromMap(String id, Map<String, dynamic> data) {
    return AttendanceModel(
      id: id,
      employeeID: data['employeeID'],
      date: (data['date'] as Timestamp).toDate(),
      status: data['status'],
      checkIn: data['checkIn'],
      checkOut: data['checkOut'],
      markedBy: data['markedBy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employeeID': employeeID,
      'date': date,
      'status': status,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'markedBy': markedBy,
    };
  }
}
