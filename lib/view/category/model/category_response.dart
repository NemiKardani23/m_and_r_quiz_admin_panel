class CategoryResponse {
    CategoryResponse({
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
        required this.timestamp,
    });

    final bool? status;
    final String? message;
    final List<CategoryData> data;
    final List<dynamic> errors;
    final DateTime? timestamp;

    CategoryResponse copyWith({
        bool? status,
        String? message,
        List<CategoryData>? data,
        List<dynamic>? errors,
        DateTime? timestamp,
    }) {
        return CategoryResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
            errors: errors ?? this.errors,
            timestamp: timestamp ?? this.timestamp,
        );
    }

    factory CategoryResponse.fromJson(Map<String, dynamic> json){ 
        return CategoryResponse(
            status: json["status"],
            message: json["message"],
            data: json["data"] == null ? [] : List<CategoryData>.from(json["data"]!.map((x) => CategoryData.fromJson(x))),
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

class CategoryData {
    CategoryData({
        required this.id,
        required this.name,
        required this.description,
        required this.parentId,
        required this.typeId,
        required this.fileTypeId,
        required this.fileUrl,
        required this.image,
        required this.status,
        required this.categoryLevel,
        required this.createdAt,
        required this.updatedAt,
        required this.subcategories,
    });

    final int? id;
    final String? name;
    final String? description;
    final int? parentId;
    final int? typeId;
    final int? fileTypeId;
    final dynamic fileUrl;
    final dynamic image;
    final String? status;
    final num? categoryLevel;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<CategoryData> subcategories;

    CategoryData copyWith({
        int? id,
        String? name,
        String? description,
        int? parentId,
        int? typeId,
        int? fileTypeId,
        dynamic fileUrl,
        dynamic image,
        String? status,
        num? categoryLevel,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<CategoryData>? subcategories,
    }) {
        return CategoryData(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            parentId: parentId ?? this.parentId,
            typeId: typeId ?? this.typeId,
            fileTypeId: fileTypeId ?? this.fileTypeId,
            fileUrl: fileUrl ?? this.fileUrl,
            image: image ?? this.image,
            status: status ?? this.status,
            categoryLevel: categoryLevel ?? this.categoryLevel,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            subcategories: subcategories ?? this.subcategories,
        );
    }

    factory CategoryData.fromJson(Map<String, dynamic> json){ 
        return CategoryData(
            id: json["id"],
            name: json["name"],
            description: json["description"],
            parentId: json["parent_id"],
            typeId: json["type_id"],
            fileTypeId: json["file_type_id"],
            fileUrl: json["file_url"],
            image: json["image"],
            status: json["status"],
            categoryLevel: json["category_level"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            subcategories: json["subcategories"] == null ? [] : List<CategoryData>.from(json["subcategories"]!.map((x) => CategoryData.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "parent_id": parentId,
        "type_id": typeId,
        "file_type_id": fileTypeId,
        "file_url": fileUrl,
        "image": image,
        "status": status,
        "category_level": categoryLevel,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "subcategories": subcategories.map((x) => x.toJson()).toList(),
    };

    @override
    String toString(){
        return "$id, $name, $description, $parentId, $typeId, $fileTypeId, $fileUrl, $image, $status, $categoryLevel, $createdAt, $updatedAt, $subcategories, ";
    }
}
