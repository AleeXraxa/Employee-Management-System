class TaskModel {
  final String id;
  final String taskTitle;
  final String description;
  final String day;
  final String startTime;
  final String endTime;
  final String status;

  TaskModel({
    required this.id,
    required this.taskTitle,
    required this.description,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  // Add this copyWith method:
  TaskModel copyWith({
    String? id,
    String? taskTitle,
    String? description,
    String? day,
    String? startTime,
    String? endTime,
    String? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      taskTitle: taskTitle ?? this.taskTitle,
      description: description ?? this.description,
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskTitle': taskTitle,
      'description': description,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
    };
  }

  factory TaskModel.fromMap(String id, Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      taskTitle: map['taskTitle'] ?? '',
      description: map['description'] ?? '',
      day: map['day'] ?? '',
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      status: map['status'] ?? '',
    );
  }
}
