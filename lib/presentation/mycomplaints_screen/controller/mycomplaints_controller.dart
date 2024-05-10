import 'dart:async';
import 'dart:developer';

import 'package:anchorageislamabad/presentation/complaints_screen/models/complaints_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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
class MyComplaintsController extends GetxController {
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  bool isNewComplaint = false;

  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();

  RxList<DealsModel> categories = <DealsModel>[].obs;

  Complaints? complaints;
  Future<Complaints?> getComplaints() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(
              // headers: {'Authorization': "Bearer 15|7zbPqSX0mng6isF9L3iU3v33V6eaoGvEMkE2K7Fg"},
              headers: {'Authorization': "Bearer $token"},
              Constants.complaintUrl, onSuccess: (response) {
            log(response.toString());

            complaints = Complaints.fromJson(response.data);

            update();

            log(complaints!.data!.first.description!);

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
    getComplaints();
  }
}
