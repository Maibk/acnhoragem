import 'dart:developer';

import 'package:anchorageislamabad/data/services/base_client.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:package_info/package_info.dart';

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/api_exceptions.dart';
import '../../myprofile_screen/models/profile_model.dart';
import '../models/splash_model.dart';

///
ProfileModel? profileModel;

class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;
  AppPreferences appPreferences = AppPreferences();

  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();
  Future<ProfileModel?> getProfile() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.getProfileUrl, onSuccess: (response) async {
            profileModel = ProfileModel.fromJson(response.data);
            log(response.toString(), name: "Profile Model");
            await getRoute();
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
                    {
                      Get.offAllNamed(AppRoutes.ownerFormsPage, arguments: {'status': "", 'id': ""})
                    }
                  else
                    {Get.offAllNamed(AppRoutes.homePage)},
                  if (profileModel!.appForm == 0 && profileModel!.userCategory == "Tenant")
                    {
                      Get.offAllNamed(AppRoutes.tenantFormsPage, arguments: {'status': "", 'id': ""})
                    }
                  else
                    {Get.offAllNamed(AppRoutes.homePage)}
                }
            })
        .catchError((err) async {
      await Future.delayed(3000.milliseconds);
      Get.offAndToNamed(AppRoutes.loginPage);
    });
  }

  Future<void> getFCMtoken() async {
    try {
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        String? token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          appPreferences.setDeviceToken(deviceId: token);
          Constants.device_token = token;
          debugPrint("FCM Token: $token");
        }
      } else {
        debugPrint('User declined or has not accepted permission');
      }
    } catch (e) {
      debugPrint('FCM Token Error: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
    getFCMtoken();
  }
}
