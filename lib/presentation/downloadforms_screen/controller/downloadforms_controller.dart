import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:anchorageislamabad/presentation/downloadforms_screen/models/downloable_ro_forms.dart';
import 'package:anchorageislamabad/presentation/downloadforms_screen/models/downloadable_ad_form.dart';
import 'package:anchorageislamabad/presentation/downloadforms_screen/models/downloadble_amc_forms.dart';
import 'package:anchorageislamabad/presentation/downloadforms_screen/models/downloadble_pec_forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/model_classes/deal_model.dart';
import '../../../core/model_classes/login_model.dart';
import '../../../core/model_classes/page_model.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/api_exceptions.dart';
import '../../../data/services/base_client.dart';
import '../../../widgets/paginations/paged_view.dart';
import '../models/downloadble_bcd_forms.dart';

/// A controller class for the DiscoverScreen.
///
/// This class manages the state of the DiscoverScreen, including the
/// current discoverModelObj
///
class DownloadFormsController extends GetxController {
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();
  final GlobalKey<PagedViewState> pageKey = GlobalKey();
  RxList<DealsModel> categories = <DealsModel>[].obs;

  // LoginModel? userDetails;
  DownloadableAdForms? adFroms;

  Future<DownloadableAdForms?> getDownloadableAdForms() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(Constants.ad, onSuccess: (response) {
            log(response.toString());

            adFroms = DownloadableAdForms.fromJson(response.data);

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

  DownloadableBcdForms? bcdForms;
  Future<DownloadableBcdForms?> getDownloadableBcdForms() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(Constants.bcd, onSuccess: (response) {
            log(response.toString());

            bcdForms = DownloadableBcdForms.fromJson(response.data);

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

  DownloadableRoForms? roForms;
  Future<DownloadableRoForms?> getDownloadableRoForms() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(Constants.ro, onSuccess: (response) {
            log(response.toString());

            roForms = DownloadableRoForms.fromJson(response.data);

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



 DownloadablePecForms? pecForms;
  Future<DownloadablePecForms?> getDownloadablePecForms() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(Constants.pec, onSuccess: (response) {
            log(response.toString());

            pecForms = DownloadablePecForms.fromJson(response.data);

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


 DownloadableAmcForms? amcForms;
  Future<DownloadableAmcForms?> getDownloadableAmcForms() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(Constants.amc, onSuccess: (response) {
            log(response.toString());

            amcForms = DownloadableAmcForms.fromJson(response.data);

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

  @override
  void onInit() {
    super.onInit();
    getDownloadableBcdForms();
    getDownloadableAdForms();
    getDownloadableRoForms();
    getDownloadablePecForms();
    getDownloadableAmcForms();
  }
}
