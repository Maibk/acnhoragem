import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:anchorageislamabad/presentation/bills_screen/models/bills_model.dart';
import 'package:anchorageislamabad/presentation/complaints_screen/models/complaints_model.dart';
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

import '../../myprofile_screen/models/profile_model.dart';

/// A controller class for the DiscoverScreen.
///
/// This class manages the state of the DiscoverScreen, including the
/// current discoverModelObj
///
class HomeController extends GetxController {
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.loading.obs;
  Rx<ApiCallStatus> billsStatus = ApiCallStatus.loading.obs;
  Rx<ApiCallStatus> complaintsStatus = ApiCallStatus.loading.obs;

  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();

  RxList<DealsModel> categories = <DealsModel>[].obs;

  ProfileModel? profileModel;
  Future<ProfileModel?> getProfile() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.getProfileUrl, onSuccess: (response) {
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

  Bills? bills;
  Future<Bills?> getbills() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        billsStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.billsUrl, onSuccess: (response) {
            log(response.toString());

            bills = Bills.fromJson(response.data);
            if (bills?.data?.isEmpty ?? false) {
              billsStatus.value = ApiCallStatus.empty;
              update();
            } else {
              billsStatus.value = ApiCallStatus.success;
              update();
            }

            return true;
          }, onError: (error) {
            ApiException apiException = error;

            print(apiException.message);

            BaseClient.handleApiError(error);

            billsStatus.value = ApiCallStatus.error;

            return false;
          });
        });
      } else {
        isInternetAvailable.value = false;
      }
    });
    return null;
  }

  Complaints? complaints;
  Future<Complaints?> getComplaints() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        complaintsStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.complaintUrl, onSuccess: (response) {
            log(response.toString(), name: "Complaints data");

            complaints = Complaints.fromJson(response.data);
            complaintsStatus.value = ApiCallStatus.success;

            update();

            return true;
          }, onError: (error) {
            ApiException apiException = error;
            print(apiException.message);
            if (apiException.statusCode == 404) {
              complaintsStatus.value = ApiCallStatus.empty;
              update();
            } else {
              BaseClient.handleApiError(error, showtoast: false);
              complaintsStatus.value = ApiCallStatus.error;
              return false;
            }
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
    getProfile();
    getbills();
    getComplaints();
  }
}
