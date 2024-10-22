import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class NKMultipart {
  static MultipartFile getMultipartImage({required File imageFile}) {
    return MultipartFile.fromFileSync(imageFile.path,
        filename: imageFile.path.split('/').last);
  }

  static MultipartFile? getMultipartImageNullable({File? imageFile}) {
    if (imageFile == null) return null;
    return MultipartFile.fromFileSync(imageFile.path,
        filename: imageFile.path.split('/').last);
  }

  static MultipartFile getMultipartImageBytes({required Uint8List imageBytes,required String name}) {
    return MultipartFile.fromBytes(imageBytes,
        filename: name);
  }

  static MultipartFile? getMultipartImageBytesNullable({Uint8List? imageBytes,required String name}) {
    if (imageBytes == null) return null;
    return MultipartFile.fromBytes(imageBytes,
        filename: name);
  }

  static MultipartFile getMultipartVideo({required File videoFile}) {
    return MultipartFile.fromFileSync(videoFile.path,filename: videoFile.path.split('/').last)  ;
  }

  static MultipartFile? getMultipartVideoNullable({File? videoFile}) {
    if (videoFile == null) return null;
    return MultipartFile.fromFileSync(videoFile.path,filename: videoFile.path.split('/').last)  ;
  }

  static MultipartFile getMultipartVideoBytes({required Uint8List videoBytes,required String name}) {
    return MultipartFile.fromBytes(videoBytes,
        filename: name);
  }

  static MultipartFile? getMultipartVideoBytesNullable({Uint8List? videoBytes,required String name}) {
    if (videoBytes == null) return null;
    return MultipartFile.fromBytes(videoBytes,
        filename: name);
  }

    static MultipartFile getMultipartFile({required File file}) {
    return MultipartFile.fromFileSync(file.path,
        filename: file.path.split('/').last);
  }

  static MultipartFile? getMultipartFileNullable({File? file}) {
    if (file == null) return null;
    return MultipartFile.fromFileSync(file.path,
        filename: file.path.split('/').last);
  }



  static MultipartFile getMultipartFileBytes({required Uint8List fileBytes,required String name}) {
    return MultipartFile.fromBytes(fileBytes,
        filename: name);
  }

  static MultipartFile? getMultipartFileBytesNullable({Uint8List? fileBytes,required String name}) {
    if (fileBytes == null) return null;
    return MultipartFile.fromBytes(fileBytes,
        filename: name);
  }

     static MultipartFile getMultipartStringFile({required String file,String? name}) {
    return MultipartFile.fromString(file,
        filename: name??file.split('/').last);
  }

  static MultipartFile? getMultipartStringFileNullable({String? file,String? name}) {
    if (file == null) return null;
    return MultipartFile.fromString(file,
        filename: name??file.split('/').last);
  }


}
