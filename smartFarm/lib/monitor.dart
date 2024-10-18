// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// class MonitorPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Capture and Processing',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//       ),
//       home: CaptureImagePage(),
//     );
//   }
// }

// class CaptureImagePage extends StatefulWidget {
//   @override
//   _CaptureImagePageState createState() => _CaptureImagePageState();
// }

// class _CaptureImagePageState extends State<CaptureImagePage> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _capturedImage;
//   bool _isProcessing = false;
//   String _result = '';

//   Future<void> _captureImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//     setState(() {
//       _capturedImage = image;
//     });
//     if (_capturedImage != null) {
//       _sendImageToAPI(File(_capturedImage!.path));
//     }
//   }

//   Future<void> _sendImageToAPI(File imageFile) async {
//     setState(() {
//       _isProcessing = true;
//     });
//     try {
//       final url = Uri.parse('http://your-flask-api/check_color');
// // 8888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

//       final request = http.MultipartRequest('POST', url)
//         ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));
//       final response = await http.Response.fromStream(await request.send());
//       if (response.statusCode == 200) {
//         setState(() {
//           _result = response.body;
//         });
//       } else {
//         setState(() {
//           _result = 'Error: ${response.reasonPhrase}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _result = 'Error: $e';
//       });
//     } finally {
//       setState(() {
//         _isProcessing = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Capture and Processing'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_capturedImage != null)
//               Container(
//                 height: 200,
//                 width: 200,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: FileImage(File(_capturedImage!.path)),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               )
//             else
//               Text(
//                 'No image captured',
//                 style: TextStyle(fontSize: 18),
//               ),
//             SizedBox(height: 20),
//             if (_isProcessing)
//               CircularProgressIndicator() // Display processing indicator
//             else if (_result.isNotEmpty)
//               Text(_result) // Display API response
//             else
//               ElevatedButton(
//                 onPressed: _captureImage,
//                 child: Text('Capture Image'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
