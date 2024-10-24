import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String API_KEY = "AIzaSyDZu8o67zJyLeus-kyq53EjCKocc-Wi91s";
  final String BASE_URL = "https://generativelanguage.googleapis.com/v1beta";

  Future<String> encodeImage(File image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  Future<String> sendMessageGemini({required String diseaseName}) async {
    try {
      final response = await _dio.post(
        "$BASE_URL/models/gemini-pro:generateContent?key=$API_KEY",
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: {
          "contents": [
            {
              "parts": [
                {
                  "text":
                      "Upon receiving the name of a plant disease, provide three precautionary measures to prevent or manage the disease. These measures should be concise, clear, and limited to one sentence each. No additional information or context is needed—only the three precautions in bullet-point format. The disease is $diseaseName"
                }
              ]
            }
          ],
          "generationConfig": {
            "temperature": 0.7,
            "maxOutputTokens": 100,
          },
        },
      );

      final jsonResponse = response.data;

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }

      return jsonResponse["candidates"][0]["content"]["parts"][0]["text"];
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<String> sendImageToGeminiVision({
    required File image,
    int maxTokens = 50,
  }) async {
    final String base64Image = await encodeImage(image);

    try {
      final response = await _dio.post(
        "$BASE_URL/models/gemini-pro-vision:generateContent?key=$API_KEY",
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: {
          "contents": [
            {
              "parts": [
                {
                  "text":
                      "Your task is to identify plant health issues with precision. Analyze any image of a plant or leaf I provide, and detect all abnormal conditions, whether they are diseases, pests, deficiencies, or decay. Respond strictly with the name of the condition identified, and nothing else—no explanations, no additional text. If a condition is unrecognizable, reply with 'I don't know'. If the image is not plant-related, say 'Please pick another image'"
                },
                {
                  "inline_data": {
                    "mime_type": "image/jpeg",
                    "data": base64Image
                  }
                }
              ]
            }
          ],
          "generationConfig": {
            "temperature": 0.4,
            "maxOutputTokens": maxTokens,
          },
        },
      );

      final jsonResponse = response.data;

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }

      return jsonResponse["candidates"][0]["content"]["parts"][0]["text"];
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
