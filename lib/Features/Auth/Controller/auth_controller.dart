import 'package:employee_management_system/Features/Employee%20Dashboard/Dashboard/View/emp_bar.dart';
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

// Authentication Logics
  final FirebaseAuth usersDB = FirebaseAuth.instance;
  final AuthServices _authServices = AuthServices();
  RxBool isloading = false.obs;

  final Rxn<UserModel> currentUser = Rxn<UserModel>();

// Create user
  final RxnString selectedRole = RxnString();

  Future<void> registerUser() async {
    try {
      isloading.value = true;

      final email = emailController.text.trim();
      final username = nameController.text;
      final pass = passController.text;

      UserCredential userCredential = await usersDB
          .createUserWithEmailAndPassword(email: email, password: pass);

      User? user = userCredential.user;

      if (user != null) {
        final newUser = UserModel(
          uid: user.uid,
          username: username,
          fname: '',
          lname: '',
          email: email,
          role: selectedRole.value!,
          isApproved: selectedRole.value == 'Employee' ? false : true,
        );

        await _authServices.createUser(newUser);
        await user.sendEmailVerification();

        showCustomDialog(
          icon: FontAwesomeIcons.solidCircleCheck,
          title: 'Account Created',
          message: 'Please check your mail to verify your account',
          buttonText: 'Continue',
          onPressed: () => Get.offAll(Login()),
        );
        clearFields();
      }
    } catch (e) {
      handleFirebaseError(e);
    } finally {
      isloading.value = false;
    }
  }

// Login User

  Future<void> loginUser() async {
    try {
      isloading.value = true;
      final email = emailController.text.trim();
      final pass = passController.text.trim();

      UserCredential userCredential = await usersDB.signInWithEmailAndPassword(
          email: email, password: pass);

      User? user = userCredential.user;

      if (user != null && user.emailVerified) {
        final userData = await _authServices.getUser(user.uid);
        if (userData != null) {
          currentUser.value = userData;
          if (userData.role == 'Admin') {
            Get.offAll(HRDashboard());
          } else if (userData.role == 'Employee') {
            if (userData.isApproved) {
              await Get.find<AttendanceController>()
                  .addTodayAttendance(userData);
              Get.offAll(() => EmployeeDashboard(
                    employee: userData,
                  ));
            } else {
              showCustomDialog(
                  icon: FontAwesomeIcons.solidCircleXmark,
                  title: 'Approval Required',
                  message: 'Your accout is pending for approval',
                  buttonText: 'Continue',
                  onPressed: () {
                    Get.back();
                  });
            }
          } else if (userData.role == 'Client') {
            Get.snackbar('Login Success', 'Welcome Client');
          } else {
            showCustomDialog(
                icon: FontAwesomeIcons.solidCircleXmark,
                title: 'Invalid Role',
                message: 'Your Role is Invalid',
                buttonText: 'Resend',
                onPressed: () {
                  Get.back();
                });
          }
        }
      } else {
        showCustomDialog(
            icon: FontAwesomeIcons.solidCircleXmark,
            title: 'Verification Required',
            message: 'Please verify your email first',
            buttonText: 'Continue',
            onPressed: () async {
              await user?.sendEmailVerification();
              Get.back();
            });
      }
      clearFields();
    } catch (e) {
      handleFirebaseError(e);
    } finally {
      isloading.value = false;
    }
  }

// Forgot Password
  Future<void> forgotPass() async {
    try {
      isloading.value = true;
      final email = emailController.text.trim();

      await usersDB.sendPasswordResetEmail(email: email);
      showCustomDialog(
          icon: FontAwesomeIcons.solidCircleCheck,
          title: 'Email Sent',
          message: 'Please check your Email for reset link.',
          buttonText: 'Continue',
          onPressed: () async {
            Get.offAll(Login());
          });
      clearFields();
    } catch (e) {
      handleFirebaseError(e);
    } finally {
      isloading.value = false;
    }
  }

  // Login with Google
  Future<void> signInWithGoogle() async {
    try {
      isloading.value = true;
      final user = await _authServices.loginWithGoogle();
      if (user != null) {
        currentUser.value = user;
        if (user.role == 'Admin') {
          Get.offAll(HRDashboard());
        } else if (user.role == 'Employee') {
          if (user.isApproved) {
            await Get.find<AttendanceController>().addTodayAttendance(user);
            Get.offAll(() => EmployeeDashboard(
                  employee: user,
                ));
          } else {
            showCustomDialog(
                icon: FontAwesomeIcons.solidCircleXmark,
                title: 'Approval Required',
                message: 'Your accout is pending for approval',
                buttonText: 'Continue',
                onPressed: () {
                  Get.back();
                });
          }
        } else if (user.role == 'Client') {
          Get.snackbar('Login Success', 'Welcome Client');
        } else {
          showCustomDialog(
              icon: FontAwesomeIcons.solidCircleXmark,
              title: 'Invalid Role',
              message: 'Your Role is Invalid',
              buttonText: 'Resend',
              onPressed: () {
                Get.back();
              });
        }
      }
    } catch (e) {
      handleFirebaseError(e);
    } finally {
      isloading.value = false;
    }
  }

  Future<void> logout() async {
    await usersDB.signOut();
    await GoogleSignIn().signOut();
    Get.offAll(Login());
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
}
