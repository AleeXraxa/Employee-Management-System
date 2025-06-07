import 'package:employee_management_system/core/app_exports.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth userDB = FirebaseAuth.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(uid, doc.data()!);
    }
    return null;
  }

  Future<UserModel?> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await userDB.signInWithCredential(credential);
    User? user = userCredential.user;
    if (user == null) return null;
    final doc = await _db.collection('users').doc(user.uid).get();

    if (!doc.exists) {
      final newUser = UserModel(
        uid: user.uid,
        username: googleUser.displayName?.split(" ").first.toLowerCase() ?? '',
        fname: googleUser.displayName?.split(" ").first ?? '',
        lname: googleUser.displayName?.split(" ").last ?? '',
        email: user.email ?? '',
        role: 'Client',
        isApproved: true,
      );
      await _db.collection('users').doc(user.uid).set(newUser.toMap());
      return newUser;
    } else {
      return UserModel.fromMap(user.uid, doc.data()!);
    }
  }
}
