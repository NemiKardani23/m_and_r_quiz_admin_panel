class GlobalCrudResponse {
    GlobalCrudResponse({
        required this.status,
        required this.message,
        required this.errors,
        required this.timestamp,
    });

    final bool status;
    final String message;
    final List<dynamic> errors;
    final DateTime? timestamp;

    GlobalCrudResponse copyWith({
        bool? status,
        String? message,
        List<dynamic>? errors,
        DateTime? timestamp,
    }) {
        return GlobalCrudResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            errors: errors ?? this.errors,
            timestamp: timestamp ?? this.timestamp,
        );
    }

    factory GlobalCrudResponse.fromJson(Map<String, dynamic> json){ 
        return GlobalCrudResponse(
            status: json["status"] ?? false,
            message: json["message"] ?? "",
            errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
            timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors.map((x) => x).toList(),
        "timestamp": timestamp?.toIso8601String(),
    };

}
