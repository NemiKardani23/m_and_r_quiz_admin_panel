class RefreshTokenResponse {
    RefreshTokenResponse({
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
        required this.timestamp,
    });

    final bool status;
    final String message;
    final RefreshTokenData? data;
    final List<dynamic> errors;
    final DateTime? timestamp;

    factory RefreshTokenResponse.fromJson(Map<String, dynamic> json){ 
        return RefreshTokenResponse(
            status: json["status"] ?? false,
            message: json["message"] ?? "",
            data: json["data"] == null ? null : RefreshTokenData.fromJson(json["data"]),
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

}

class RefreshTokenData {
    RefreshTokenData({
        required this.accessToken,
        required this.refreshToken,
    });

    final String accessToken;
    final String refreshToken;

    factory RefreshTokenData.fromJson(Map<String, dynamic> json){ 
        return RefreshTokenData(
            accessToken: json["access_token"] ?? "",
            refreshToken: json["refresh_token"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
    };

}
