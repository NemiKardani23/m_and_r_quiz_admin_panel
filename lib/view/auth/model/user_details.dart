class UserDetails {
    UserDetails({
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
        required this.timestamp,
    });

    final bool status;
    final String message;
    final UserData? data;
    final List<dynamic> errors;
    final DateTime? timestamp;

    UserDetails copyWith({
        bool? status,
        String? message,
        UserData? data,
        List<dynamic>? errors,
        DateTime? timestamp,
    }) {
        return UserDetails(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
            errors: errors ?? this.errors,
            timestamp: timestamp ?? this.timestamp,
        );
    }

    factory UserDetails.fromJson(Map<String, dynamic> json){ 
        return UserDetails(
            status: json["status"] ?? false,
            message: json["message"] ?? "",
            data: json["data"] == null ? null : UserData.fromJson(json["data"]),
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

class UserData {
    UserData({
        required this.userId,
        required this.name,
        required this.email,
        required this.phoneNumber,
        required this.dob,
        required this.city,
        required this.gender,
        required this.profileImageUrl,
        required this.isAdmin,
        required this.emailVerified,
        required this.createdAt,
        required this.updatedAt,
        required this.accessToken,
        required this.refreshToken,
        required this.sessionId,
        required this.deviceId,
        required this.refreshTokenExpiry,
    });

    final int userId;
    final String name;
    final String email;
    final String phoneNumber;
    final String dob;
    final String city;
    final String gender;
    final String profileImageUrl;
    final bool isAdmin;
    final bool emailVerified;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String accessToken;
    final String refreshToken;
    final String sessionId;
    final String deviceId;
    final DateTime? refreshTokenExpiry;

    UserData copyWith({
        int? userId,
        String? name,
        String? email,
        String? phoneNumber,
        String? dob,
        String? city,
        String? gender,
        String? profileImageUrl,
        bool? isAdmin,
        bool? emailVerified,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? accessToken,
        String? refreshToken,
        String? sessionId,
        String? deviceId,
        DateTime? refreshTokenExpiry,
    }) {
        return UserData(
            userId: userId ?? this.userId,
            name: name ?? this.name,
            email: email ?? this.email,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            dob: dob ?? this.dob,
            city: city ?? this.city,
            gender: gender ?? this.gender,
            profileImageUrl: profileImageUrl ?? this.profileImageUrl,
            isAdmin: isAdmin ?? this.isAdmin,
            emailVerified: emailVerified ?? this.emailVerified,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            accessToken: accessToken ?? this.accessToken,
            refreshToken: refreshToken ?? this.refreshToken,
            sessionId: sessionId ?? this.sessionId,
            deviceId: deviceId ?? this.deviceId,
            refreshTokenExpiry: refreshTokenExpiry ?? this.refreshTokenExpiry,
        );
    }

    factory UserData.fromJson(Map<String, dynamic> json){ 
        return UserData(
            userId: json["user_id"] ?? 0,
            name: json["name"] ?? "",
            email: json["email"] ?? "",
            phoneNumber: json["phone_number"] ?? "",
            dob: json["dob"] ?? "",
            city: json["city"] ?? "",
            gender: json["gender"] ?? "",
            profileImageUrl: json["profile_image_url"] ?? "",
            isAdmin: json["is_admin"] ?? false,
            emailVerified: json["email_verified"] ?? false,
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            accessToken: json["access_token"] ?? "",
            refreshToken: json["refresh_token"] ?? "",
            sessionId: json["session_id"] ?? "",
            deviceId: json["device_id"] ?? "",
            refreshTokenExpiry: DateTime.tryParse(json["refresh_token_expiry"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "dob": dob,
        "city": city,
        "gender": gender,
        "profile_image_url": profileImageUrl,
        "is_admin": isAdmin,
        "email_verified": emailVerified,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "session_id": sessionId,
        "device_id": deviceId,
        "refresh_token_expiry": refreshTokenExpiry?.toIso8601String(),
    };

}
