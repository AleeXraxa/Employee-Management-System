import 'package:employee_management_system/core/app_exports.dart';

class HrServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllEmp() async {
    final snapshot = await _db
        .collection('users')
        .where('role', isEqualTo: 'Employee')
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
