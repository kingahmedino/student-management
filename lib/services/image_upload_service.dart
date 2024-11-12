import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

class UploadProgress {
  final int bytesUploaded;
  final int totalBytes;
  final double progress;

  UploadProgress({
    required this.bytesUploaded,
    required this.totalBytes,
    required this.progress,
  });
}

class ImageUploadService {
  static const String _apiUrl = 'https://api.imghippo.com/v1/upload';
  static const String _apiKey = '489b437d51a3379a10863d86d6c7a6d6';

  Future<String?> uploadImage(
    File imageFile, {
    void Function(UploadProgress)? onProgress,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(_apiUrl));
      request.fields['api_key'] = _apiKey;

      // Create a stream that can report progress
      final fileStream = imageFile.openRead();
      final fileLength = await imageFile.length();

      // Track upload progress
      int bytesUploaded = 0;
      final streamWithProgress = fileStream.transform(
        StreamTransformer<List<int>, List<int>>.fromHandlers(
          handleData: (data, sink) {
            bytesUploaded += data.length;
            if (onProgress != null) {
              final progress = bytesUploaded / fileLength;
              onProgress(UploadProgress(
                bytesUploaded: bytesUploaded,
                totalBytes: fileLength,
                progress: progress,
              ));
            }
            sink.add(data);
          },
        ),
      );

      final multipartFile = http.MultipartFile(
        'file',
        streamWithProgress,
        fileLength,
        filename: imageFile.path.split('/').last,
      );

      request.files.add(multipartFile);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          return jsonResponse['data']['url'];
        }
      }

      throw Exception('Failed to upload image: ${response.body}');
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
