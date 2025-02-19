import 'dart:developer';

import 'package:anchorageislamabad/data/services/base_client.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:package_info/package_info.dart';

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/api_exceptions.dart';
import '../../../service/local_database.dart';
import '../../myprofile_screen/models/profile_model.dart';
import '../models/splash_model.dart';

/// A controller class for the SplashScreen.
///
/// This class manages the state of the SplashScreen, including the
/// current splashModelObj
///
///
ProfileModel? profileModel;

///
class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;
  AppPreferences appPreferences = AppPreferences();

  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();

  // Rx<PackageInfo> packageInfo = PackageInfo(
  //   appName: 'autoapp',
  //   packageName: 'Unknown',
  //   version: '1.0.1',
  //   buildNumber: 'Unknown',
  // ).obs;

  // Future<void> initPackageInfo() async {
  //   final PackageInfo info = await PackageInfo.fromPlatform();
  //   packageInfo.value = info;
  // }

  Future<ProfileModel?> getProfile() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.getProfileUrl,
              onSuccess: (response) async {
            profileModel = ProfileModel.fromJson(response.data);
            log(response.toString());

            update();

            return true;
          }, onError: (error) {
            ApiException apiException = error;

            print(apiException.message);

            BaseClient.handleApiError(error);

            apiCallStatus.value = ApiCallStatus.error;

            return false;
          });
        });
      } else {
        isInternetAvailable.value = false;
      }
    });
    return null;
  }

  Future<void> getRoute() async {
    await getProfile();

    await appPreferences.isPreferenceReady;
    appPreferences
        .getIsLoggedIn()
        .then((value) async => {
              print('getIsLoggedIn $value'),
              await Future.delayed(3000.milliseconds),
              if (value == null || !value)
                {
                  Get.offAndToNamed(AppRoutes.loginPage),
                }
              else
                {
                  if (profileModel!.appForm == 0 && profileModel!.userCategory == "Owner")
                    {Get.offAllNamed(AppRoutes.ownerFormsPage)}
                  else
                    {Get.offAllNamed(AppRoutes.homePage)},
                  if (profileModel!.appForm == 0 && profileModel!.userCategory == "Tenant")
                    {Get.offAllNamed(AppRoutes.tenantFormsPage)}
                  else
                    {Get.offAllNamed(AppRoutes.homePage)}
                }
            })
        .catchError((err) async {
      await Future.delayed(3000.milliseconds);
      Get.offAndToNamed(AppRoutes.loginPage);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getRoute();
  }
}
