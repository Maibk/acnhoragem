// import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart' as _http;
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/model_classes/deal_model.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/api_exceptions.dart';
import '../../../data/services/base_client.dart';
import '../../../localization/strings_enum.dart';
import '../../../widgets/custom_snackbar.dart';

class PayBillController extends GetxController {
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();


  RxList<DealsModel> categories = <DealsModel>[].obs;
  GlobalKey<FormState> formKey = new GlobalKey();

  final ImagePicker picker = ImagePicker();

  Future<File?> imagePicker() async {
    final result = await picker.pickImage(source: ImageSource.gallery);

    if (result != null) {
      update();
      return File(result.path);
    }

    update();
    return null;
  }

  File? billPhoto;

  Future<void> payBill(context, id) async {
    Utils.check().then((value) async {
      Map<String, dynamic> data = {};

      data = {
        'id': id,
      };
      if (billPhoto != null) {
        String filePath1 = billPhoto?.path ?? '';
        if (filePath1.isNotEmpty) {
          data['paymentreceipt'] = await _dio.MultipartFile.fromFile(
            filePath1,
            filename: filePath1.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
        }
      }

      if (value) {
        btnController.start();
        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          var dio = _dio.Dio();
          try {
            var response = await dio.request(
              'https://anchorageislamabad.com/api/bills/pay',
              options: _dio.Options(
                method: 'POST',
                headers: {
                  'Authorization': "Bearer $token",
                },
              ),
              data: _dio.FormData.fromMap(data),
            );
            if (response.statusCode == 200) {
              Utils.showToast(
                response.data['message'],
                false,
              );
              btnController.stop();
              log(json.encode(response.data));

              Get.offNamed(AppRoutes.billsPage);
            } else {
              btnController.stop();

              Utils.showToast(
                response.data['message'],
                false,
              );
              log(response.statusMessage.toString());
            }
          } on _dio.DioException catch (error) {
            // dio error (api reach the server but not performed successfully
            // no response
            if (error.response == null) {
              var exception = ApiException(
                url: 'https://anchorageislamabad.com/api/owner-application',
                message: error.message!,
              );
              return BaseClient.handleApiError(exception);
            }
          }
        });
      } else {
        CustomSnackBar.showCustomErrorToast(
          message: Strings.noInternetConnection,
        );
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
  }
}
