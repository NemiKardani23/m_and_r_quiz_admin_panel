class CategoryTypeResponse {
    CategoryTypeResponse({
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
        required this.timestamp,
    });

    final bool status;
    final String message;
    final List<CategoryTypeData> data;
    final List<dynamic> errors;
    final DateTime? timestamp;

    CategoryTypeResponse copyWith({
        bool? status,
        String? message,
        List<CategoryTypeData>? data,
        List<dynamic>? errors,
        DateTime? timestamp,
    }) {
        return CategoryTypeResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
            errors: errors ?? this.errors,
            timestamp: timestamp ?? this.timestamp,
        );
    }

    factory CategoryTypeResponse.fromJson(Map<String, dynamic> json){ 
        return CategoryTypeResponse(
            status: json["status"] ?? false,
            message: json["message"] ?? "",
            data: json["data"] == null ? [] : List<CategoryTypeData>.from(json["data"]!.map((x) => CategoryTypeData.fromJson(x))),
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

}

class CategoryTypeData {
    CategoryTypeData({
        required this.id,
        required this.name,
        required this.description,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    final int id;
    final String name;
    final String description;
    final String status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    CategoryTypeData copyWith({
        int? id,
        String? name,
        String? description,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return CategoryTypeData(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
    }

    factory CategoryTypeData.fromJson(Map<String, dynamic> json){ 
        return CategoryTypeData(
            id: json["id"] ?? 0,
            name: json["name"] ?? "",
            description: json["description"] ?? "",
            status: json["status"] ?? "",
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

}
