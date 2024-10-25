import 'dart:io';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest'; // Replace with actual base URL

  Future<String> sendImageToGeminiVision({required File image}) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path, filename: fileName),
      });

      final response = await _dio.post(
        '$baseUrl/detect-disease',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer AIzaSyDZu8o67zJyLeus-kyq53EjCKocc-Wi91s',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['disease'] ?? 'Unknown disease';
      } else {
        throw GeminiVisionException(
          message: 'Failed to detect disease. Status: ${response.statusCode}',
          response: response,
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw GeminiVisionException(
          message:
              'Network error: ${e.message}. Please check your connection and try again.',
          response: e.response,
        );
      }
      throw GeminiVisionException(
        message: 'Error detecting disease: $e',
        response: null,
      );
    }
  }

  Future<String> sendMessageGemini({required String diseaseName}) async {
    try {
      final response = await _dio.post(
        '$baseUrl/get-precautions',
        data: {'disease': diseaseName},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer AIzaSyDZu8o67zJyLeus-kyq53EjCKocc-Wi91s',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['precautions'] ?? 'No precautions available';
      } else {
        throw GeminiVisionException(
          message: 'Failed to get precautions. Status: ${response.statusCode}',
          response: response,
        );
      }
    } catch (e) {
      if (e is DioException) {
        throw GeminiVisionException(
          message:
              'Network error: ${e.message}. Please check your connection and try again.',
          response: e.response,
        );
      }
      throw GeminiVisionException(
        message: 'Error getting precautions: $e',
        response: null,
      );
    }
  }
}

class GeminiVisionException implements Exception {
  final String message;
  final Response? response;

  GeminiVisionException({required this.message, this.response});
}
