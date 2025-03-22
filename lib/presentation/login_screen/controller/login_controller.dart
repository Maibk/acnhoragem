import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/presentation/login_screen/models/login_model.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/base_client.dart';
import '../../../localization/strings_enum.dart';
import '../../../widgets/custom_snackbar.dart';

LoginModel? loginResponseModel;

class LoginController extends GetxController {
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  TextEditingController emailController = TextEditingController(
      text: kDebugMode
          ? "pat.cummins2003@gmail.com"

          //  "dev4@yopmail.com"

          : null);
  AppPreferences appPreferences = AppPreferences();

  TextEditingController passwordController = TextEditingController(text: kDebugMode ? "Test@1234" : null);
  Rx<bool> isShowPassword = true.obs;
  GlobalKey<FormState> formKey = new GlobalKey();
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  AppPreferences _appPreferences = AppPreferences();

  Future<void> loginAPI(context) async {
    final formState = formKey.currentState;
    if (formState!.validate()) {
      Utils.check().then((value) async {
        if (value) {
          btnController.start();
          await BaseClient.post(Constants.loginUrl, onSuccess: (response) async {
            btnController.stop();
            apiCallStatus = ApiCallStatus.success;

            if (response.data['data'] != null) {
              loginResponseModel = LoginModel.fromJson(response.data);

              _appPreferences.setIsLoggedIn(loggedIn: true);
              _appPreferences.setAccessToken(token: loginResponseModel!.data!.token!);
              _appPreferences.setProfileData(data: jsonEncode(loginResponseModel));
              _appPreferences.setRole(role: loginResponseModel!.data!.userCategory!);

              await _appPreferences.isPreferenceReady;

              Utils.showToast(
                response.data['message'],
                false,
              );

              if (loginResponseModel?.data?.appForm == 0) {
                if (loginResponseModel?.data?.userCategory == "Owner") {
                  Get.offAllNamed(AppRoutes.ownerFormsPage, arguments: {'status': "", 'id': ""});
                } else {
                  Get.offAllNamed(AppRoutes.tenantFormsPage);
                }
              } else if (loginResponseModel?.data?.appFormApproved == 0) {
                Get.offAllNamed(AppRoutes.homePage);
              } else {
                Get.offAllNamed(AppRoutes.homePage);
              }
            } else {
              Utils.showToast('Incorrect Password or Email', true);
              btnController.stop();
            }
          }, onError: (error) {
            BaseClient.handleApiError(error);
            btnController.stop();
            apiCallStatus = ApiCallStatus.error;
          }, data: {
            'email': emailController.text,
            'password': passwordController.text,
            'device_token': Constants.device_token,
            'device_type': Platform.isAndroid ? "Android" : "iOS",
          });
        } else {
          CustomSnackBar.showCustomErrorToast(
            message: Strings.noInternetConnection.tr,
          );

          btnController.stop();
        }

        btnController.stop();
      });
    } else {
      print("Form validation failed");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
