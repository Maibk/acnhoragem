import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:anchorageislamabad/presentation/login_screen/models/login_model.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/model_classes/login_model.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/base_client.dart';
import '../../../localization/strings_enum.dart';
import '../../../widgets/custom_snackbar.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
///
///
LoginModel? loginResponseModel;

///
class LoginController extends GetxController {
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  TextEditingController emailController = TextEditingController(text: kDebugMode ? "e@yopmail.com" : null);

  TextEditingController passwordController = TextEditingController(text: kDebugMode ? "12345678" : null);
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

              await _appPreferences.isPreferenceReady;

              Utils.showToast(
                response.data['message'],
                false,
              );
              Get.offAllNamed(AppRoutes.homePage);
            } else {
               Utils.showToast('Incorrect Password or Email', true);
              btnController.stop();
              // Handle the case where data is null in the response
            }
          }, onError: (error) {
            BaseClient.handleApiError(error);
            btnController.stop();
            apiCallStatus = ApiCallStatus.error;
          }, data: {
            'email': emailController.text,
            'password': passwordController.text,
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
