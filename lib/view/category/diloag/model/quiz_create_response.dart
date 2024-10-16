class QuizCreateResponse {
  QuizCreateResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
    required this.timestamp,
  });

  final bool? status;
  final String? message;
  final List<QuizCreateData> data;
  final List<dynamic> errors;
  final DateTime? timestamp;

  QuizCreateResponse copyWith({
    bool? status,
    String? message,
    List<QuizCreateData>? data,
    List<dynamic>? errors,
    DateTime? timestamp,
  }) {
    return QuizCreateResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
      errors: errors ?? this.errors,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory QuizCreateResponse.fromJson(Map<String, dynamic> json) {
    return QuizCreateResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<QuizCreateData>.from(
              json["data"]!.map((x) => QuizCreateData.fromJson(x))),
      errors: json["errors"] == null
          ? []
          : List<dynamic>.from(json["errors"]!.map((x) => x)),
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
        "errors": errors.map((x) => x).toList(),
        "timestamp": timestamp?.toIso8601String(),
      };

  @override
  String toString() {
    return "$status, $message, $data, $errors, $timestamp, ";
  }
}

class QuizCreateData {
  QuizCreateData({
    required this.testId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.totalQuestions,
    required this.totalDuration,
    required this.totalMarks,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.fileTypeId,
  });

  final int? testId;
  final int? categoryId;
  final String? title;
  final String? description;
  final String? thumbnail;
  final num? totalQuestions;
  final num? totalDuration;
  final String? totalMarks;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? createdBy;
  final int? fileTypeId;

  QuizCreateData copyWith({
    int? testId,
    int? categoryId,
    String? title,
    String? description,
    String? thumbnail,
    num? totalQuestions,
    num? totalDuration,
    String? totalMarks,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    num? createdBy,
    int? fileTypeId,
  }) {
    return QuizCreateData(
      testId: testId ?? this.testId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      totalDuration: totalDuration ?? this.totalDuration,
      totalMarks: totalMarks ?? this.totalMarks,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      fileTypeId: fileTypeId ?? this.fileTypeId,
    );
  }

  factory QuizCreateData.fromJson(Map<String, dynamic> json) {
    return QuizCreateData(
      testId: json["test_id"],
      categoryId: int.tryParse(json["category_id"].toString()),
      title: json["title"],
      description: json["description"],
      thumbnail: json["thumbnail"],
      totalQuestions: json["total_questions"],
      totalDuration: json["total_duration"],
      totalMarks: json["total_marks"].toString(),
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdBy: json["created_by"],
      fileTypeId: int.tryParse(json["file_type_id"].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        "test_id": testId,
        "category_id": categoryId,
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
        "total_questions": totalQuestions,
        "total_duration": totalDuration,
        "total_marks": totalMarks,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_by": createdBy,
        "file_type_id": fileTypeId,
      };

  @override
  String toString() {
    return "$testId, $categoryId, $title, $description, $thumbnail, $totalQuestions, $totalDuration, $totalMarks, $status, $createdAt, $updatedAt, $createdBy, $fileTypeId, ";
  }
}
