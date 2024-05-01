import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/core/utils/constants.dart';
import 'package:anchorageislamabad/core/utils/date_time_utils.dart';
import 'package:anchorageislamabad/localization/strings_enum.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:anchorageislamabad/widgets/custom_snackbar.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart' as _http;
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/model_classes/deal_model.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/api_exceptions.dart';
import '../../../data/services/base_client.dart';
import '../../../widgets/paginations/paged_view.dart';

/// A controller class for the DiscoverScreen.
///
/// This class manages the state of the DiscoverScreen, including the
/// current discoverModelObj
///
class VechicleController extends GetxController {
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnControllerUseless = RoundedLoadingButtonController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController fathersController = TextEditingController();
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

  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController engineNoController = TextEditingController();
  TextEditingController chassisController = TextEditingController();
  //user controller
  TextEditingController userfullNameController = TextEditingController();
  TextEditingController userCnicController = TextEditingController();
  TextEditingController userMobileController = TextEditingController();

  File? userDrivingLicenseFrontSideImage;
  File? userDrivingLicenseBackSideImage;
  File? userCnicFrontSideImage;
  File? userCnicBacktSideImage;

  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();
  final GlobalKey<PagedViewState> pageKey = GlobalKey();
  RxList<DealsModel> categories = <DealsModel>[].obs;

  File? underTakingLicenseFrontSideImage;
  File? underTakingLicenseBackSideImage;
  File? underTakingCnicFrontSideImage;
  File? underTakingCnicBackSideImage;

  File? underTakingVehicalRegistrationImage;
  File? underTakingOwnerImage;
  File? underTakingAllotmentLetterImage;
  File? underTakingMaintenanceBillImage;
  File? underTakingOldStickerImage;

  int? selectedValue;
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

  List<Street> streets = [];
  List<Plots> plots = [];

  List<Street> servantstreets = [];
  List<Plots> servantplots = [];
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

  // LoginModel? userDetails;

  Future<dynamic> getProfileData() async {
    await appPreferences.isPreferenceReady;
    var data = await appPreferences.getProfileData();
    Map<String, dynamic> userMap = jsonDecode(data!);
    print('map $userMap');
    // userDetails = LoginModel.fromJson(userMap);
  }

  void loadApis() {
    getProfileData();
    // getDealsCategoriesApi();
  }

  GlobalKey<FormState> addVehicleFormKey = GlobalKey();

  GlobalKey<FormState> addUserInfoFormKey = GlobalKey();
  GlobalKey<FormState> sticketProformaFormKey = GlobalKey();

  // GlobalKey<FormState> addServantFamilyFormKey = GlobalKey();
  // GlobalKey<FormState> addSignatureFormKey = GlobalKey();

  Map<String, dynamic> vehicalData = {};
  int userInfoDataIndex = 0;

  int vehicleDataIndex = 0;
  clearAddUserInfo() {
    userfullNameController.clear();
    userCnicController.clear();
    userMobileController.clear();
    userDrivingLicenseFrontSideImage = null;
    userDrivingLicenseBackSideImage = null;
    userCnicFrontSideImage = null;
    userCnicBacktSideImage = null;
  }

  clearAddVehicle() {
    vehicleNoController.clear();
    makeController.clear();
    modelController.clear();
    colorController.clear();
    engineNoController.clear();
    chassisController.clear();
  }

  addVehicle() async {
    final formState = addVehicleFormKey.currentState;
    if (formState!.validate()) {
      vehicalData['vehicle_no[$vehicleDataIndex]'] = vehicleNoController.text;
      vehicalData["vehicle_make[$vehicleDataIndex]"] = makeController.text;
      vehicalData['vehicle_model[$vehicleDataIndex]'] = modelController.text;

      vehicalData['vehicle_color[$vehicleDataIndex]'] = colorController.text;
      vehicalData['vehicle_engine[$vehicleDataIndex]'] = engineNoController.text;

      vehicalData['vehicle_chassis[$vehicleDataIndex]'] = chassisController.text;

      Utils.showToast(
        "Vehicle ${vehicleDataIndex + 1} Added Successfully",
        false,
      );
      clearAddVehicle();
      vehicleDataIndex = vehicleDataIndex + 1;
      update();
    }
  }

  addUserInfo() async {
    if (userDrivingLicenseFrontSideImage == null) {
      Utils.showToast(
        "Please select image of Driving License Front Side",
        true,
      );
    } else if (userDrivingLicenseBackSideImage == null) {
      Utils.showToast(
        "Please select image of Driving License Back Side",
        true,
      );
    } else if (userCnicFrontSideImage == null) {
      Utils.showToast(
        "Please select image of CNIC front side",
        true,
      );
    } else if (userCnicBacktSideImage == null) {
      Utils.showToast(
        "Please select image of CNIC back side",
        true,
      );
    } else {
      final formState = addUserInfoFormKey.currentState;
      if (formState!.validate()) {
        vehicalData['user_name[$userInfoDataIndex]'] = userfullNameController.text;
        vehicalData["user_nic[$userInfoDataIndex]"] = userCnicController.text;
        vehicalData['user_phone[$userInfoDataIndex]'] = userMobileController.text;

        vehicalData['user_cnic_front[$userInfoDataIndex]'] = await _dio.MultipartFile.fromFile(
          userCnicFrontSideImage!.path,
          filename: userCnicFrontSideImage!.path.split('/').last,
          contentType: _http.MediaType.parse('image/jpeg'),
        );
        vehicalData['user_cnic_back[$userInfoDataIndex]'] = await _dio.MultipartFile.fromFile(
          userCnicBacktSideImage!.path,
          filename: userCnicBacktSideImage!.path.split('/').last,
          contentType: _http.MediaType.parse('image/jpeg'),
        );
        vehicalData['user_license_front[$userInfoDataIndex]'] = await _dio.MultipartFile.fromFile(
          userDrivingLicenseFrontSideImage!.path,
          filename: userDrivingLicenseFrontSideImage!.path.split('/').last,
          contentType: _http.MediaType.parse('image/jpeg'),
        );
        vehicalData['user_license_back[$userInfoDataIndex]'] = await _dio.MultipartFile.fromFile(
          userDrivingLicenseBackSideImage!.path,
          filename: userDrivingLicenseBackSideImage!.path.split('/').last,
          contentType: _http.MediaType.parse('image/jpeg'),
        );

        Utils.showToast(
          "User Info ${userInfoDataIndex + 1} Added Successfully",
          false,
        );
        clearAddUserInfo();
        userInfoDataIndex = userInfoDataIndex + 1;
        update();
      }
    }
  }

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

  int selectedServiceCategory = 0;
  setServiceCategory(int value) {
    selectedServiceCategory = value;
    update();
  }

  int selectedResidential = 0;
  setselectedResidential(int value) {
    selectedResidential = value;
    update();
  }

  Future<void> SubmitVehicle(context) async {
    final formState = sticketProformaFormKey.currentState;
    if (vehicleDataIndex == 0) {
      Utils.showToast(
        "Add Vehicle",
        true,
      );
    } else if (userInfoDataIndex == 0) {
      Utils.showToast(
        "Add Users Infomation",
        true,
      );
    } else if (underTakingLicenseFrontSideImage == null) {
      Utils.showToast(
        "Please select Driving License Front Side Image",
        true,
      );
    } else if (underTakingLicenseBackSideImage == null) {
      Utils.showToast(
        "Please select Driving License Back Side Image",
        true,
      );
    } else if (underTakingCnicFrontSideImage == null) {
      Utils.showToast(
        "Please select clear image of your CNIC front side",
        true,
      );
    } else if (underTakingCnicBackSideImage == null) {
      Utils.showToast(
        "Please select clear image of your CNIC back side",
        true,
      );
    } else if (underTakingVehicalRegistrationImage == null) {
      Utils.showToast(
        "Please select Vehicle Registration Image",
        true,
      );
    } else if (underTakingOwnerImage == null) {
      Utils.showToast(
        "Please select owner image",
        true,
      );
    } else if (underTakingAllotmentLetterImage == null) {
      Utils.showToast(
        "Please select Allotment Letter Image",
        true,
      );
    } else if (underTakingMaintenanceBillImage == null) {
      Utils.showToast(
        "Please select Maintenance Bill Image",
        true,
      );
    } else if (underTakingOldStickerImage == null) {
      Utils.showToast(
        "Please select Old Sticker Imagee",
        true,
      );
    } else if (selectedServiceCategory == 0) {
      Utils.showToast(
        "Please select category",
        true,
      );
    } else if (selectedResidential == 0) {
      Utils.showToast(
        "Please select Residential Status",
        true,
      );
    } else {
      if (formState!.validate()) {
        Utils.check().then((value) async {
          Map<String, dynamic> ownerInfoData = {
            'name': fullNameController.text,
            "father_name": fathersController.text,
            "service_category": selectedServiceCategory == 1 ? "civilian" : "service personnel",
            "date": DateTime.now().format("yyyy-MM-dd"),
            'rank': rankController.text.isEmpty ? " " : rankController.text,
            'service_no': servisController.text.isEmpty ? " " : servisController.text,
            'cnic': cnicController.text,
            'office_department': officeController.text,
            'phone': mobileController.text,
            'house_no': plotstSelectedValue?.id ?? 0,
            'road_street': "No",
            'street': streetSelectedValue?.id ?? 0,
            'block': selectedValue ?? 0,
            'cell_no': cellNoController.text,
            'ptcl_no': ptclController.text,
            'noc': "none",
            "residential_status": selectedResidential == 1
                ? "Civilian"
                : selectedResidential == 2
                    ? "Tenant"
                    : "Visitor / Non-Residential",
            'residential_area': colonyController.text,
          };
          vehicalData.addAll(ownerInfoData);

          vehicalData['driving_license_front'] = await _dio.MultipartFile.fromFile(
            underTakingLicenseFrontSideImage!.path,
            filename: underTakingLicenseFrontSideImage!.path.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
          vehicalData['driving_license_back'] = await _dio.MultipartFile.fromFile(
            underTakingLicenseBackSideImage!.path,
            filename: underTakingLicenseBackSideImage!.path.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );

          vehicalData['cnic_image_front'] = await _dio.MultipartFile.fromFile(
            underTakingCnicFrontSideImage!.path,
            filename: underTakingCnicFrontSideImage!.path.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
          vehicalData['cnic_image_back'] = await _dio.MultipartFile.fromFile(
            underTakingCnicBackSideImage!.path,
            filename: underTakingCnicBackSideImage!.path.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
          vehicalData['registration_image'] = await _dio.MultipartFile.fromFile(
            underTakingVehicalRegistrationImage!.path,
            filename: underTakingVehicalRegistrationImage!.path.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
          vehicalData['owner_image'] = await _dio.MultipartFile.fromFile(
            underTakingOwnerImage!.path,
            filename: underTakingOwnerImage!.path.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
          vehicalData['allotment_letter_image'] = await _dio.MultipartFile.fromFile(
            underTakingAllotmentLetterImage!.path,
            filename: underTakingAllotmentLetterImage!.path.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
          vehicalData['maintenance_bill_image'] = await _dio.MultipartFile.fromFile(
            underTakingMaintenanceBillImage!.path,
            filename: underTakingMaintenanceBillImage!.path.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
          vehicalData['old_sticker_image'] = await _dio.MultipartFile.fromFile(
            underTakingOldStickerImage!.path,
            filename: underTakingOldStickerImage!.path.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );

          if (value) {
            btnController.start();
            _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
              var dio = _dio.Dio();
              try {
                var response = await dio.request(
                  'https://anchorageislamabad.com/api/vehicle',
                  options: _dio.Options(
                    method: 'POST',
                    headers: {
                      'Authorization': "Bearer $token",
                    },
                  ),
                  data: _dio.FormData.fromMap(vehicalData),
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
                log(error.response?.data["message"].toString() ?? "");
                log(error.error.toString(), name: "APi Error");
                log(error.response.toString(), name: "APi Error Response");
                btnController.stop();
                Utils.showToast(
                  error.response?.data["message"].toString() ?? error.error.toString(),
                  true,
                );
                if (error.response == null) {
                  var exception = ApiException(
                    url: 'https://anchorageislamabad.com/api/servant-card',
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
        Utils.showToast(
          "Add Sticker Proforma Detail",
          true,
        );
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProfileData();
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
