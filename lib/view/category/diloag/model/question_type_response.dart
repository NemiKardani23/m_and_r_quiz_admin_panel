class QuestionTypeResponse {
    QuestionTypeResponse({
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
        required this.timestamp,
    });

    final bool? status;
    final String? message;
    final List<QuestionTypeData> data;
    final List<dynamic> errors;
    final DateTime? timestamp;

    QuestionTypeResponse copyWith({
        bool? status,
        String? message,
        List<QuestionTypeData>? data,
        List<dynamic>? errors,
        DateTime? timestamp,
    }) {
        return QuestionTypeResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
            errors: errors ?? this.errors,
            timestamp: timestamp ?? this.timestamp,
        );
    }

    factory QuestionTypeResponse.fromJson(Map<String, dynamic> json){ 
        return QuestionTypeResponse(
            status: json["status"],
            message: json["message"],
            data: json["data"] == null ? [] : List<QuestionTypeData>.from(json["data"]!.map((x) => QuestionTypeData.fromJson(x))),
            errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
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
    String toString(){
        return "$status, $message, $data, $errors, $timestamp, ";
    }
}

class QuestionTypeData {
    QuestionTypeData({
        required this.questionTypeId,
        required this.name,
        required this.description,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? questionTypeId;
    final String? name;
    final String? description;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    QuestionTypeData copyWith({
        int? questionTypeId,
        String? name,
        String? description,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return QuestionTypeData(
            questionTypeId: questionTypeId ?? this.questionTypeId,
            name: name ?? this.name,
            description: description ?? this.description,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
    }

    factory QuestionTypeData.fromJson(Map<String, dynamic> json){ 
        return QuestionTypeData(
            questionTypeId: json["question_type_id"],
            name: json["name"],
            description: json["description"],
            status: json["status"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "question_type_id": questionTypeId,
        "name": name,
        "description": description,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

    @override
    String toString(){
        return "$questionTypeId, $name, $description, $status, $createdAt, $updatedAt, ";
    }
}
