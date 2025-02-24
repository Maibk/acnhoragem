import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/widgets/custom_snackbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as gttt;
// import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../Shared_prefrences/app_prefrences.dart';
import '../../core/utils/utils.dart';
import '../../localization/strings_enum.dart';
import '../../widgets/custom_toast.dart';
import 'api_exceptions.dart';

class BaseClient {
  static AppPreferences _appPreferences = AppPreferences();

  // static Future<bool> checkInternetConnection() async {
  //   bool result = await InternetConnectionChecker().hasConnection;
  //   return result;
  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  // }

  static final Dio _dio = Dio(); //Network.getDio();

  static const int TIME_OUT_DURATION = 50000; // in milliseconds
  // GET request
  static get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(ApiException)? onError,
    Function(int value, int progress)? onReceiveProgress,
    Function? onLoading,
  }) async {
    bool check = await checkInternetConnection();
    if (check == true) {
      try {
        onLoading?.call();

        Map<String, dynamic> map = {'Accept': 'application/json'};
        if (headers != null) {
          headers.addEntries(map.entries);
        } else {
          headers = map;
        }
        // 3) try to perform http request
        var response = await _dio
            .get(
              url,
              onReceiveProgress: onReceiveProgress,
              queryParameters: queryParameters,
              options: Options(
                headers: headers,
              ),
            )
            .timeout(const Duration(seconds: TIME_OUT_DURATION));
        print(queryParameters);
        print(response);
        // 3) return response (api done successfully)
        await onSuccess(response);
      } on DioException catch (error) {
        if (error.response == null && error.message == null) {
          var exception = ApiException(
            url: url,
            message: 'Unable to process request. Please try again later.',
          );
          return onError?.call(exception) ?? handleApiError(exception);
        }

        if (error.response == null) {
          var exception = ApiException(
            url: url,
            message: error.message!,
          );
          return onError?.call(exception) ?? handleApiError(exception);
        }
        print('error ====>');
        print(error);
        if (error.message!.toLowerCase().contains('socket')) {
          onError?.call(ApiException(
                message: 'no internet connection'.tr,
                url: url,
              )) ??
              _handleError('no internet connection');
        }

        await _appPreferences.getAppPreferences().isPreferenceReady;

        if (error.response?.statusCode == 401) {
          await _appPreferences.getAppPreferences().clearPreference();
          Utils.showToast(Strings.sessionExpiredMessage, true);

          return;
        }
        if (error.response?.statusCode == 403) {
          var exception = ApiException(
            message: error.response?.data['message'],
            url: url,
            statusCode: 403,
          );
          return onError?.call(exception) ?? handleApiError(exception);
        }

        if (error.response?.statusCode == 404) {
          var exception = ApiException(
            message: error.response?.data['message'],
            url: url,
            statusCode: 404,
          );
          return onError?.call(exception) ?? handleApiError(exception);
        }

        // check if the error is 500 (server problem)
        if (error.response?.statusCode == 500) {
          var exception = ApiException(
            message: 'no internet connection',
            url: url,
            statusCode: 500,
          );
          return onError?.call(exception) ?? handleApiError(exception);
        }
      } on SocketException {
        // No internet connection
        onError?.call(ApiException(
              message: 'no internet connection',
              url: url,
            )) ??
            _handleError('no internet connection');
      } on TimeoutException {
        // Api call went out of time
        onError?.call(ApiException(
              message: 'server not responding',
              url: url,
            )) ??
            _handleError('server not responding');
      } catch (error) {
        print(' api excpection Erorrrrrrr  $error');
        onError?.call(ApiException(
              message: error.toString(),
              url: url,
            )) ??
            _handleError(error.toString());
      }
    } else {
      return false;
    }
  }




  static Future<MultipartFile> getMultipartFileFromUrl(String imageUrl) async {
    try {
      var response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        Directory tempDir = await getTemporaryDirectory();
        String fileName = basename(imageUrl);
        File file = File('${tempDir.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return await MultipartFile.fromFile(file.path, filename: fileName);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      throw Exception('Error fetching image: $e');
    }
  }

  // POST request
  static post(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(ApiException)? onError,
    Function(int total, int progress)? onSendProgress, // while sending (uploading) progress
    Function(int total, int progress)? onReceiveProgress, // while receiving data(response)
    Function? onLoading,
    dynamic data,
  }) async {
    try {
      // 1) indicate loading state
      onLoading?.call();
      // 2) add Accept header
      Map<String, dynamic> map = {'Accept': 'application/json'};
      if (headers != null) {
        headers.addEntries(map.entries);
      } else {
        headers = map;
      }
      // 3) try to perform http request
      var response = await _dio.post(
        url,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        options: Options(
            headers: headers, receiveTimeout: Duration(milliseconds: TIME_OUT_DURATION), sendTimeout: Duration(milliseconds: TIME_OUT_DURATION)),
      );

      // 3) return response (api done successfully)
      await onSuccess.call(response);
    } on DioException catch (error) {
      // dio error (api reach the server but not performed successfully

      // no response
      if (error.response == null) {
        var exception = ApiException(
          url: url,
          message: error.message!,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      // no internet connection
      print(error);

      // no response
      if (error.response!.data['message'] == null) {
        var exception = ApiException(
          url: url,
          message: error.message!,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      if (error.response!.data['message'].toLowerCase().contains('socket')) {
        onError?.call(ApiException(
              message: 'no internet connection'.tr,
              url: url,
            )) ??
            _handleError('no internet connection');
      }

      await _appPreferences.getAppPreferences().isPreferenceReady;

      if (error.response?.statusCode == 401) {
        log(error.response!.data.toString(), name: "dataaaaa");
        await _appPreferences.getAppPreferences().clearPreference();

        ///open in beta
        // if(gttt.Get.currentRoute!=AppRoutes.loginScreen){
        //   gttt.Get.offAllNamed(AppRoutes.loginScreen);
        // }

        return;
      }

      if (error.response?.statusCode == 404) {
        Utils.showToast(error.response?.data['message'], true);

        return;
      }

      if (error.response?.data['data']['email'].toString() == "[The email has already been taken.]") {
        onError?.call(ApiException(
          message: 'The email has already been taken.'.tr,
          url: url,
        ));
      }

      // if (error.response?.statusCode == 403) {
      //   var exception = ApiException(message: error.response?.data['message'], url: url, statusCode: 403,);
      //   return onError?.call(exception) ?? handleApiError(exception);
      // }
      // if (error.response?.statusCode == 422) {
      //   var exception = ApiException(message: error.response?.data['message'], url: url, statusCode: 404,);
      //   return onError?.call(exception) ?? handleApiError(exception);
      // }
      // check if the error is 500 (server problem)
      if (error.response!.statusCode! >= 500) {
        // var exception = ApiException(message: 'Server Error! Something went wrong, please try again.', url: url, statusCode: 500,);
        // return onError?.call(exception) ?? handleApiError(exception);

        CustomToast().showToast('Server Error! Something went wrong, please try again.', true);

        return;
      }

      var exception = ApiException(
        message: error.response!.data['message'],
        url: url,
        statusCode: error.response?.statusCode ?? 404,
      );
      return onError?.call(exception) ?? handleApiError(exception);
    } on SocketException {
      // No internet connection
      onError?.call(ApiException(
            message: 'no internet connection',
            url: url,
          )) ??
          _handleError('no internet connection');
    } on TimeoutException {
      // Api call went out of time
      onError?.call(ApiException(
            message: 'server not responding'.tr,
            url: url,
          )) ??
          _handleError('server not responding');
    } catch (error) {
      // unexpected error for example (parsing json error)
      onError?.call(ApiException(
            message: error.toString(),
            url: url,
          )) ??
          _handleError(error.toString());
    }
  }

  // PUT request
  static put(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(ApiException)? onError,
    Function(int total, int progress)? onSendProgress, // while sending (uploading) progress
    Function(int total, int progress)? onReceiveProgress, // while receiving data(response)
    Function? onLoading,
    dynamic data,
  }) async {
    print(url);
    print(data);
    try {
      // 1) indicate loading state
      onLoading?.call();
      // 2) add Accept header
      Map<String, dynamic> map = {'Accept': 'application/json'};
      if (headers != null) {
        headers.addEntries(map.entries);
      } else {
        headers = map;
      }
      // 2) try to perform http request
      var response = await _dio.put(
        url,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        options: Options(
            headers: headers, receiveTimeout: Duration(milliseconds: TIME_OUT_DURATION), sendTimeout: Duration(milliseconds: TIME_OUT_DURATION)),
      );
      // 3) return response (api done successfully)
      await onSuccess.call(response);
    } on DioError catch (error) {
      // dio error (api reach the server but not performed successfully
      // no response
      if (error.response == null) {
        var exception = ApiException(
          url: url,
          message: error.message!,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      // no response
      if (error.response!.data['message'] == null) {
        var exception = ApiException(
          url: url,
          message: error.message!,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      // no internet connection
      if (error.response!.data['message'].toLowerCase().contains('socket')) {
        onError?.call(ApiException(
              message: 'no internet connection',
              url: url,
            )) ??
            _handleError('no internet connection');
      }

      await _appPreferences.getAppPreferences().isPreferenceReady;

      if (error.response?.statusCode == 401) {
        print('401');
        await _appPreferences.getAppPreferences().clearPreference();

        /// open in beta
        // gttt.Get.offAllNamed(AppRoutes.loginScreen);

        return;
      }
      // check if the error is 500 (server problem)
      if (error.response?.statusCode == 500) {
        var exception = ApiException(
          message: 'Server Error! Something went wrong, please try again.',
          url: url,
          statusCode: 500,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      var exception = ApiException(
        message: error.response!.data['message'],
        url: url,
        statusCode: error.response?.statusCode ?? 404,
      );
      return onError?.call(exception) ?? handleApiError(exception);
    } on SocketException {
      // No internet connection
      onError?.call(ApiException(
            message: 'no internet connection',
            url: url,
          )) ??
          _handleError('no internet connection');
    } on TimeoutException {
      // Api call went out of time
      onError?.call(ApiException(
            message: 'server not responding',
            url: url,
          )) ??
          _handleError('server not responding');
    } catch (error) {
      // unexpected error for example (parsing json error)
      onError?.call(ApiException(
            message: error.toString(),
            url: url,
          )) ??
          _handleError(error.toString());
    }
  }

  // DELETE request
  static delete(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(ApiException)? onError,
    Function? onLoading,
    dynamic data,
  }) async {
    try {
      // 1) indicate loading state
      onLoading?.call();
      // 2) add Accept header
      Map<String, dynamic> map = {'Accept': 'application/json'};
      if (headers != null) {
        headers.addEntries(map.entries);
      } else {
        headers = map;
      }
      // 2) try to perform http request
      var response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
            headers: headers, receiveTimeout: Duration(milliseconds: TIME_OUT_DURATION), sendTimeout: Duration(milliseconds: TIME_OUT_DURATION)),
      );
      // 3) return response (api done successfully)
      await onSuccess.call(response);
    } on DioError catch (error) {
      // dio error (api reach the server but not performed successfully
      // no internet connection
      if (error.message!.toLowerCase().contains('socket')) {
        onError?.call(ApiException(
              message: 'no internet connection',
              url: url,
            )) ??
            _handleError('no internet connection');
      }

      // no response
      if (error.response == null) {
        var exception = ApiException(
          url: url,
          message: error.message!,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      await _appPreferences.getAppPreferences().isPreferenceReady;

      if (error.response?.statusCode == 401) {
        await _appPreferences.getAppPreferences().clearPreference();

        ///open in beta
        // gttt.Get.offAllNamed(AppRoutes.loginScreen);

        return;
      }
      // check if the error is 500 (server problem)
      if (error.response?.statusCode == 500) {
        var exception = ApiException(
          message: 'Server Error! Something went wrong, please try again.',
          url: url,
          statusCode: 500,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      var exception = ApiException(
        message: error.message!,
        url: url,
        statusCode: error.response?.statusCode ?? 404,
      );
      return onError?.call(exception) ?? handleApiError(exception);
    } on SocketException {
      // No internet connection
      onError?.call(ApiException(
            message: 'no internet connection',
            url: url,
          )) ??
          _handleError('no internet connection');
    } on TimeoutException {
      // Api call went out of time
      onError?.call(ApiException(
            message: 'server not responding',
            url: url,
          )) ??
          _handleError('server not responding');
    } catch (error) {
      // unexpected error for example (parsing json error)
      onError?.call(ApiException(
            message: error.toString(),
            url: url,
          )) ??
          _handleError(error.toString());
    }
  }

  static postMultipleFile({
    required String endPoint,
    required BuildContext context,
    Map<String, dynamic>? headers,
    required FormData data,
  }) async {
    Response? response;

    try {
      response = await _dio.post(
        endPoint,
        data: data,
        options: Options(
          method: 'POST',
        ),
      );
    } on DioException catch (e) {
      log(e.toString());
      response = e.response;
    } catch (e) {
      log(e.toString());
      CustomSnackBar.showCustomErrorToast(
        message: Strings.noInternetConnection,
      );
    }

    return response?.data;
  }

  /// download file
  static download(
      {required String url, // file url
      required String savePath, // where to save file
      Function(ApiException)? onError,
      Function(int value, int progress)? onReceiveProgress,
      required Function onSuccess}) async {
    try {
      await _dio.download(
        url,
        savePath,
        options: Options(receiveTimeout: Duration(milliseconds: 999999), sendTimeout: Duration(milliseconds: 999999)),
        onReceiveProgress: onReceiveProgress,
      );
      onSuccess();
    } catch (error) {
      var exception = ApiException(url: url, message: error.toString());
      onError?.call(exception) ?? _handleError(error.toString());
    }
  }

  /// handle error automaticly (if user didnt pass onError) method
  /// it will try to show the message from api if there is no message
  /// from api it will show the reason
  static handleApiError(ApiException apiException) {
    String msg = apiException.response?.body?['message'] ?? apiException.message;
    print(apiException.response?.body);
    CustomToast().showToast(msg, true);
  }

  /// handle errors without response (500, out of time, no internet,..etc)
  static _handleError(String msg) {
    CustomToast().showToast(msg, true);
  }
}
