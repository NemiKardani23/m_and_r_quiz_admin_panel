// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:m_and_r_quiz_admin_panel/exception/nk_api_error_handler.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionhelper.dart';
// ignore: depend_on_referenced_packages
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../export/___app_file_exporter.dart';
import 'dart:typed_data';
import 'dart:html' as HTML;

final logger = PrettyDioLogger(
  requestHeader: true,
  requestBody: true,
  responseBody: true,
  responseHeader: false,
  error: true,
  compact: true,
  request: true,
  maxWidth: 90,
  enabled: kDebugMode,
  // filter: (options, args) {
  //   // don't print requests with uris containing '/posts'
  //   // if (options.path.contains('/posts')) {
  //   //   return false;
  //   // }
  //   // don't print responses with unit8 list data
  //   return !args.isResponse || !args.hasUint8ListData;
  // }
);

class DioClient extends ApiConstant {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            headers: SessionHelper.loginResponse?.accessToken != null
                ? ApiSecurity().authHeader
                : null,
            baseUrl: ApiConstant().baseUrl,
            connectTimeout: const Duration(minutes: 5),
            receiveTimeout: const Duration(minutes: 5),
            responseType: ResponseType.json,
          ),
        )..interceptors
            .addAll([AuthorizationInterceptor(), LoggerInterceptor(), logger]);

  late final Dio _dio;

  Dio getdio() {
    return _dio;
  }

  DioClient getInstance() {
    return this;
  }

  // HTTP request methods will go here

  Future<Response<T>> postByCustom<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<T>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on DioException catch (err) {
      final errorMessage = DioExceptionHandler.fromDioError(err).toString();
      return Future.error(errorMessage);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response<T>> patchByCustom<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch<T>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on DioException catch (err) {
      final errorMessage = DioExceptionHandler.fromDioError(err).toString();
      return Future.error(errorMessage);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response<T>> deleteByCustom<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (err) {
      final errorMessage = DioExceptionHandler.fromDioError(err).toString();
      return Future.error(errorMessage);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response<T>> getByCustom<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<T>(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on DioException catch (err) {
      final errorMessage = DioExceptionHandler.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> downloadByCustom<T>(
    String urlPath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // final response = await _dio.get(urlPath,
      //     queryParameters: queryParameters,
      //     options: options,
      //     cancelToken: cancelToken,
      //     onReceiveProgress: onReceiveProgress);
      final response = downloadFile(urlPath, headers: options?.headers);

      return response;
    } on DioException catch (err) {
      final errorMessage = DioExceptionHandler.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> downloadFile(String url, {Map<String, dynamic>? headers}) async {
    try {
      // Create an HttpRequest to fetch the file data
      final request = HTML.HttpRequest();
      request.open('GET', url);

      // If headers are provided, set them
      if (headers != null) {
        headers.forEach((key, value) {
          request.setRequestHeader(key, value);
        });
      }

      // Send the request and wait for the response
      request.responseType = 'blob'; // Set the response type to 'blob'
      request.send();

      // Return a future that resolves when the request completes
      return await Future<bool>.delayed(Duration.zero, () {
        // Listen for the load end event
        request.onLoadEnd.listen((event) {
          if (request.status == 200) {
            // Create a Blob from the response
            final blob = request.response as HTML.Blob;
            final downloadUrl = HTML.Url.createObjectUrl(blob);

            // Create an anchor element to download the file
            final anchorElement = HTML.AnchorElement(href: downloadUrl);
            anchorElement.download =
                'downloaded_file'; // Set the default file name
            anchorElement.click();

            // Clean up the object URL
            HTML.Url.revokeObjectUrl(downloadUrl);

            // Return true indicating success
            return;
          } else {
            nkDevLog('Error downloading file: ${request.status}');
            return; // Return false indicating failure
          }
        });
        return false; // Return false by default if the download is not initiated
      });
    } catch (e) {
      nkDevLog('An error occurred: $e');
      return false; // Return false indicating failure
    }
  }

// Helper function to extract file name from the URL
  String extractFileName(String url) {
    final uri = Uri.parse(url);
    final pathSegments = uri.pathSegments;

    if (pathSegments.isNotEmpty) {
      return pathSegments
          .last; // Return the last segment, which is usually the file name
    }

    return 'downloaded_file'; // Fallback file name if no valid file found
  }
}

class DioExceptionHandler implements Exception {
  late String errorMessage;
  late String type;

  DioExceptionHandler.fromDioError(DioException dioError) {
    // logger.w("ERROR RESPONSE  ${jsonEncode(dioError.response?.data)}");
    // logger.f(
    //     'Error: ${dioError.type}, Message: ${dioError.response?.data["message"] ?? dioError.message}');

    switch (dioError.type) {
      case DioExceptionType.cancel:
        errorMessage = dioError.response?.data['message'] ?? dioError.message;
        NKToast.error(description: errorMessage);
        NkApiErrorHandler().handleUnAuthanTicateError(
            message: errorMessage, code: dioError.response?.statusCode ?? 0);
        // NkCommonFunction.showErrorSnakBar(errorMessage);
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = dioError.message ?? 'No Internet Connection';
        NKToast.error(description: errorMessage);
        NkApiErrorHandler().handleUnAuthanTicateError(
            message: errorMessage, code: dioError.response?.statusCode ?? 0);

        // NkCommonFunction.showErrorSnakBar(errorMessage);
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = dioError.response?.data['message'] ?? dioError.message;
        NKToast.error(description: errorMessage);
        NkApiErrorHandler().handleUnAuthanTicateError(
            message: errorMessage, code: dioError.response?.statusCode ?? 0);

        // NkCommonFunction.showErrorSnakBar(errorMessage);

        break;
      case DioExceptionType.sendTimeout:
        errorMessage = dioError.response?.data['message'] ?? dioError.message;
        NKToast.error(description: errorMessage);
        NkApiErrorHandler().handleUnAuthanTicateError(
            message: errorMessage, code: dioError.response?.statusCode ?? 0);

        // NkCommonFunction.showErrorSnakBar(errorMessage);

        break;
      case DioExceptionType.badResponse:
        errorMessage = dioError.response?.data['message'] ?? dioError.message;
        NKToast.error(description: errorMessage);
        NkApiErrorHandler().handleUnAuthanTicateError(
            message: errorMessage, code: dioError.response?.statusCode ?? 0);

        // NkCommonFunction.showErrorSnakBar(errorMessage);

        break;
      case DioExceptionType.badCertificate:
        errorMessage = dioError.response?.data['message'] ?? dioError.message;
        NKToast.error(
            title: "Error Code : ${dioError.response?.statusCode}",
            description: errorMessage);
        NkApiErrorHandler().handleUnAuthanTicateError(
            message: errorMessage, code: dioError.response?.statusCode ?? 0);

        // NkCommonFunction.showErrorSnakBar(errorMessage);

        break;
      case DioExceptionType.connectionError:
        errorMessage = dioError.response?.data['message'] ?? dioError.message;
        NKToast.error(description: errorMessage);
        NkApiErrorHandler().handleUnAuthanTicateError(
            message: errorMessage, code: dioError.response?.statusCode ?? 0);

        break;
      default:
        if (dioError.response?.data == null) {
          errorMessage = dioError.message ?? 'No Internet Connection';
          NKToast.error(description: errorMessage);
          NkApiErrorHandler().handleUnAuthanTicateError(
              message: errorMessage, code: dioError.response?.statusCode ?? 0);

          return;
        }
        errorMessage = 'Something went wrong';
        NKToast.error(description: errorMessage);
        NkApiErrorHandler().handleUnAuthanTicateError(
            message: errorMessage, code: dioError.response?.statusCode ?? 0);

        // NkCommonFunction.showErrorSnakBar(errorMessage);

        break;
    }
  }

  @override
  String toString() => errorMessage;
}

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_needAuthorizationHeader(options)) {
      // adds the access-token with the header
      // options.headers['Authorization'] = 'Bearer $API_KEY';
    }
    // continue with the request
    super.onRequest(options, handler);
  }

  bool _needAuthorizationHeader(RequestOptions options) {
    if (options.method == 'GET') {
      return false;
    } else {
      return true;
    }
  }
}

class LoggerInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // final options = err.requestOptions;
    // final requestPath = '${options.baseUrl}${options.path}';

    // logger.e('${options.method} request => $requestPath'); // Debug log
    // logger.w('Error: ${err.error}, Message: ${err.message}'); // Error log
    // Error log
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // if (SessionHelper.loginResponse != null) {
    //   if (SessionHelper.loginResponse?.refreshTokenExpiry != null) {
    //     if (DateTime.now()
    //         .isAfter(SessionHelper.loginResponse!.refreshTokenExpiry!)) {
    //       ApiWorker().refreshToken();
    //     }
    //   }

    return super.onRequest(options, handler);
    // }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // logger.d(
    //     'StatusCode: ${response.statusCode}, Data: ${response.data}'); // Debug log

    // logger.f(
    //     'RESPONSE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  ${jsonEncode(response.data)}'); // Debug log
    return super.onResponse(response, handler);
  }
}
