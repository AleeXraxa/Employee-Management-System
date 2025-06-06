import 'package:employee_management_system/core/app_exports.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();

  void clearFields() {
    emailController.clear();
    passController.clear();
    nameController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    super.dispose();
  }

  // Firebase Error Handler
  void handleFirebaseError(dynamic error) {
    String message = 'An unexpected error occurred';

    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          message = 'Invalid email address.';
          break;
        case 'user-disabled':
          message = 'This user has been disabled.';
          break;
        case 'user-not-found':
          message = 'No user found with this email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password.';
          break;
        case 'email-already-in-use':
          message = 'This email is already in use.';
          break;
        case 'weak-password':
          message = 'Password is too weak.';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled.';
          break;
        default:
          message = error.message ?? 'Authentication error';
      }
    } else if (error is FirebaseException) {
      message = error.message ?? 'Firebase error occurred';
    } else if (error is PlatformException) {
      message = error.message ?? 'Platform error occurred';
    } else {
      message = error.toString();
    }

    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade900,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

// Authentication Logics
  final FirebaseAuth usersDatabase = FirebaseAuth.instance;
  final FirebaseFirestore database = FirebaseFirestore.instance;
  RxBool isloading = false.obs;

// Create user
  final RxnString selectedRole = RxnString();

  Future<void> registerUser() async {
    try {
      var email = emailController.text.trim();
      var username = nameController.text.toLowerCase();
      var pass = passController.text.trim();
      isloading.value = true;

      UserCredential userCredential = await usersDatabase
          .createUserWithEmailAndPassword(email: email, password: pass);

      User? user = userCredential.user;

      if (user != null && !user.emailVerified) {
        await database.collection('users').doc(user.uid).set({
          'username': username,
          'email': user.email,
          'role': selectedRole.value,
          'isApproved': selectedRole.value == 'Client' ? true : false,
        });
        await user.sendEmailVerification();
        showCustomDialog(
          icon: FontAwesomeIcons.solidCircleCheck,
          title: 'Account Created Successfully',
          message: 'Please verify your email',
          buttonText: 'Continue',
          onPressed: () {
            Get.offAll(() => Login());
          },
        );
      }

      clearFields();
    } on FirebaseAuthException catch (e) {
      handleFirebaseError(e);
    } finally {
      isloading.value = false;
    }
  }

  // Login User with Email and Password

  Future<void> loginUser() async {
    try {
      var email = emailController.text.trim();
      var pass = passController.text.trim();
      isloading.value = true;

      UserCredential userCredential = await usersDatabase
          .signInWithEmailAndPassword(email: email, password: pass);

      User? user = userCredential.user;

      if (user != null && user.emailVerified) {
        final userDoc = await database.collection('users').doc(user.uid).get();

        var role = userDoc['role'];
        var isApproved = userDoc['isApproved'];

        if (isApproved) {
          if (role == 'admin') {
            Get.snackbar('Admin', 'Welcome Admin');
          } else if (role == 'Employee') {
            Get.snackbar('Employee', 'Welcome Employee');
          } else if (role == 'Client') {
            Get.snackbar('Client', 'Welcome Client');
          } else {
            showCustomDialog(
                icon: FontAwesomeIcons.exclamation,
                title: 'Invalid Role',
                message: 'Your role is invalid');
          }
          clearFields();
        } else {
          showCustomDialog(
              icon: FontAwesomeIcons.solidCircleXmark,
              title: 'Approval Required',
              message: 'Waiting for Approval from HR');
          clearFields();
        }
      } else {
        user!.sendEmailVerification();
        showCustomDialog(
            icon: FontAwesomeIcons.solidCircleXmark,
            title: 'Email Verification Required',
            message: 'Please verify your email to login');
        clearFields();
      }
    } on FirebaseAuthException catch (e) {
      handleFirebaseError(e);
    } finally {
      isloading.value = false;
    }
  }
}
