import 'package:employee_management_system/core/app_exports.dart';

class InternetChecker extends GetxController {
  var isConnected = true.obs;
  final Connectivity _connectivity = Connectivity();

  Future<void> checkConnection() async {
    final connectionResult = await Connectivity().checkConnectivity();
    isConnected.value = connectionResult != ConnectivityResult.none;
  }

  @override
  void onInit() {
    super.onInit();

    _connectivity.onConnectivityChanged.listen((status) {
      isConnected.value = status != ConnectivityResult.none;
    });
  }
}
