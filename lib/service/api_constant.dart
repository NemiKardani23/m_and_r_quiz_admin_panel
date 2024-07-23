mixin class ApiConstant {
  final String baseName = "quizadmin";
  final String userDetails = "userDetails";
  final String board = "board";
  final String list = "list";
  final String standard = "standard";
  final String subject = "subject";
  final String chapter = "chapter";

  /// Storage
  final String images = "images";
}

abstract class ApiSecurity {
  final String content_type = "application/json";
  final String accept = "application/json";
  final String authorization = "Authorization";

  final String authToken = "90990";

  Map<String, String> getHeaderWithBearer(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': content_type,
      'Accept': accept,
    };
  }
}
