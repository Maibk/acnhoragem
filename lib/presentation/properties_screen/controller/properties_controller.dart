import 'dart:async';
import 'dart:developer';

import 'package:anchorageislamabad/core/model_classes/properties_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/model_classes/page_model.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/api_exceptions.dart';
import '../../../data/services/base_client.dart';

/// A controller class for the DiscoverScreen.
///
/// This class manages the state of the DiscoverScreen, including the
/// current discoverModelObj
///
class PropertiesController extends GetxController {
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  final TextEditingController userTypeContoller = TextEditingController();
  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.loading.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();

  RxList<PropertiesModel> categories = <PropertiesModel>[].obs;

  PropertiesModel? properties;
  Future<PageModel<PropertiesModel>?> getPropertiesApi() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.getProperties, onSuccess: (response) {
            log(response.toString());

            properties = PropertiesModel.fromJson(response.data);
            apiCallStatus.value = ApiCallStatus.success;

            update();

            return true;
          }, onError: (error) {
            ApiException apiException = error;

            if (apiException.statusCode == 404) {
              apiCallStatus.value = ApiCallStatus.empty;
            } else {
              apiCallStatus.value = ApiCallStatus.error;
            }

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
  }
}
