import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/base_client.dart';
import '../../../localization/strings_enum.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_snackbar.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class ForgotPassController extends GetxController {
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = new GlobalKey();
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();

  String generateGuestToken() {
    // Generate a placeholder or generic token for the guest user
    return 'guest_token';
  }

  var selectedValue = false.obs;

  void setSelectedValue(bool value) {
    selectedValue.value = value;
  }

  Future<void> forgotPassAPI(context) async {
    final formState = formKey.currentState;
    if (formState!.validate()) {
      Utils.check().then((value) async {
        if (value) {
          btnController.start();
          await BaseClient.post(Constants.forgotPassUrl, onSuccess: (response) async {
            btnController.stop();
            apiCallStatus = ApiCallStatus.success;

            if (response.data['data'] != null) {
              await _appPreferences.isPreferenceReady;

              Utils.showToast(
                response.data['message'],
                false,
              );
              Get.toNamed(AppRoutes.resetPass, arguments: emailController.text);
            } else {
              Utils.showToast('Incorrect Password or Email', true);
              // Handle the case where data is null in the response
            }
          }, onError: (error) {
            BaseClient.handleApiError(error);
            btnController.stop();
            apiCallStatus = ApiCallStatus.error;
          }, data: {
            'email': emailController.text,
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
}
