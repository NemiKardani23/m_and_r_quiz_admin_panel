class FileTypeResponse {
    FileTypeResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    final bool? status;
    final String? message;
    final List<FileTypeData> data;

    FileTypeResponse copyWith({
        bool? status,
        String? message,
        List<FileTypeData>? data,
    }) {
        return FileTypeResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
        );
    }

    factory FileTypeResponse.fromJson(Map<String, dynamic> json){ 
        return FileTypeResponse(
            status: json["status"],
            message: json["message"],
            data: json["data"] == null ? [] : List<FileTypeData>.from(json["data"]!.map((x) => FileTypeData.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
    };

    @override
    String toString(){
        return "$status, $message, $data, ";
    }
}

class FileTypeData {
    FileTypeData({
        required this.id,
        required this.typeName,
        required this.description,
        required this.status,
        required this.createdAt,
    });

    final int? id;
    final String? typeName;
    final String? description;
    final String? status;
    final DateTime? createdAt;

    FileTypeData copyWith({
        int? id,
        String? typeName,
        String? description,
        String? status,
        DateTime? createdAt,
    }) {
        return FileTypeData(
            id: id ?? this.id,
            typeName: typeName ?? this.typeName,
            description: description ?? this.description,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
        );
    }

    factory FileTypeData.fromJson(Map<String, dynamic> json){ 
        return FileTypeData(
            id: json["id"],
            typeName: json["type_name"],
            description: json["description"],
            status: json["status"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "type_name": typeName,
        "description": description,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
    };

    @override
    String toString(){
        return "$id, $typeName, $description, $status, $createdAt, ";
    }
}
