import 'dart:io';

import 'package:anchorageislamabad/core/model_classes/signup_model.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
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

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class SignUpController extends GetxController {
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  TextEditingController userTypeContoller = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController presentAddressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Rx<bool> isShowPassword = true.obs;

  GlobalKey<FormState> formKey = new GlobalKey();
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();

  SignUpModel? singupResponseModel;

  Future<void> signupAPI(context) async {
    final formState = formKey.currentState;
    if (formState!.validate()) {
      Utils.check().then((value) async {
        if (value) {
          btnController.start();
          await BaseClient.post(Constants.registerUrl, onSuccess: (response) async {
            btnController.stop();
            apiCallStatus = ApiCallStatus.success;

            if (response.data['data'] != null) {
              singupResponseModel = SignUpModel.fromJson(response.data);
              _appPreferences.setAccessToken(token: singupResponseModel!.data!.token!);
              _appPreferences.setRole(role: singupResponseModel!.data!.userCategory!);
              Utils.showToast(
                response.data['message'],
                false,
              );

              userTypeContoller.text == "Owner"
                  ? Get.offAllNamed(AppRoutes.ownerFormsPage, arguments: {'status': "", 'id': ""})
                  : Get.offAllNamed(AppRoutes.tenantFormsPage, arguments: {'status': "", 'id': ""});
            } else {
              Utils.showToast('Incorrect Password or Email', true);
            }
          }, onError: (error) {
            BaseClient.handleApiError(error);
            btnController.stop();
            apiCallStatus = ApiCallStatus.error;
          }, data: {
            "user_category": userTypeContoller.text,
            "first_name": firstNameController.text,
            "last_name": lastNameController.text,
            "email": emailController.text,
            "phone": phoneController.text,
            "present_address": presentAddressController.text,
            "password": passwordController.text,
            "c_password": passwordController.text,
            'device_token': Constants.device_token,
            'device_type': Platform.isAndroid ? "Android" : "iOS",
          });
        } else {
          CustomSnackBar.showCustomErrorToast(
            message: Strings.noInternetConnection.tr,
          );
        }
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
