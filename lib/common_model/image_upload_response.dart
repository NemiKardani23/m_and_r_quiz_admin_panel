class ImageUploadResponse {
    ImageUploadResponse({
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
        required this.timestamp,
    });

    final bool? status;
    final String? message;
    final ImageUploadData? data;
    final List<dynamic> errors;
    final DateTime? timestamp;

    ImageUploadResponse copyWith({
        bool? status,
        String? message,
        ImageUploadData? data,
        List<dynamic>? errors,
        DateTime? timestamp,
    }) {
        return ImageUploadResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
            errors: errors ?? this.errors,
            timestamp: timestamp ?? this.timestamp,
        );
    }

    factory ImageUploadResponse.fromJson(Map<String, dynamic> json){ 
        return ImageUploadResponse(
            status: json["status"],
            message: json["message"],
            data: json["data"] == null ? null : ImageUploadData.fromJson(json["data"]),
            errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
            timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "errors": errors.map((x) => x).toList(),
        "timestamp": timestamp?.toIso8601String(),
    };

    @override
    String toString(){
        return "$status, $message, $data, $errors, $timestamp, ";
    }

}

class ImageUploadData {
    ImageUploadData({
        required this.fileName,
        required this.fileUrl,
        required this.fileType,
        required this.context,
    });

    final String? fileName;
    final String? fileUrl;
    final String? fileType;
    final String? context;

    ImageUploadData copyWith({
        String? fileName,
        String? fileUrl,
        String? fileType,
        String? context,
    }) {
        return ImageUploadData(
            fileName: fileName ?? this.fileName,
            fileUrl: fileUrl ?? this.fileUrl,
            fileType: fileType ?? this.fileType,
            context: context ?? this.context,
        );
    }

    factory ImageUploadData.fromJson(Map<String, dynamic> json){ 
        return ImageUploadData(
            fileName: json["file_name"],
            fileUrl: json["file_url"],
            fileType: json["file_type"],
            context: json["context"],
        );
    }

    Map<String, dynamic> toJson() => {
        "file_name": fileName,
        "file_url": fileUrl,
        "file_type": fileType,
        "context": context,
    };

    @override
    String toString(){
        return "$fileName, $fileUrl, $fileType, $context, ";
    }

}

/*
{
	"status": true,
	"message": "File uploaded successfully.",
	"data": {
		"file_name": "Favicon png.png",
		"file_url": "https://studyverse.bringforth.in/uploads/image/1/file/6717715578291_Faviconpng.png",
		"file_type": "image",
		"context": "testing"
	},
	"errors": [],
	"timestamp": "2024-10-22 15:03:09"
}*/