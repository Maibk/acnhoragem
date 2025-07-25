// import 'dart:async';
import 'dart:async';
import 'dart:developer';

import 'package:anchorageislamabad/presentation/complaints_screen/models/complaints_model.dart';
import 'package:anchorageislamabad/presentation/mycomplaints_screen/models/complain_messages.dart';
import 'package:anchorageislamabad/presentation/mycomplaints_screen/models/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/model_classes/deal_model.dart';
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
class ViewComplaintController extends GetxController {
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  String complaintType = '';

  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();

  RxList<DealsModel> categories = <DealsModel>[].obs;
  GlobalKey<FormState> formKey = new GlobalKey();

  bool isExpanded = false;

  expand() {
    isExpanded = true;
    update();
  }

  ViewComplaintModel? viewComplaintModel;

  ComplainMessages? complainMessages;

  Future<ViewComplaintModel?> getViewComplain(id) async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(
              // headers: {'Authorization': "Bearer 15|7zbPqSX0mng6isF9L3iU3v33V6eaoGvEMkE2K7Fg"},
              headers: {'Authorization': "Bearer $token"},
              Constants.viewComplainUrl + id.toString(), onSuccess: (response) {
            log(response.toString());
            viewComplaintModel = ViewComplaintModel.fromJson(response.data);
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

  Future<ComplainMessages?> getMessagesOnComplain(id) async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(
              // headers: {'Authorization': "Bearer 15|7zbPqSX0mng6isF9L3iU3v33V6eaoGvEMkE2K7Fg"},
              headers: {'Authorization': "Bearer $token"},
              Constants.viewComplainUrl + id.toString(), onSuccess: (response) {
            isExpanded = false;
            update();
            log(response.toString());
            complainMessages = ComplainMessages.fromJson(response.data);
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

  ComplaintTypes? complaintTypes;

  Future<Complaints?> getComplainTypes() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;
        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.complaintTypeUrl, onSuccess: (response) {
            log(response.toString());
            complaintTypes = ComplaintTypes.fromJson(response.data);
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

}
