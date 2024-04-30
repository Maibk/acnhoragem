import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/localization/strings_enum.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http_parser/http_parser.dart' as _http;

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/model_classes/deal_model.dart';
import '../../../core/model_classes/login_model.dart';
import '../../../core/model_classes/page_model.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/api_exceptions.dart';
import '../../../data/services/base_client.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/paginations/paged_view.dart';

/// A controller class for the DiscoverScreen.
///
/// This class manages the state of the DiscoverScreen, including the
/// current discoverModelObj
///
class TenantFornsScreenController extends GetxController {
  File? ownerCnic;
  File? tenantCnic;
  File? estateAgentCnic;
  File? tenantPhoto;
  File? rentAgreement;
  File? policeForm;
  File? certificate;
  int? selectedValue;

  String alottmentletter = "";
  String completionCertificate = "";

  String plotPlaceHolder = "Plots";
  // Initially set to ID 1
  List<Map<String, dynamic>> block = [
    {"id": 1, "title": "A"},
    {"id": 2, "title": "AH"},
    {"id": 3, "title": "B"},
    {"id": 4, "title": "C"},
    {"id": 5, "title": "D"},
    {"id": 6, "title": "D EXT"},
    {"id": 7, "title": "E"},
    {"id": 8, "title": "F"},
    {"id": 9, "title": "G"},
    {"id": 10, "title": "H"},
    {"id": 11, "title": "J"},
    {"id": 12, "title": "K"},
    {"id": 13, "title": "L"},
    {"id": 14, "title": "M"},
    {"id": 15, "title": "NS-1"},
    {"id": 16, "title": "NS-2"},
    {"id": 17, "title": "NS-5"},
    {"id": 18, "title": "NS-3"},
  ];

  List<Street> streets = [];
  List<Plots> plots = [];
  Street? streetSelectedValue;
  Plots? plotstSelectedValue;
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

  String? privatearms = "";
  String? hasVehicle = "";
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController fathersController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController natinalityController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController presentAddController = TextEditingController();
  TextEditingController permanantAddController = TextEditingController();
  TextEditingController allotmentAddController = TextEditingController();
  TextEditingController completionAddController = TextEditingController();
  TextEditingController sizeHouseAddController = TextEditingController();
  TextEditingController custructionStatusAddController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController rankController = TextEditingController();
  TextEditingController servisController = TextEditingController();
  TextEditingController officeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController colonyController = TextEditingController();
  TextEditingController cellNoController = TextEditingController();
  TextEditingController ptclController = TextEditingController();
  //private arms controller
  TextEditingController? privateLicenseController;
  TextEditingController? privateArmsController;
  TextEditingController? privateAmmunitionController;
  TextEditingController armQuantityController = TextEditingController();
  TextEditingController? privateBoreController;
  //vichicles controller
  TextEditingController? vehicleTypeController;
  TextEditingController? vehicleRegisterNoController;
  TextEditingController? vehicleColorController;
  TextEditingController? vehicleStikerController;
  TextEditingController? vehicleEngineNoController;
  TextEditingController? vehicleEtagController;
  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();
  final GlobalKey<PagedViewState> pageKey = GlobalKey();
  RxList<DealsModel> categories = <DealsModel>[].obs;

  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> tenantFormApi(context) async {
    final formState = formKey.currentState;
    if (formState!.validate()) {
      Utils.check().then((value) async {
        Map<String, dynamic> data = {};

        data = {
          'tenant_name': fullNameController.text,
          'name': fullNameController.text,
          'phone': telephoneController.text,
          'cnic': cnicController.text,
          'father_name': fathersController.text,
          'tenant_cnic': cnicController.text,
          'tenant_phone': telephoneController.text,
          'tenant_nationality': natinalityController.text,
          'tenant_occupation': occupationController.text,
          // 'tenant_permanent_address': presentAddController.text,
          'tenant_permanent_address': presentAddController.text,
          'tenant_block_commercial': selectedValue,
          'tenant_street_no': streetSelectedValue?.id ?? 0,
          'tenant_house_no': plotstSelectedValue?.id ?? 0,
          'tenant_size_of_house_plot': sizeHouseAddController.text,

          'present_address': presentAddController.text,
          'permanent_address': presentAddController.text,
          'size_of_house_plot': sizeHouseAddController.text,
          'allotment_letter': alottmentletter,
          'completion_certificate': completionCertificate,
          'construction_status': custructionStatusAddController.text,
          'private_arm': privateArmsController?.text ?? "No",
          'license_no': privateLicenseController?.text ?? "No",
          'arm_quantity': privateArmsController?.text ?? "No",
          'bore_type': privateBoreController?.text ?? "No",
          'ammunition_quantity': privateAmmunitionController?.text ?? "No",
          'vehicle_status': hasVehicle,
          'vehicle_type[]': vehicleTypeController?.text ?? "No",
          'registration[]': vehicleRegisterNoController?.text ?? "No",
          'color[]': vehicleColorController?.text ?? "No",
          'sticker_no[]': vehicleStikerController?.text ?? "No",
          'etag[]': vehicleEtagController?.text ?? "No",
          'submit_date': DateTime.now(),
          'status': '0'
        };
        if (ownerCnic != null) {
          String filePath1 = ownerCnic?.path ?? '';
          if (filePath1.isNotEmpty) {
            data['owner_cnic_image[]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }

        if (tenantCnic != null) {
          String filePath1 = tenantCnic?.path ?? '';
          if (filePath1.isNotEmpty) {
            data['tenant_cnic_image[]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }
        if (estateAgentCnic != null) {
          String filePath1 = estateAgentCnic?.path ?? '';
          if (filePath1.isNotEmpty) {
            data['agent_cnic_image[]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }
        if (tenantPhoto != null) {
          String filePath1 = tenantPhoto?.path ?? '';
          if (filePath1.isNotEmpty) {
            data['tenant_image'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }
        if (rentAgreement != null) {
          String filePath1 = rentAgreement?.path ?? '';
          if (filePath1.isNotEmpty) {
            data['agreement_image'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }
        if (policeForm != null) {
          String filePath1 = policeForm?.path ?? '';
          if (filePath1.isNotEmpty) {
            data['police_registration_image'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }
        if (certificate != null) {
          String filePath1 = estateAgentCnic?.path ?? '';
          if (filePath1.isNotEmpty) {
            data['copy_completion_certificate'] = await _dio.MultipartFile.fromFile(
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
                'https://anchorageislamabad.com/api/tenant-application',
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

                Get.offAllNamed(AppRoutes.homePage);
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
    } else {
      print("Form validation failed");
    }
  }

  getStreetByBlock(id) async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(
              // headers: {'Authorization': "Bearer 15|7zbPqSX0mng6isF9L3iU3v33V6eaoGvEMkE2K7Fg"},
              headers: {'Authorization': "Bearer $token"},
              Constants.getStreetByBlockUrl + id.toString(), onSuccess: (response) {
            update();
            log(response.data['data'].toString(), name: "Street data>>");
            streets.clear();
            for (var element in response.data['data']) {
              streets.add(Street(id: element["id"] ?? 0, title: element["title"] ?? ""));
            }
            streets;

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

  getPlotNoByStreet(id) async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(
              headers: {'Authorization': "Bearer $token"},
              Constants.getPlotByStreetUrl + id.toString(), onSuccess: (response) {
            update();
            plots.clear();
            for (var element in response.data['data']) {
              plots.add(Plots(id: element["id"] ?? 0, title: element["plot_no"] ?? ""));
            }
            plots;
            log(response.data['data'].toString());

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

  updateAllotmentLetter(value) {
    alottmentletter = value;
    update();
  }

  updateCompletionCertificate(value) {
    completionCertificate = value;
    update();
  }

  updatePrivatearms(value) {
    privatearms = value;
    update();
  }

  updateVehicle(value) {
    hasVehicle = value;
    update();
  }
}

class Street {
  int? id;
  String? title;

  Street({required this.id, required this.title});
}

class Plots {
  int? id;
  String? title;

  Plots({required this.id, required this.title});
}
