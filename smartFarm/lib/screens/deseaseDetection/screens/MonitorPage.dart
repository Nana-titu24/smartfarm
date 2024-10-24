import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartfarm/screens/deseaseDetection/constants/constants.dart';
import 'package:smartfarm/screens/deseaseDetection/services/api_service.dart';

class MonitorPage extends StatefulWidget {
  const MonitorPage({super.key});

  @override
  State<MonitorPage> createState() => _MyMonitorPageState();
}

class _MyMonitorPageState extends State<MonitorPage> {
  // Initialize service with API key
  final plantService = PlantDiseaseService(
      apiKey:
          'AIzaSyBKOG1234567890qwertyuiop'); // Replace with your actual API key
  File? _selectedImage;
  List<Map<String, dynamic>> detectedConditions = [];
  String statusMessage = '';
  bool detecting = false;

  // Removed initState and _initializeService since they're no longer needed

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        detectedConditions = [];
        statusMessage = '';
      });
    }
  }

  Future<void> detectDisease() async {
    if (_selectedImage == null) return;

    setState(() {
      detecting = true;
    });

    try {
      final result = await plantService.analyzePlantDisease(
        image: _selectedImage!,
      );

      setState(() {
        if (result['success']) {
          detectedConditions =
              List<Map<String, dynamic>>.from(result['conditions']);
          statusMessage = result['message'];
        } else {
          statusMessage = result['message'];
          detectedConditions = [];
        }
      });
    } catch (error) {
      _showErrorSnackBar(error);
    } finally {
      setState(() {
        detecting = false;
      });
    }
  }

  void _showDetailsDialog(List<Map<String, dynamic>> conditions) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: 'Detection Results',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var condition in conditions) ...[
              Text(
                '${condition['condition']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text('Type: ${condition['type']}'),
              Text('Confidence: ${condition['confidence']}'),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
      btnOkText: 'Got it',
      btnOkColor: themeColor,
      btnOkOnPress: () {},
    ).show();
  }

  void _showErrorSnackBar(Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.23,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                  ),
                  color: themeColor,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('OPEN GALLERY',
                              style: TextStyle(color: textColor)),
                          const SizedBox(width: 10),
                          Icon(Icons.image, color: textColor)
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.camera),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('START CAMERA',
                              style: TextStyle(color: textColor)),
                          const SizedBox(width: 10),
                          Icon(Icons.camera_alt, color: textColor)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _selectedImage == null
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.asset('assets/images/pick1.png'),
                )
              : Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
          if (_selectedImage != null)
            detecting
                ? SpinKitWave(
                    color: themeColor,
                    size: 30,
                  )
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: detectDisease,
                      child: const Text(
                        'DETECT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          if (statusMessage.isNotEmpty)
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: false,
                          repeatForever: false,
                          displayFullTextOnTap: true,
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TyperAnimatedText(statusMessage.trim()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (detectedConditions.isNotEmpty)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () => _showDetailsDialog(detectedConditions),
                    child: Text(
                      'VIEW DETAILS',
                      style: TextStyle(color: textColor),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
