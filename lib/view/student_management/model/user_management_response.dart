class UserManagementResponse {
    UserManagementResponse({
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
        required this.timestamp,
    });

    final bool? status;
    final String? message;
    final List<UserManagementData> data;
    final List<dynamic> errors;
    final DateTime? timestamp;

    UserManagementResponse copyWith({
        bool? status,
        String? message,
        List<UserManagementData>? data,
        List<dynamic>? errors,
        DateTime? timestamp,
    }) {
        return UserManagementResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
            errors: errors ?? this.errors,
            timestamp: timestamp ?? this.timestamp,
        );
    }

    factory UserManagementResponse.fromJson(Map<String, dynamic> json){ 
        return UserManagementResponse(
            status: json["status"],
            message: json["message"],
            data: json["data"] == null ? [] : List<UserManagementData>.from(json["data"]!.map((x) => UserManagementData.fromJson(x))),
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

class UserManagementData {
    UserManagementData({
        required this.id,
        required this.email,
        required this.password,
        required this.name,
        required this.phoneNumber,
        required this.profileImageUrl,
        required this.city,
        required this.gender,
        required this.isAdmin,
        required this.createdAt,
        required this.updatedAt,
        required this.emailVerified,
        required this.dob,
        required this.otp,
        required this.otpExpiry,
        required this.resetToken,
        required this.resetTokenExpiry,
        required this.loginStatus,
        required this.activeStatus,
        required this.categoryTypeId,
        required this.categoryId,
        required this.country,
        required this.state,
    });

    final int? id;
    final String? email;
    final String? password;
    final String? name;
    final String? phoneNumber;
    final String? profileImageUrl;
    final String? city;
    final String? gender;
    final num? isAdmin;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? emailVerified;
    final String? dob;
    final dynamic otp;
    final dynamic otpExpiry;
    final dynamic resetToken;
    final dynamic resetTokenExpiry;
    final String? loginStatus;
    final String? activeStatus;
    final int? categoryTypeId;
    final int? categoryId;
    final String? country;
    final String? state;

    UserManagementData copyWith({
        int? id,
        String? email,
        String? password,
        String? name,
        String? phoneNumber,
        String? profileImageUrl,
        String? city,
        String? gender,
        num? isAdmin,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? emailVerified,
        String? dob,
        dynamic otp,
        dynamic otpExpiry,
        dynamic resetToken,
        dynamic resetTokenExpiry,
        String? loginStatus,
        String? activeStatus,
        int? categoryTypeId,
        int? categoryId,
        String? country,
        String? state,
    }) {
        return UserManagementData(
            id: id ?? this.id,
            email: email ?? this.email,
            password: password ?? this.password,
            name: name ?? this.name,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            profileImageUrl: profileImageUrl ?? this.profileImageUrl,
            city: city ?? this.city,
            gender: gender ?? this.gender,
            isAdmin: isAdmin ?? this.isAdmin,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            emailVerified: emailVerified ?? this.emailVerified,
            dob: dob ?? this.dob,
            otp: otp ?? this.otp,
            otpExpiry: otpExpiry ?? this.otpExpiry,
            resetToken: resetToken ?? this.resetToken,
            resetTokenExpiry: resetTokenExpiry ?? this.resetTokenExpiry,
            loginStatus: loginStatus ?? this.loginStatus,
            activeStatus: activeStatus ?? this.activeStatus,
            categoryTypeId: categoryTypeId ?? this.categoryTypeId,
            categoryId: categoryId ?? this.categoryId,
            country: country ?? this.country,
            state: state ?? this.state,
        );
    }

    factory UserManagementData.fromJson(Map<String, dynamic> json){ 
        return UserManagementData(
            id: json["id"],
            email: json["email"],
            password: json["password"],
            name: json["name"],
            phoneNumber: json["phone_number"],
            profileImageUrl: json["profile_image_url"],
            city: json["city"],
            gender: json["gender"],
            isAdmin: json["is_admin"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            emailVerified: json["email_verified"],
            dob: json["dob"],
            otp: json["otp"],
            otpExpiry: json["otp_expiry"],
            resetToken: json["reset_token"],
            resetTokenExpiry: json["reset_token_expiry"],
            loginStatus: json["login_status"],
            activeStatus: json["active_status"],
            categoryTypeId: json["category_type_id"],
            categoryId: json["category_id"],
            country: json["country"],
            state: json["state"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "phone_number": phoneNumber,
        "profile_image_url": profileImageUrl,
        "city": city,
        "gender": gender,
        "is_admin": isAdmin,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "email_verified": emailVerified,
        "dob": dob,
        "otp": otp,
        "otp_expiry": otpExpiry,
        "reset_token": resetToken,
        "reset_token_expiry": resetTokenExpiry,
        "login_status": loginStatus,
        "active_status": activeStatus,
        "category_type_id": categoryTypeId,
        "category_id": categoryId,
        "country": country,
        "state": state,
    };

    @override
    String toString(){
        return "$id, $email, $password, $name, $phoneNumber, $profileImageUrl, $city, $gender, $isAdmin, $createdAt, $updatedAt, $emailVerified, $dob, $otp, $otpExpiry, $resetToken, $resetTokenExpiry, $loginStatus, $activeStatus, $categoryTypeId, $categoryId, $country, $state, ";
    }

}

/*
{
	"status": true,
	"message": "Users fetched successfully.",
	"data": [
		{
			"id": 11,
			"email": "nemikardani23@gmail.com",
			"password": "$2y$10$KMF1XX9Rd2ed/X2TvsgqeeDNPIoMr2JIqIrMnz.EHqADifQNV6XXi",
			"name": "Nemi Kardani",
			"phone_number": "7897879879",
			"profile_image_url": "https://studyverse.bringforth.in/uploads/image/11/profile_image/671d051b04497_scaled_01d2079d-fe75-4425-8396-73166eda39b83765685834804299208.jpg",
			"city": "Ahmedabad",
			"gender": "male",
			"is_admin": 0,
			"created_at": "2024-10-26 15:04:59",
			"updated_at": "2024-11-18 12:21:47",
			"email_verified": "true",
			"dob": "0000-00-00",
			"otp": null,
			"otp_expiry": null,
			"reset_token": null,
			"reset_token_expiry": null,
			"login_status": "online",
			"active_status": "active",
			"category_type_id": 4,
			"category_id": 20,
			"country": "India",
			"state": "Gujarat"
		},
		{
			"id": 13,
			"email": "mandreducation2027@gmail.com",
			"password": "$2y$10$0689fB.HKDkmeRM4sVfzAeNEmnGNgHzaXRonAztCWXybTVJuiVJ6e",
			"name": "MandREducation",
			"phone_number": "7897877779",
			"profile_image_url": null,
			"city": "Gandhinagar",
			"gender": "male",
			"is_admin": 0,
			"created_at": "2024-11-18 08:02:06",
			"updated_at": "2024-11-18 12:21:49",
			"email_verified": "true",
			"dob": "0000-00-00",
			"otp": null,
			"otp_expiry": null,
			"reset_token": null,
			"reset_token_expiry": null,
			"login_status": "online",
			"active_status": "active",
			"category_type_id": 4,
			"category_id": 20,
			"country": "India",
			"state": "Gujarat"
		}
	],
	"errors": [],
	"timestamp": "2024-11-18 17:52:03"
}*/