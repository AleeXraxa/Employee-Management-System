import 'package:employee_management_system/core/app_exports.dart';

class InternetChecker extends GetxController {
  var isConnected = true.obs;
  final Connectivity _connectivity = Connectivity();

  Future<void> checkConnection() async {
    final connectionResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    isConnected.value = connectionResult != ConnectivityResult.none;
  }

  @override
  void onInit() {
    super.onInit();

    _connectivity.onConnectivityChanged.listen((status) {
      // ignore: unrelated_type_equality_checks
      isConnected.value = status != ConnectivityResult.none;
    });
  }
}
