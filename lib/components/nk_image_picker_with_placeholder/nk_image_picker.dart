import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class NKImagePicker {
  final FileType? fileType;
  final List<String>? allowedExtensions;

  NKImagePicker({
    this.fileType ,
    this.allowedExtensions,
  });

  Future<FilePickerResult?> pickFile(BuildContext context) async {
    return await FilePicker.platform.pickFiles(
      type: fileType??FileType.any,
      allowedExtensions: allowedExtensions,
      allowMultiple: false,

    );
  }

  void handleFileType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'webp':
        // Set allowed extensions for images
        break;
      case 'mp4':
      case 'mov':
      case 'mkv':
      case 'avi':
      case 'webm':
        // Set allowed extensions for videos
        break;
      case 'pdf':
      case 'doc':
      case 'docx':
      case 'ppt':
      case 'pptx':
      case 'xls':
      case 'xlsx':
      case 'txt':
        // Set allowed extensions for documents
        break;
      default:
        // Handle unsupported file types
        break;
    }
  }
}
