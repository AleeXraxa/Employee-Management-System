import 'package:employee_management_system/core/app_exports.dart';

class HrServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _authController = Get.find<AuthController>();
  final isloading = false.obs;

  Future<List<UserModel>> getAllEmp() async {
    final snapshot = await _db
        .collection('users')
        .where('role', isEqualTo: 'Employee')
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> updateApprovalStatus(String id, bool isApproved) async {
    try {
      await _db.collection('users').doc(id).update({
        'isApproved': isApproved,
      });
    } catch (e) {
      _authController.handleFirebaseError(e);
    } finally {
      isloading.value = false;
    }
  }
}
