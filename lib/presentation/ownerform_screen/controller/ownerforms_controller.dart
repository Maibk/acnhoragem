import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/localization/strings_enum.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart' as _http;
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/api_exceptions.dart';
import '../../../data/services/base_client.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_snackbar.dart';

/// A controller class for the DiscoverScreen.
///
/// This class manages the state of the DiscoverScreen, including the
/// current discoverModelObj
///
class OwnerFornsScreenController extends GetxController {
  File? allotmentletter;
  File? buildingplan;
  File? certificate;
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

  String privatearms = "";
  String alottmentletter = "";
  String completionCertificate = "";
  String constructionStatus = "";
  String hasVehicle = "";

  int? selectedValue;
  List<Street> streets = [];
  List<Plots> plots = [];
  Street? streetSelectedValue;
  Plots? plotstSelectedValue;

  String plotPlaceHolder = "Plots";
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

  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  final RoundedLoadingButtonController uselessbtnController = RoundedLoadingButtonController();
  List<String> eTag = [];

  //owners controllers
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
  TextEditingController privateLicenseController = TextEditingController();
  TextEditingController privateArmsController = TextEditingController();
  TextEditingController armQuantityController = TextEditingController();
  TextEditingController privateBoreController = TextEditingController();
  //vichicles controller

  TextEditingController vehicleStatusController = TextEditingController();

  List<TextEditingController> vehicleTypeControllers = [];
  List<TextEditingController> vehicleRegisterNoControllers = [];
  List<TextEditingController> vehicleColorControllers = [];
  List<TextEditingController> vehicleStikerControllers = [];
  // TextEditingController vehicleEngineNoController = TextEditingController();
  // TextEditingController vehicleEtagController = TextEditingController();
  RxBool isInternetAvailable = true.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  GlobalKey<FormState> formKey = GlobalKey();

  Map<String, dynamic> ownerFormdata = {};

  GlobalKey<FormState> vehicleFormKey = GlobalKey();
  int vehicleDataIndex = 0;

  Future<void> addvehicle(contex, index) async {
    final formState = vehicleFormKey.currentState;

    if (formState!.validate()) {
      Utils.check().then((value) async {
        addvehicleControllers();
        ownerFormdata['vehicle_type[$index]'] = vehicleTypeControllers[index].text;
        ownerFormdata['registration[$index]'] = vehicleRegisterNoControllers[index].text;
        ownerFormdata['color[$index]'] = vehicleColorControllers[index].text;
        ownerFormdata['sticker_no[$index]'] = vehicleStikerControllers[index].text;
        ownerFormdata['etag[$index]'] = eTag[index].toString();
        Utils.showToast(
          "Vehicle ${vehicleDataIndex + 1} Added Successfully",
          false,
        );
        vehicleDataIndex = vehicleDataIndex + 1;

        update();
      });
    }
  }

  addvehicleControllers() {
    vehicleTypeControllers.add(TextEditingController());
    vehicleRegisterNoControllers.add(TextEditingController());
    vehicleColorControllers.add(TextEditingController());
    vehicleStikerControllers.add(TextEditingController());
    eTag.add("");
  }

  Future<void> ownerFormApi(context) async {
    final formState = formKey.currentState;
    if (formState!.validate()) {
      if (hasVehicle == "Yes") {
        if (vehicleFormKey.currentState!.validate()) {
          Utils.check().then((value) async {
            Map<String, dynamic> data = {
              'name': fullNameController.text,
              'cnic': cnicController.text,
              'phone': telephoneController.text,
              'nationality': natinalityController.text,
              'occupation': occupationController.text,
              'present_address': presentAddController.text,
              'permanent_address': permanantAddController.text,
              'block_commercial': selectedValue ?? 0,
              'street_no': streetSelectedValue?.id ?? 0,
              'house_no': plotstSelectedValue?.id ?? 0,
              'size_of_house_plot': sizeHouseAddController.text,
              'allotment_letter': alottmentletter,
              'completion_certificate': completionCertificate,
              'construction_status': constructionStatus,
              'private_arm': privatearms == "Yes" ? "Yes" : "No",
              'vehicle_status': hasVehicle,
              'license_no': privatearms == "Yes" ? privateLicenseController.text : "No",
              'arm_quantity': privatearms == "Yes" ? privateArmsController.text : "No",
              'bore_type': privatearms == "Yes" ? privateBoreController.text : "No",
              'ammunition_quantity': privatearms == "Yes" ? armQuantityController.text : "No",
              'status': '0'
            };

            ownerFormdata.addAll(data);

            if (alottmentletter == "Yes") {
              if (allotmentletter != null) {
                String filePath1 = allotmentletter?.path ?? '';
                if (filePath1.isNotEmpty) {
                  ownerFormdata['copy_allotment_letter'] = await _dio.MultipartFile.fromFile(
                    filePath1,
                    filename: filePath1.split('/').last,
                    contentType: _http.MediaType.parse('image/jpeg'),
                  );
                }
              }
            }

            if (buildingplan != null) {
              String filePath1 = buildingplan?.path ?? '';
              if (filePath1.isNotEmpty) {
                ownerFormdata['copy_approval_building_plan'] = await _dio.MultipartFile.fromFile(
                  filePath1,
                  filename: filePath1.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                );
              }
            }

            if (completionCertificate == "Yes") {
              if (certificate != null) {
                String filePath1 = certificate?.path ?? '';
                if (filePath1.isNotEmpty) {
                  ownerFormdata['copy_completion_certificate'] = await _dio.MultipartFile.fromFile(
                    filePath1,
                    filename: filePath1.split('/').last,
                    contentType: _http.MediaType.parse('image/jpeg'),
                  );
                }
              }
            }
            if (value) {
              btnController.start();
              _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
                var dio = _dio.Dio();
                try {
                  var response = await dio.request(
                    'https://anchorageislamabad.com/api/owner-application',
                    options: _dio.Options(
                      method: 'POST',
                      headers: {
                        'Authorization': "Bearer $token",
                      },
                    ),
                    data: _dio.FormData.fromMap(ownerFormdata),
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
                  btnController.stop();
                  // dio error (api reach the server but not performed successfully
                  // no response
                  if (error.response == null) {
                    var exception = ApiException(
                      url: 'https://anchorageislamabad.com/api/owner-application',
                      message: error.message!,
                    );
                    return BaseClient.handleApiError(exception);
                  }

                  if (error.response?.statusCode == 500) {
                    btnController.stop();
                    Utils.showToast(
                      "Internal Server Error",
                      true,
                    );
                  }
                }
              });
            } else {
              btnController.stop();
              CustomSnackBar.showCustomErrorToast(
                message: Strings.noInternetConnection,
              );
            }
          });
        }
      } else {
        Utils.check().then((value) async {
          Map<String, dynamic> data = {
            'name': fullNameController.text,
            'cnic': cnicController.text,
            'phone': telephoneController.text,
            'nationality': natinalityController.text,
            'occupation': occupationController.text,
            'present_address': presentAddController.text,
            'permanent_address': permanantAddController.text,
            'block_commercial': selectedValue ?? 0,
            'street_no': streetSelectedValue?.id ?? 0,
            'house_no': plotstSelectedValue?.id ?? 0,
            'size_of_house_plot': sizeHouseAddController.text,
            'allotment_letter': alottmentletter,
            'completion_certificate': completionCertificate,
            'construction_status': constructionStatus,
            'private_arm': privatearms == "Yes" ? "Yes" : "No",
            'vehicle_status': hasVehicle,
            'license_no': privatearms == "Yes" ? privateLicenseController.text : "No",
            'arm_quantity': privatearms == "Yes" ? privateArmsController.text : "No",
            'bore_type': privatearms == "Yes" ? privateBoreController.text : "No",
            'ammunition_quantity': privatearms == "Yes" ? armQuantityController.text : "No",
            'status': '0'
          };

          ownerFormdata.addAll(data);

          if (alottmentletter == "Yes") {
            if (allotmentletter != null) {
              String filePath1 = allotmentletter?.path ?? '';
              if (filePath1.isNotEmpty) {
                ownerFormdata['copy_allotment_letter'] = await _dio.MultipartFile.fromFile(
                  filePath1,
                  filename: filePath1.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                );
              }
            }
          }

          if (buildingplan != null) {
            String filePath1 = buildingplan?.path ?? '';
            if (filePath1.isNotEmpty) {
              ownerFormdata['copy_approval_building_plan'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          if (completionCertificate == "Yes") {
            if (certificate != null) {
              String filePath1 = certificate?.path ?? '';
              if (filePath1.isNotEmpty) {
                ownerFormdata['copy_completion_certificate'] = await _dio.MultipartFile.fromFile(
                  filePath1,
                  filename: filePath1.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                );
              }
            }
          }
          if (value) {
            btnController.start();
            _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
              var dio = _dio.Dio();
              try {
                var response = await dio.request(
                  'https://anchorageislamabad.com/api/owner-application',
                  options: _dio.Options(
                    method: 'POST',
                    headers: {
                      'Authorization': "Bearer $token",
                    },
                  ),
                  data: _dio.FormData.fromMap(ownerFormdata),
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
                btnController.stop();
                // dio error (api reach the server but not performed successfully
                // no response
                if (error.response == null) {
                  var exception = ApiException(
                    url: 'https://anchorageislamabad.com/api/owner-application',
                    message: error.message!,
                  );
                  return BaseClient.handleApiError(exception);
                }

                if (error.response?.statusCode == 500) {
                  btnController.stop();
                  Utils.showToast(
                    "Internal Server Error",
                    true,
                  );
                }
              }
            });
          } else {
            btnController.stop();
            CustomSnackBar.showCustomErrorToast(
              message: Strings.noInternetConnection,
            );
          }
        });
      }
    } else {
      btnController.stop();
      Utils.showToast(
        "Please fill all the required fields",
        true,
      );
      log("Form validation failed");
    }
  }

  getStreetByBlock(id) async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(
              // headers: {'Authorization': "Bearer 15|7zbPqSX0mng6isF9L3iU3v33V6eaoGvEMkE2K7Fg"},
              headers: {'Authorization': "Bearer $token"},
              Constants.getStreetByBlockUrl + id.toString(), onSuccess: (response) {
            update();

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
            apiCallStatus = ApiCallStatus.error;
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

        apiCallStatus = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(
              headers: {'Authorization': "Bearer $token"},
              Constants.getPlotByStreetUrl + id.toString(), onSuccess: (response) {
            update();
            plots.clear;
            for (var element in response.data['data']) {
              plots.add(
                  Plots(id: element["id"] ?? 0, title: element["plot_no"] ?? "", sq_yards: element["sq_yards"] ?? ""));
            }
            plots;

            log(response.data['data'].toString());

            update();

            return true;
          }, onError: (error) {
            ApiException apiException = error;
            print(apiException.message);
            BaseClient.handleApiError(error);
            apiCallStatus = ApiCallStatus.error;
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

  updateEtag(value) {
    eTag = value;
    update();
  }

  updateConstructionStatus(value) {
    constructionStatus = value;
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

  @override
  void onInit() {
    super.onInit();
    addvehicleControllers();
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
  String? sq_yards;

  Plots({required this.id, required this.title, required this.sq_yards});
}
