class BannerResponse {
    BannerResponse({
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
        required this.timestamp,
    });

    final bool? status;
    final String? message;
    final List<BannerData> data;
    final List<dynamic> errors;
    final DateTime? timestamp;

    BannerResponse copyWith({
        bool? status,
        String? message,
        List<BannerData>? data,
        List<dynamic>? errors,
        DateTime? timestamp,
    }) {
        return BannerResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
            errors: errors ?? this.errors,
            timestamp: timestamp ?? this.timestamp,
        );
    }

    factory BannerResponse.fromJson(Map<String, dynamic> json){ 
        return BannerResponse(
            status: json["status"],
            message: json["message"],
            data: json["data"] == null ? [] : List<BannerData>.from(json["data"]!.map((x) => BannerData.fromJson(x))),
            errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
            timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
        "errors": errors.map((x) => x).toList(),
        "timestamp": timestamp?.toIso8601String(),
    };

    @override
    String toString(){
        return "$status, $message, $data, $errors, $timestamp, ";
    }

}

class BannerData {
    BannerData({
        required this.id,
        required this.name,
        required this.description,
        required this.imageUrl,
        required this.referenceLink,
        required this.redirectUrl,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? name;
    final String? description;
    final dynamic imageUrl;
    final String? referenceLink;
    final String? redirectUrl;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    BannerData copyWith({
        int? id,
        String? name,
        String? description,
        dynamic imageUrl,
        String? referenceLink,
        String? redirectUrl,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return BannerData(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            imageUrl: imageUrl ?? this.imageUrl,
            referenceLink: referenceLink ?? this.referenceLink,
            redirectUrl: redirectUrl ?? this.redirectUrl,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
    }

    factory BannerData.fromJson(Map<String, dynamic> json){ 
        return BannerData(
            id: json["id"],
            name: json["name"],
            description: json["description"],
            imageUrl: json["image_url"],
            referenceLink: json["reference_link"],
            redirectUrl: json["redirect_url"],
            status: json["status"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "reference_link": referenceLink,
        "redirect_url": redirectUrl,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

    @override
    String toString(){
        return "$id, $name, $description, $imageUrl, $referenceLink, $redirectUrl, $status, $createdAt, $updatedAt, ";
    }

}

/*
{
	"status": true,
	"message": "Banners fetched successfully.",
	"data": [
		{
			"id": 1,
			"name": "banner with image 1",
			"description": "",
			"image_url": null,
			"reference_link": "",
			"redirect_url": "",
			"status": "active",
			"created_at": "2024-10-22 21:19:01",
			"updated_at": "2024-10-22 21:19:01"
		}
	],
	"errors": [],
	"timestamp": "2024-10-23 02:49:08"
}*/