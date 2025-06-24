import 'package:employee_management_system/core/app_exports.dart';

class TaskModel {
  final String? id;
  final String title;
  final String time;
  final String location;
  final String status;
  final DateTime date;
  final String createdBy;
  final String assignedTo;
  final String progressStatus;
  final List<String>? imgUrls;

  TaskModel({
    this.id,
    required this.title,
    required this.time,
    required this.location,
    required this.status,
    required this.date,
    required this.createdBy,
    required this.assignedTo,
    this.progressStatus = 'pending',
    this.imgUrls,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'time': time,
      'location': location,
      'status': status,
      'date': Timestamp.fromDate(date),
      'createdBy': createdBy,
      'assignedTo': assignedTo,
      'progressStatus': progressStatus,
      'imgUrls': imgUrls ?? [],
    };
  }

  factory TaskModel.fromMap(String id, Map<String, dynamic> map) {
    return TaskModel(
      id: id,
      title: map['title'],
      time: map['time'],
      location: map['location'],
      status: map['status'],
      date: (map['date'] as Timestamp).toDate(),
      createdBy: map['createdBy'],
      assignedTo: map['assignedTo'],
      progressStatus: map['progressStatus'] ?? 'pending',
      imgUrls: List<String>.from(map['imgUrls'] ?? []),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
