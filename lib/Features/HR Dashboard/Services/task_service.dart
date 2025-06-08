import 'package:employee_management_system/core/app_exports.dart';

class TaskService {
  final _db = FirebaseFirestore.instance;

  // CREATE
  Future<void> addTask(String empId, TaskModel task) async {
    final docRef = _db.collection('users').doc(empId).collection('tasks').doc();
    await docRef.set(task.copyWith(id: docRef.id).toMap());
  }

  // READ
  Future<List<TaskModel>> getTasks(String empId) async {
    final snapshot =
        await _db.collection('users').doc(empId).collection('tasks').get();
    return snapshot.docs
        .map((doc) => TaskModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  // UPDATE
  Future<void> updateTask(String empId, TaskModel task) async {
    await _db
        .collection('users')
        .doc(empId)
        .collection('tasks')
        .doc(task.id)
        .update(task.toMap());
  }

  // DELETE
  Future<void> deleteTask(String empId, String taskId) async {
    await _db
        .collection('users')
        .doc(empId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
}
