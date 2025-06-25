import 'dart:io';

import 'package:employee_management_system/core/app_exports.dart';

class ImageHelper {
  static Future<File?> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      return File(picked.path);
    }
    return null;
  }
}
