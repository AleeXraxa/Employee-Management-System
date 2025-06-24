import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  static const cloudName = 'dnbaj9lqb';
  static const uploadPreset = 'task_upload';

  static Future<String?> uploadImage(File imageFile) async {
    final uri =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final resData = await response.stream.bytesToString();
      final data = jsonDecode(resData);
      return data['secure_url'];
    } else {
      print('Upload failed: ${response.statusCode}');
      return null;
    }
  }

  static Future<List<String>> uploadMultipleImages(List<File> images) async {
    List<String> urls = [];

    for (var img in images) {
      final url = await uploadImage(img);
      if (url != null) {
        urls.add(url);
      }
    }

    return urls;
  }
}
