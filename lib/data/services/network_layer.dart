import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../Shared_prefrences/app_prefrences.dart';
import '../../routes/app_routes.dart';

class Network {
  static Dio dio = new Dio();

  static AppPreferences _appPreferences = AppPreferences();

  static Dio getDio() {
    dio.options.headers['Accept'] = "application/json";
    dio.options.connectTimeout = (120 * 1000) as Duration?;
    dio.options.receiveTimeout = (120 * 1000) as Duration?;

    dio.interceptors.add(InterceptorsWrapper(onError: (error, _) async {
      print(error.response?.statusCode);

      await _appPreferences.getAppPreferences().isPreferenceReady;

      if (error.response?.statusCode == 401) {
        await _appPreferences.getAppPreferences().clearPreference();

        /// open in beta
        // Get.offAllNamed(AppRoutes.loginScreen);
      }
      // return error.response;
    }));

    dio.options;
    return dio;
  }
}
