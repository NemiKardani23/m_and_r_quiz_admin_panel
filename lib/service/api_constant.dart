
// ignore_for_file: constant_identifier_names

import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionhelper.dart';

mixin class ApiConstant implements APIStatusCode {
  final String baseUrl = "https://studyverse.bringforth.in/public/";

  /// Auth

  final String loginAPI = "login.php";
  final String refreshTokenAPI = "refreshToken.php";

  /// Category Type

  final String categoryTypeAPI = "create_category_type.php";
  final String updateCategoryTypeAPI = "update_category_type.php";
  final String updateCategoryTypeStatusAPI = "update_category_type_status.php";
  final String deleteCategoryTypeAPI = "delete_category_type.php";
  final String categoryTypeListAPI = "view_category_types.php";

  /// File Type
  final String fileTypeAPI = "create_file_type.php";
  final String updateFileTypeAPI = "update_file_type.php";
  final String updateFileTypeStatusAPI = "update_file_type_status.php";
  final String deleteFileTypeAPI = "delete_file_type.php";
  final String fileTypeListAPI = "view_file_types.php";

  /// Category
 final String categoryListAPI="view_categories.php";
  final String categoryAddAPI = "create_category.php";
  final String categoryUpdateAPI = "update_category.php";
  final String categoryDeleteAPI = "delete_category.php";

  /// Question Type
    final String questionTypeAPI = "view_question_types.php";

  /// Quiz
  final String quizListAPI = "view_practice_tests.php";
  final String createQuizAPI = "create_practice_test.php";
  final String updateQuizAPI = "update_practice_test.php";
  final String deleteQuizAPI = "delete_practice_test.php";

  /// Quiz Question
  final String questionListAPI = "view_practice_questions.php";
  final String createQuestionAPI = "create_practice_question.php";
  final String updateQuestionAPI = "update_practice_question.php";
  final String deleteQuestionAPI = "delete_practice_question.php";

   // Quiz Question Multiple

  final String downloadSampleQuestionAPI = "download_sample_excel.php";
  final String importQuestionAPI = "import_questions.php";

}

mixin class ApiSecurity {
  // ignore: non_constant_identifier_names
 static const String content_type = "application/json";
 static const String accept = "application/json";
  final String authorization = "Authorization";
  final String $ApiAccessKey = 'ComplexAccessKey2024@';

 static Future<Map<String, String>> getHeaderWithAuth() async {
    return {
      'Content-Type': content_type,
      'Accept': accept,

      // 'Authorization':
      //     'Bearer ${SessionHelper.loginResponse!.data!.tokens!.access!.token!}',
    };
  }

  Map<String, String> get getHeader {
    return {
      'Content-Type': content_type,
      'Accept': accept,
    };
  }

  Map<String, String> get authHeader {
    return {
      'Content-Type': content_type,
      'Accept': accept,
      'Authorization': 'Bearer ${SessionHelper.loginResponse!.accessToken}',
    };
  }

  Map<String, String> get refreshHeader {
    return {
      'Authorization':
          "Bearer ${SessionHelper.loginResponse?.refreshToken ?? ''}",
      'Old-Access-Token': SessionHelper.loginResponse?.accessToken ?? '',
    };
  }
}

class APIStatusCode {
  static const int SUCCESS = 200;
  static const int CREATED = 201;
  static const int ACCEPTED = 202;
  static const int NO_CONTENT = 204;
  static const int BAD_REQUEST = 400;
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int METHOD_NOT_ALLOWED = 405;
  static const int CONFLICT = 409;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int NOT_IMPLEMENTED = 501;
  static const int BAD_GATEWAY = 502;
  static const int SERVICE_UNAVAILABLE = 503;
  static const int GATEWAY_TIMEOUT = 504;
}

class APIExceptionString {
  static const String UNAUTHUNTICATED = 'Unauthenticated';
}
