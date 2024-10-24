import 'dart:convert';
import 'dart:io';
import 'package:googleapis/vision/v1.dart' as vision;
import 'package:googleapis_auth/auth_io.dart';

class PlantDiseaseService {
  late vision.VisionApi _visionApi;

  Future<void> init() async {
    final credentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "poetic-brace-439409-j3",
      "private_key_id": "f394b918c0bd00642d8c2c1198b9a3440aa8c8b3",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCbfQakCaospbXu\nJB3BxizW+9lFQ1R8QW8otBUAcpDOI09j18lmzttU51ZiLZ19eQC447+Sc14AvjbP\nOBf1JdbzSkBKny5SGytqq3ZHlNw4MbkgOh0oszA68d762bu2xpPC+LxH0OHdwV7z\nFG98HgoO5i81LmumahrlW6YXuZ1QgmU3tNG+dJu4GuFFF61Xqiv1kadxXzw4+IG6\nTxGw2ZeB/bVhZQK1fvhuctpZ27DDu1d1j/fUEI2NoKoyO1xCGzaeCSXIROxmh/Kc\naXSLgl71KlXGpbhSfiD2bBhBS6hbbeQybF5Wa4S/l9DnCWflVzHL5mU3lj0n1tnE\nguFZ/xINAgMBAAECggEAEjiUjqSTTKgeqcmRsyOGHatlyrgZLnZ8kEiKLYM/dOiu\nZQTklSeojEqP1PGDgzCq5P/Lc14RpgSkZ6QrKo9EoT4SSqxcwUJt1BJDyh+nru4k\nw6ILyLk27bFqb/sUBFdA+ZgseD4COfpvJg0/A0yB4T0YSyMlelr0y+vxitY1mTl/\n36vDdYtdKyIGuwHxi98gIGgdg5lA2co1SuRfIuZLeQUDddLcSHWF6sXuJ1B6Ciwc\n92erksTibfu5X0v5+2IFQVYnJ3Pzbv/KBZTxiQ56RUo2ot/lK815X3+UFGxLn6mo\nQFKHy/xsjtC6Z2DSGih1OjLFS9NbCXEqH2yGFE7AAQKBgQDJlbkub6HbVcn6CKEh\nLxh97L414ZwkvT2xhotxfYB55HGtogTRU8nwD/jou4rFqJi3izFQSKZBsLTM0Qou\n2epQ05j6JAV7UNK8tCmybHmZbJ2Z4+ozhAt45e4rSIKnyuPzJh6lAoxYyqu1HlI9\nLzdnLwolP11HaOPFOZZiOiuEpQKBgQDFddyZqg/+kUa1M6P+5eFHpmr6xWc1yCk+\nbqRbsQii+LsUuDtSmrav02ot+hhXBIe4VOHBVHd01YQnJUfNKWQTi6hruK16liI+\nQvNBHwipJCIz+5TZv/WvGUKbPQoRO5AT6lgetd1JcuEicnmEepJ6hjGZncz/c+BL\ndNXpw2YTSQKBgQCOMHj9gypk/t9H6VxWftTExf/pG6k61O02UlP7im3cDMIOmpDR\nYku3dFy7NMYO4/xMwvbWzVfQUCdHrU+EeptnxclK76uaLwlmp6Idw5wGF3IXQYdK\nLSK2dWEI0M2wM1GUidflxqVeYB6705Zop+xpcOm0GjzeiOLYk+U6hhN6LQKBgQCs\n0UCnRI4HEQK/aFjpqCwI13/dxpNUIMDoIVG75i9W4zZpJezVmQ62x+OwJajTz+Uw\n0SlcWR7LpGurDxfOWaF68coPrWw3U9rYfyQDJLQhxLwintdh1H2kKAmBcGS1PFoW\n9Az3o9fuhpq/2Uy9Q8GbdoNGnTNjh/kQUUs+8oMN8QKBgCDk+mBtT1D2+gV0upUy\nZNg0s0B2JDfUgiy19e4wAUVmUrHAJ0Fg4s35MGApPA94SUqEZSjXmVrtZ/0pUQN7\noUP91U0dIOsArZP/CxmwaUVanQc10HTg5REN3M7F0u7xOOUd7Puv0Dx5ula4qBEP\nBQZeq49UjOeQry0QeKcqlSci\n-----END PRIVATE KEY-----\n",
      "client_email":
          "smartfarm@poetic-brace-439409-j3.iam.gserviceaccount.com",
      "client_id": "101810452065868153492",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/smartfarm%40poetic-brace-439409-j3.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"

      // "type": "service_account",
      // "project_id": "YOUR_PROJECT_ID",
      // "private_key_id": "YOUR_PRIVATE_KEY_ID",
      // "private_key": "YOUR_PRIVATE_KEY",
      // "client_email": "YOUR_CLIENT_EMAIL",
      // "client_id": "YOUR_CLIENT_ID",
    });

    final client = await clientViaServiceAccount(
      credentials,
      [vision.VisionApi.cloudVisionScope],
    );

    _visionApi = vision.VisionApi(client);
  }

  Future<String> encodeImage(File image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  Future<Map<String, dynamic>> analyzePlantDisease({
    required File image,
  }) async {
    try {
      final bytes = await image.readAsBytes();
      final request = vision.AnnotateImageRequest();

      request.image = vision.Image()..contentAsBytes = bytes;

      request.features = [
        vision.Feature()
          ..type = 'OBJECT_LOCALIZATION'
          ..maxResults = 10,
        vision.Feature()
          ..type = 'LABEL_DETECTION'
          ..maxResults = 10,
        vision.Feature()..type = 'IMAGE_PROPERTIES',
        vision.Feature()..type = 'CROP_HINTS',
      ];

      final batchRequest = vision.BatchAnnotateImagesRequest()
        ..requests = [request];

      final response = await _visionApi.images.annotate(batchRequest);

      if (response.responses == null || response.responses!.isEmpty) {
        return {
          'success': false,
          'message': "Unable to analyze image",
          'conditions': [],
        };
      }

      final firstResponse = response.responses!.first;

      // Check if the image contains plants
      final labels = firstResponse.labelAnnotations ?? [];
      bool isPlantRelated = labels.any((label) =>
          (label.description ?? '').toLowerCase().contains('plant') ||
          (label.description ?? '').toLowerCase().contains('leaf') ||
          (label.description ?? '').toLowerCase().contains('flower') ||
          (label.description ?? '').toLowerCase().contains('tree'));

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
        final description = (label.description ?? '').toLowerCase();
        final score = label.score ?? 0.0;

        if (description.contains('disease') ||
            description.contains('pest') ||
            description.contains('damage') ||
            description.contains('blight') ||
            description.contains('rot') ||
            description.contains('mold') ||
            description.contains('wilting') ||
            description.contains('spots')) {
          conditions.add({
            'condition': label.description,
            'confidence': '${(score * 100).toStringAsFixed(1)}%',
            'type': _determineConditionType(description),
          });
        }
      }

      // Analyze color properties for potential chlorosis
      final dominantColors =
          firstResponse.imagePropertiesAnnotation?.dominantColors?.colors ?? [];
      if (dominantColors.isNotEmpty) {
        for (var color in dominantColors) {
          if (_isYellowish(
                  (color.color?.red ?? 0).toInt(),
                  (color.color?.green ?? 0).toInt(),
                  (color.color?.blue ?? 0).toInt()) &&
              (color.score ?? 0) > 0.3) {
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
