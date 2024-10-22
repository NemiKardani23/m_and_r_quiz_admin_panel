import 'package:dio/dio.dart';
import 'package:m_and_r_quiz_admin_panel/common_model/global_crud_response.dart';
import 'package:m_and_r_quiz_admin_panel/common_model/image_upload_response.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionhelper.dart';
import 'package:m_and_r_quiz_admin_panel/service/dio_client.dart';
import 'package:m_and_r_quiz_admin_panel/view/app_management/app_dashboard/model/banner_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/auth/model/refresh_token_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/question_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/quiz_create_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/quiz_question_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/model/category_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/model/category_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';

class ApiWorker extends DioClient with ApiSecurity, ApiConstant {
  DioClient get dioClient => getInstance();

  //Todo: AUTH

  Future<UserDetails?> loginAdmin({
    required String email,
    required String password,
  }) async {
    final String sendingUrl = loginAPI;
    var data = FormData.fromMap({
      'access_key': $ApiAccessKey,
      'email': email.toLowerCase(),
      'password': password,
      'device_id': (await NkCommonFunction.webBrowserInfo).userAgent,
    });
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: getHeader,
      ),
    );

    if (response.statusCode == 200) {
      return UserDetails.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> logout() async {
    final String sendingUrl = logoutAPI;
    var data = FormData.fromMap({
      'session_id': SessionHelper.loginResponse?.sessionId,
      'device_id': (await NkCommonFunction.webBrowserInfo).userAgent,
      'access_key': $ApiAccessKey,
    });

    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<RefreshTokenResponse?> refreshToken() async {
    final String sendingUrl = refreshTokenAPI;

    var response = await postByCustom(
      sendingUrl,
      options: Options(
        headers: refreshHeader,
      ),
    );

    if (response.statusCode == 200) {
      var data = RefreshTokenResponse.fromJson(response.data!);
      SessionHelper.loginResponse?.copyWith(
        accessToken: data.data?.accessToken,
        refreshToken: data.data?.refreshToken,
        refreshTokenExpiry: data.timestamp,
      );
      SessionHelper.instance.setLoginData(SessionHelper.loginResponse!);
      return data;
    } else {
      return null;
    }
  }

  // Todo: Banner

  Future<BannerResponse?> getBannerList() async {
    final String sendingUrl = bannerListAPI;
    var sendingData = {
      'access_key': $ApiAccessKey,
    };
    var response = await getByCustom(
      sendingUrl,
      queryParameters: sendingData,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      return BannerResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> addBanner({
    required MultipartFile image,
  }) async {
    final String sendingUrl = bannerAddAPI;
    var data = FormData.fromMap({
      'access_key': $ApiAccessKey,
      'banner_image': image,
    });
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<BannerData?> updateBanner({
    required MultipartFile image,
    required String id,
  }) async {
    final String sendingUrl = bannerUpdateAPI;
    var data = FormData.fromMap(
        {'access_key': $ApiAccessKey, 'banner_image': image, 'banner_id': id});
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return BannerData.fromJson(response.data["data"]!);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> deleteBanner({required String id}) async {
    final String sendingUrl = bannerDeleteAPI;
    var data = FormData.fromMap({'access_key': $ApiAccessKey, 'banner_id': id});
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  // Todo: Category Type
  Future<GlobalCrudResponse?> addCategoryType({
    required String name,
    required String description,
  }) async {
    final String sendingUrl = categoryTypeAPI;
    var data = FormData.fromMap({
      'access_key': $ApiAccessKey,
      'name': name,
      'description': description,
      'status': 'active',
    });
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> updateCategoryType(
      {required String name,
      required String description,
      required String id}) async {
    final String sendingUrl = updateCategoryTypeAPI;
    var data = FormData.fromMap({
      'access_key': $ApiAccessKey,
      'name': name,
      'description': description,
      'category_id': id
    });
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> changeCategoryTypeStatus(
      {required String status, required String id}) async {
    final String sendingUrl = updateCategoryTypeStatusAPI;
    var data = FormData.fromMap(
        {'access_key': $ApiAccessKey, 'status': status, 'category_id': id});
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> deleteCategoryType({required String id}) async {
    final String sendingUrl = deleteCategoryTypeAPI;
    var data =
        FormData.fromMap({'access_key': $ApiAccessKey, 'category_id': id});
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<CategoryTypeResponse?> getCategoryTypeList() async {
    final String sendingUrl = categoryTypeListAPI;
    var response = await getByCustom(
      sendingUrl,
      queryParameters: {'access_key': $ApiAccessKey},
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return CategoryTypeResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  // Todo: Category Type
  Future<GlobalCrudResponse?> addFileType({
    required String name,
    required String description,
  }) async {
    final String sendingUrl = fileTypeAPI;
    var data = FormData.fromMap({
      'access_key': $ApiAccessKey,
      'type_name': name,
      'description': description,
      'status': 'active',
    });
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> updateFileType(
      {required String name,
      required String description,
      required String id}) async {
    final String sendingUrl = updateFileTypeAPI;
    var data = FormData.fromMap({
      'access_key': $ApiAccessKey,
      'type_name': name,
      'description': description,
      'file_type_id': id
    });
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> changeFileTypeStatus(
      {required String status, required String id}) async {
    final String sendingUrl = updateFileTypeStatusAPI;
    var data = FormData.fromMap(
        {'access_key': $ApiAccessKey, 'status': status, 'file_type_id': id});
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> deleteFileType({required String id}) async {
    final String sendingUrl = deleteFileTypeAPI;
    var data =
        FormData.fromMap({'access_key': $ApiAccessKey, 'file_type_id': id});
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<FileTypeResponse?> getFileTypeList() async {
    final String sendingUrl = fileTypeListAPI;
    var response = await getByCustom(
      sendingUrl,
      queryParameters: {'access_key': $ApiAccessKey},
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return FileTypeResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  // Todo: Category
  Future<CategoryResponse?> getCategoryList(
      {String? id,
      String? perentId,
      String? categoryLavel,
      String? fileTypeId}) async {
    final String sendingUrl = categoryListAPI;
    Map<String, dynamic> queryParameters = {'access_key': $ApiAccessKey};
    if (id != null) {
      queryParameters.addAll({'id': id});
    }
    if (perentId != null) {
      queryParameters.addAll({'parent_id': perentId});
    }
    if (categoryLavel != null) {
      queryParameters.addAll({'category_level': categoryLavel});
    }
    if (categoryLavel != null) {
      queryParameters.addAll({'file_type_id': fileTypeId});
    }
    var response = await getByCustom(
      sendingUrl,
      queryParameters: queryParameters,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      return CategoryResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> addCategory({
    required String name,
    String? description,
    String? parentId,
    required String typeId,
    required String fileTypeId,
    MultipartFile? categoryImage,
    MultipartFile? file,
  }) async {
    final String sendingUrl = categoryAddAPI;
    Map<String, dynamic> data = {
      'access_key': $ApiAccessKey,
      'name': name,
      'description': description,
      'parent_id': parentId,
      'type_id': typeId,
      'file_type_id': fileTypeId,
      // 'file': null,
      'category_image': null
    };
    if (categoryImage != null) {
      data.addAll({'category_image': categoryImage});
    }
    if (file != null) {
      data.addAll({'file': file});
    }
    var response = await postByCustom(
      sendingUrl,
      data: FormData.fromMap(data),
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> updateCategory({
    required String name,
    String? description,
    String? parentId,
    required String categoryId,
    MultipartFile? categoryImage,
    MultipartFile? file,
    required String typeId,
    required String fileTypeId,
  }) async {
    final String sendingUrl = categoryUpdateAPI;
    Map<String, dynamic> data = {
      'access_key': $ApiAccessKey,
      'name': name,
      'category_id': categoryId,
      'description': description,
      'parent_id': parentId,
      'type_id': typeId,
      'file_type_id': fileTypeId,
    };
    if (categoryImage != null) {
      data.addAll({'category_image': categoryImage});
    }
    if (file != null) {
      data.addAll({'file': file});
    }
    var response = await postByCustom(
      sendingUrl,
      data: FormData.fromMap(data),
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> deleteCategory(
      {required String categoryId}) async {
    final String sendingUrl = categoryDeleteAPI;
    var data = FormData.fromMap(
        {'access_key': $ApiAccessKey, 'category_id': categoryId});
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  /// Todo: Question Type

  Future<QuestionTypeResponse?> getQuestionTypeList() async {
    final String sendingUrl = questionTypeAPI;
    var response = await getByCustom(
      sendingUrl,
      queryParameters: {'access_key': $ApiAccessKey},
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      return QuestionTypeResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  /// Todo: Create Exam
  Future<QuizCreateResponse?> getQuizList({required String categoryId}) async {
    final String sendingUrl = quizListAPI;
    Map<String, dynamic> queryParameters = {
      'access_key': $ApiAccessKey,
      'category_id': categoryId
    };

    var response = await getByCustom(
      sendingUrl,
      queryParameters: queryParameters,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      return QuizCreateResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<QuizCreateData?> createQuiz(
      {required String title,
      String? description,
      required String fileTypeId,
      MultipartFile? thumbnail,
      required String categoryId}) async {
    final String sendingUrl = createQuizAPI;
    Map<String, dynamic> data = {
      'access_key': $ApiAccessKey,
      'title': title,
      'description': description,
      'category_id': categoryId,
      'file_type_id': fileTypeId
    };
    if (thumbnail != null) {
      data.addAll({'thumbnail': thumbnail});
    }
    var response = await postByCustom(
      sendingUrl,
      data: FormData.fromMap(data),
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      return QuizCreateData.fromJson(response.data['data']);
    } else {
      return null;
    }
  }

  Future<QuizCreateData?> updateQuiz(
      {String? title,
      required String quizId,
      String? description,
      MultipartFile? thumbnail,
      String? categoryId}) async {
    final String sendingUrl = updateQuizAPI;
    Map<String, dynamic> data = {
      'access_key': $ApiAccessKey,
      'title': title,
      'description': description,
      'category_id': categoryId,
      'test_id': quizId,
    };
    if (thumbnail != null) {
      data.addAll({'thumbnail': thumbnail});
    }
    var response = await postByCustom(
      sendingUrl,
      data: FormData.fromMap(data),
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return QuizCreateData.fromJson(response.data['data']);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> deleteQuiz({required String quizId}) async {
    final String sendingUrl = deleteQuizAPI;
    var data =
        FormData.fromMap({'access_key': $ApiAccessKey, 'test_id': quizId});
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  // Todo: Question Multiple
  // Future<String?> getQuestionDownloadDemo({required String testId}) async {
  //   final String sendingUrl = baseUrl + downloadSampleQuestionAPI;
  //   Map<String, dynamic> queryParameters = {
  //     'access_key': $ApiAccessKey,
  //     'test_id': testId
  //   };

  //   // var response = await FileSaver.instance.saveFile(
  //   //   name: '',
  //   //   link: LinkDetails(
  //   //       link: sendingUrl,
  //   //       headers: authHeader,
  //   //       method: 'GET',
  //   //       queryParameters: queryParameters),
  //   //   mimeType: MimeType.microsoftExcel,
  //   // );

  //   var response = DownloadManager(dio: getdio()).downloadFile(baseUrl);

  //   if (response.toString().isNotEmpty) {
  //     return "${response}";
  //   } else {
  //     return null;
  //   }
  // }

  Future<QuizQuestionUpdatedTest?> setMultipleQuestion(
      {required String testID, required MultipartFile file}) async {
    final String sendingUrl = importQuestionAPI;
    Map<String, dynamic> data = {
      'access_key': $ApiAccessKey,
      'test_id': testID,
      'question_file': file
    };

    var response = await postByCustom(
      sendingUrl,
      data: FormData.fromMap(data),
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      return QuizQuestionUpdatedTest.fromJson(response.data['data']);
    } else {
      return null;
    }
  }

  // Todo: Quiz Question
  Future<QuizQuestionResponse?> getQuizQuestionList(
      {required String quizId}) async {
    final String sendingUrl = questionListAPI;
    Map<String, dynamic> queryParameters = {
      'access_key': $ApiAccessKey,
      'test_id': quizId
    };

    var response = await getByCustom(
      sendingUrl,
      queryParameters: queryParameters,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      return QuizQuestionResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  Future<QuizQuestionData?> setQuestion(
      {required String quizId,
      required String questionTypeId,
      required String questionText,
      required String marks,
      required String duration,
      required String correctAnswer,
      required String? answerDescription,
      required List<String> optionsList}) async {
    final String sendingUrl = createQuestionAPI;
    Map<String, dynamic> data = {
      'access_key': $ApiAccessKey,
      'test_id': quizId,
      'question_type_id': questionTypeId,
      'question_text': questionText,
      'marks': marks,
      'duration': duration,
      'correct_answer': correctAnswer,
      'answer_description': answerDescription
    };

    for (int i = 0; i < optionsList.length; i++) {
      data.addAll({'options_list[$i]': optionsList[i]});
    }

    var response = await postByCustom(
      sendingUrl,
      data: FormData.fromMap(data),
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      return QuizQuestionData.fromJson(response.data['data']);
    } else {
      return null;
    }
  }

  Future<QuizQuestionData?> updateQuestion(
      {required String quizId,
      required String questionId,
      String? questionTypeId,
      String? questionText,
      String? marks,
      String? duration,
      String? correctAnswer,
      String? answerDescription,
      List<String>? optionsList}) async {
    final String sendingUrl = updateQuestionAPI;
    Map<String, dynamic> data = {
      'access_key': $ApiAccessKey,
      'test_id': quizId,
      'question_id': questionId,
      'question_type_id': questionTypeId,
      'question_text': questionText,
      'marks': marks,
      'duration': duration,
      'correct_answer': correctAnswer,
      'answer_description': answerDescription
    };

    if (optionsList != null) {
      for (int i = 0; i < optionsList.length; i++) {
        data.addAll({'options_list[$i]': optionsList[i]});
      }
    }

    var response = await postByCustom(
      sendingUrl,
      data: FormData.fromMap(data),
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      return QuizQuestionData.fromJson(response.data['data']);
    } else {
      return null;
    }
  }

  Future<GlobalCrudResponse?> deleteQuestion(
      {required String questionId}) async {
    final String sendingUrl = deleteQuestionAPI;
    var data = FormData.fromMap(
        {'access_key': $ApiAccessKey, 'question_id': questionId});
    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200) {
      return GlobalCrudResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }

  /// ********************************************************************* // COMMON API // /*************************************************************************************************/

  /// [uploadFile] Use For Upload File To Server
  Future<ImageUploadResponse?> uploadFile(
      {required MultipartFile file, required String uploadType}) async {
    final String sendingUrl = uploadDynamicFileAPI;
    Map<String, dynamic> data = {
      'access_key': $ApiAccessKey,
      'context': uploadType,
      'file': file
    };

    var response = await postByCustom(
      sendingUrl,
      data: data,
      options: Options(
        headers: authHeader,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      return ImageUploadResponse.fromJson(response.data!);
    } else {
      return null;
    }
  }
}
