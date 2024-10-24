import 'dart:convert';
import 'dart:io';
import 'package:googleapis/vision/v1.dart' as vision;
import 'package:http/http.dart' as http;

class PlantDiseaseService {
  final String apiKey;
  final String baseUrl = 'https://vision.googleapis.com/v1/images:annotate';

  PlantDiseaseService({required this.apiKey});

  Future<Map<String, dynamic>> analyzePlantDisease({
    required File image,
  }) async {
    try {
      // Convert image to base64
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Construct the request body
      final body = {
        'requests': [
          {
            'image': {
              'content': base64Image,
            },
            'features': [
              {
                'type': 'OBJECT_LOCALIZATION',
                'maxResults': 10,
              },
              {
                'type': 'LABEL_DETECTION',
                'maxResults': 10,
              },
              {
                'type': 'IMAGE_PROPERTIES',
              },
              {
                'type': 'CROP_HINTS',
              },
            ],
          },
        ],
      };

      // Make the HTTP request
      final response = await http.post(
        Uri.parse('$baseUrl?key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        return {
          'success': false,
          'message': 'API request failed: ${response.statusCode}',
          'conditions': [],
        };
      }

      final jsonResponse = jsonDecode(response.body);
      final responses = jsonResponse['responses'] as List;

      if (responses.isEmpty) {
        return {
          'success': false,
          'message': "Unable to analyze image",
          'conditions': [],
        };
      }

      final firstResponse = responses.first;

      // Check if the image contains plants
      final labels = firstResponse['labelAnnotations'] ?? [];
      bool isPlantRelated = labels.any((label) =>
          (label['description'] ?? '').toLowerCase().contains('plant') ||
          (label['description'] ?? '').toLowerCase().contains('leaf') ||
          (label['description'] ?? '').toLowerCase().contains('flower') ||
          (label['description'] ?? '').toLowerCase().contains('tree'));

      if (!isPlantRelated) {
        return {
          'success': false,
          'message': 'Please provide an image of a plant',
          'conditions': [],
        };
      }

      // Process the annotations to identify potential issues
      final conditions = <Map<String, dynamic>>[];

      // Analyze labels for potential issues
      for (var label in labels) {
        final description = (label['description'] ?? '').toLowerCase();
        final score = label['score'] ?? 0.0;

        if (description.contains('disease') ||
            description.contains('pest') ||
            description.contains('damage') ||
            description.contains('blight') ||
            description.contains('rot') ||
            description.contains('mold') ||
            description.contains('wilting') ||
            description.contains('spots')) {
          conditions.add({
            'condition': label['description'],
            'confidence': '${(score * 100).toStringAsFixed(1)}%',
            'type': _determineConditionType(description),
          });
        }
      }

      // Analyze color properties for potential chlorosis
      final dominantColors = firstResponse['imagePropertiesAnnotation']
              ?['dominantColors']?['colors'] ??
          [];
      if (dominantColors.isNotEmpty) {
        for (var color in dominantColors) {
          final rgb = color['color'] ?? {};
          if (_isYellowish((rgb['red'] ?? 0).toInt(),
                  (rgb['green'] ?? 0).toInt(), (rgb['blue'] ?? 0).toInt()) &&
              (color['score'] ?? 0) > 0.3) {
            conditions.add({
              'condition': 'Possible Chlorosis',
              'confidence': 'Medium',
              'type': 'Nutrient Deficiency',
            });
            break;
          }
        }
      }

      return {
        'success': true,
        'message': conditions.isEmpty
            ? 'No visible plant health issues detected'
            : 'Analysis complete',
        'conditions': conditions,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error analyzing image: $e',
        'conditions': [],
      };
    }
  }

  String _determineConditionType(String description) {
    if (description.contains('pest') || description.contains('insect')) {
      return 'Pest Infestation';
    } else if (description.contains('blight') ||
        description.contains('disease') ||
        description.contains('rot')) {
      return 'Disease';
    } else if (description.contains('damage')) {
      return 'Physical Damage';
    } else {
      return 'General Issue';
    }
  }

  bool _isYellowish(int r, int g, int b) {
    return r > 200 && g > 200 && b < 100;
  }
}
