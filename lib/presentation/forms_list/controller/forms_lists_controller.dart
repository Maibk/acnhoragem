import 'dart:developer';

import 'package:anchorageislamabad/Shared_prefrences/app_prefrences.dart';
import 'package:anchorageislamabad/core/utils/constants.dart';
import 'package:anchorageislamabad/core/utils/utils.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/data/services/api_exceptions.dart';
import 'package:anchorageislamabad/data/services/base_client.dart';
import 'package:anchorageislamabad/presentation/forms_list/models/all_forms_list_model.dart';
import 'package:get/get.dart';

class FormsListsController extends GetxController {
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  RxBool isInternetAvailable = true.obs;
  AppPreferences _appPreferences = AppPreferences();

  AllFormsListModel formsListModel = AllFormsListModel();

  Future<void> getAllFormsList(String cardName) async {
    String url = cardName == "Entry Form"
        ? Constants.entryCardUrl
        : cardName == "Servant Form"
            ? Constants.servantFormUrl
            : cardName == "Owner Form"
                ? Constants.ownerFormUrl
                : Constants.tenantFormUrl;

    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;
        apiCallStatus.value = ApiCallStatus.loading;
        update();

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, url, onSuccess: (response) {
            if (response.statusCode == 200) {
              formsListModel = AllFormsListModel.fromJson(response.data);
              apiCallStatus.value = ApiCallStatus.success;
              update();
              return true;
            }
          }, onError: (error) {
            ApiException apiException = error;
            print(apiException.message);
            BaseClient.handleApiError(error);
            apiCallStatus.value = ApiCallStatus.error;
            update();

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
