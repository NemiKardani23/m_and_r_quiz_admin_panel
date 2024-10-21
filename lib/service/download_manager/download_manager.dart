import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class DownloadManager {
  final Dio _dio;

  // Constructor to create an instance of Dio
  DownloadManager({Dio? dio}) : _dio = dio ?? Dio();

  Future<Uint8List?> downloadFile(String url, {String? filename}) async {
    try {
      // Get the file data from the URL
      final response = await _dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      // If a filename is provided and we are not on the web, save the file
      if (filename != null && !kIsWeb) {
        await _dio.download(url, filename);
        nkDevLog("File downloaded to: $filename");
      }

      // Return the downloaded data as Uint8List
      return Uint8List.fromList(response.data);
    } catch (e) {
      nkDevLog("Download failed: $e");
      return null;
    }
  }
}
