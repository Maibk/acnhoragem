import 'dart:convert';
import 'dart:io';
import 'package:anchorageislamabad/core/model_classes/signup_model.dart';
import 'package:anchorageislamabad/presentation/login_screen/models/login_model.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
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
class SignUpController extends GetxController {
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  TextEditingController userTypeContoller = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
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
              Utils.showToast(
                response.data['message'],
                false,
              );

              userTypeContoller.text == "Owner" ? Get.offAllNamed(AppRoutes.ownerFormsPage) : Get.offAllNamed(AppRoutes.tenantFormsPage);
            } else {
              Utils.showToast('Incorrect Password or Email', true);
              // Handle the case where data is null in the response
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
            "present_address": "Karachi Pakistan",
            "password": passwordController.text,
            "c_password": passwordController.text
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
