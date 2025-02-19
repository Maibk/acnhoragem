import 'dart:developer';

import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:anchorageislamabad/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/api_exceptions.dart';
import '../../../data/services/base_client.dart';
import '../../../localization/strings_enum.dart';
import '../models/profile_model.dart';

/// A controller class for the DiscoverScreen.
///
/// This class manages the state of the DiscoverScreen, including the
/// current discoverModelObj
///
class MyprofileController extends GetxController {
  String name = "";
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController presentAddresController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  final AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();
  GlobalKey<FormState> formKey = new GlobalKey();

  Rx<bool> isShowPassword = false.obs;

  bool isResponse = false;

  ProfileModel? getProfileModel;

  Future<ProfileModel?> getProfile() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.getProfileUrl, onSuccess: (response) {
            getProfileModel = ProfileModel.fromJson(response.data);
            log(response.toString());

            update();

            firstNameController.text = getProfileModel!.firstName!;

            lastNameController.text = getProfileModel!.lastName!;
            emailController.text = getProfileModel!.email!;

            if (getProfileModel?.cnic != null) {
              cnicController.text = getProfileModel!.cnic!;
            }

            if (getProfileModel?.presentAddress != null) {
              presentAddresController.text = getProfileModel!.presentAddress!;
            }

            update();
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

  Future<void> updateProfile(context) async {
    final formState = formKey.currentState;
    if (formState!.validate()) {
      Utils.check().then((value) async {
        if (value) {
          btnController.start();

          _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
            await BaseClient.post(headers: {'Authorization': "Bearer $token"}, Constants.updateProfileUrl, onSuccess: (response) async {
              btnController.stop();
              apiCallStatus.value = ApiCallStatus.success;
              getProfile();
              if (response.data['data'] != null) {
                Utils.showToast(
                  response.data['message'],
                  false,
                );

                Get.toNamed(AppRoutes.homePage);
              } else {
                Utils.showToast('Incorrect Password or Email', true);
                // Handle the case where data is null in the response
              }

              return true;
            }, onError: (error) {
              BaseClient.handleApiError(error);
              btnController.stop();
              apiCallStatus.value = ApiCallStatus.error;
            }, data: {
              "first_name": firstNameController.text,
              "last_name": lastNameController.text,
              "email": emailController.text,
              "present_address": presentAddresController.text,
              "cnic": cnicController.text,
              "id": getProfileModel!.id.toString()
            });
          });
        } else {
          CustomSnackBar.showCustomErrorToast(
            message: Strings.noInternetConnection,
          );
        }
      });
    } else {
      print("Form validation failed");
    }
  }

  @override
  onInit() async {
    super.onInit();
    getProfile();
  }
}
