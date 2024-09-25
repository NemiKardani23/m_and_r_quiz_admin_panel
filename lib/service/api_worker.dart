import 'package:dio/dio.dart';
import 'package:m_and_r_quiz_admin_panel/common_model/global_crud_response.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionhelper.dart';
import 'package:m_and_r_quiz_admin_panel/service/dio_client.dart';
import 'package:m_and_r_quiz_admin_panel/view/auth/model/refresh_token_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/model/category_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';

class ApiWorker extends DioClient with ApiSecurity, ApiConstant {
  //Todo: AUTH
  // Future<GenrateOtpResponse?> genrateOtpUser({
  //   required String phoneNumber,
  //   required String dialCode,
  //   required bool isPandit,
  // }) async {
  //   final String sendingUrl = generateOTP;
  //   var data = FormData.fromMap({
  //     'phone': phoneNumber,
  //     'dialCode': dialCode,
  //     'role': isPandit ? 'pandit' : 'user',
  //     // 'walletPassword': "2000"
  //   });
  //   var response = await postByCustom(
  //     sendingUrl,
  //     data: data,
  //     options: Options(
  //       headers: authHeader,
  //     ),
  //   );

  //   if (response.statusCode == 200) {
  //     return GenrateOtpResponse.fromJson(response.data!);
  //   } else {
  //     return null;
  //   }
  // }

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
}
