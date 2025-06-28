import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

extension XFileExtension on XFile {
  /// Convert XFile Image to Base64 String file
  String? get customToBase64 {
    File file = File(path);
    try {
      
      return base64Encode(file.readAsBytesSync());
    } catch (e) {

    }
    return null;
  }
}

 fileFormatPath(XFile? file) {
  if (file != null) {
    String extension = file.path.split('.').last.toLowerCase(); 
    switch (extension) {
      case "pdf":
        return "data:application/pdf;base64,";
      case "jpg":
      case "jpeg":
        return "data:image/jpeg;base64,";
      case "png":
        return "data:image/png;base64,";
      default:
        return "unknown";
    }
  }
  return "unknown";
}



// Future<String?> imageXFileToBase64(String? imagePath) async {
//   if (imagePath == null) return null;
//   File file = File(imagePath);
//   try {
//     return base64Encode(file.readAsBytesSync());
//   } catch (e) {
//     devPrint("ImageConversion: $e");
//   }
//   return null;
// }

Uint8List? imageStringToByte(String? imageString) {
  if (imageString == null || imageString.isEmpty) return null;
  try {
    final regex = RegExp(r"^data:[^;]+;base64,");
    imageString = imageString.replaceFirst(regex, "");

    return base64Decode(imageString);
  } catch (e) {
  }
  return null;
}



