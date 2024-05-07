import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/core/utils/constants.dart';
import 'package:anchorageislamabad/core/utils/date_time_utils.dart';
import 'package:anchorageislamabad/localization/strings_enum.dart';
import 'package:anchorageislamabad/presentation/home_screen/controller/home_controller.dart';
import 'package:anchorageislamabad/presentation/login_screen/controller/login_controller.dart';
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
///
///

class ServentFormsController extends GetxController {
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnControllerUseLess = RoundedLoadingButtonController();

  HomeController controller = Get.put(HomeController());

  File? ownerImage;
  File? ownerCnicFront;
  File? ownerCnicBack;

  File? servantImage;
  File? servantCnicFront;
  File? servantCnicBack;
  File? servantFamilyImage;

  List<File> servantImages = [];
  List<File> servantCnicFronts = [];
  List<File> servantCnicBacks = [];
  List<File> servantFamilyImages = [];

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
  //servent controller

  List<TextEditingController> serventfullNameControllers = [];
  List<TextEditingController> serventfathersControllers = [];
  List<TextEditingController> serventcnicControllers = [];
  List<TextEditingController> serventmobileControllers = [];
  List<TextEditingController> serventhouseControllers = [];
  List<TextEditingController> serventroadControllers = [];
  List<TextEditingController> serventstreetControllers = [];
  List<TextEditingController> serventblockControllers = [];
  List<TextEditingController> serventcolonyVillageControllers = [];
  List<TextEditingController> serventpostOfficeControllers = [];
  List<TextEditingController> serventCityControllers = [];
  List<TextEditingController> serventProvinceControllers = [];

  // TextEditingController serventfullNameController = TextEditingController();
  // TextEditingController serventfathersController = TextEditingController();
  // TextEditingController serventcnicController = TextEditingController();
  // TextEditingController serventmobileController = TextEditingController();
  // TextEditingController serventhouseController = TextEditingController();
  // TextEditingController serventroadController = TextEditingController();
  // TextEditingController serventstreetController = TextEditingController();
  // TextEditingController serventblockController = TextEditingController();
  // TextEditingController serventcolonyVillageController = TextEditingController();
  // TextEditingController serventpostOfficeController = TextEditingController();
  // TextEditingController serventCityController = TextEditingController();
  // TextEditingController serventProvinceController = TextEditingController();

  // TextEditingController serventfamfullNameController = TextEditingController();
  // TextEditingController serventfamCnicController = TextEditingController();
  // TextEditingController serventfamMobController = TextEditingController();
  // TextEditingController serventfamoccutionController = TextEditingController();
  // TextEditingController serventfampresentAddController = TextEditingController();

  List<TextEditingController> serventfamfullNameControllers = [];
  List<TextEditingController> serventfamCnicControllers = [];
  List<TextEditingController> serventfamMobControllers = [];
  List<TextEditingController> serventfamoccutionControllers = [];
  List<TextEditingController> serventfampresentAddControllers = [];

  TextEditingController? ownerSignatureController;
  TextEditingController serventdateController = TextEditingController(text: DateTime.now().format("yyyy-MM-dd"));

  //private arms controller
  TextEditingController privateLicenseController = TextEditingController();
  TextEditingController privateArmsController = TextEditingController();
  TextEditingController privateAmmunitionController = TextEditingController();
  TextEditingController privateBoreController = TextEditingController();
  //vichicles controller
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vehicleRegesterNoController = TextEditingController();
  TextEditingController vehicleColorController = TextEditingController();
  TextEditingController vehicleStikerController = TextEditingController();
  TextEditingController vehicleEngineNoController = TextEditingController();
  TextEditingController vehicleEtagController = TextEditingController();
  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();
  final GlobalKey<PagedViewState> pageKey = GlobalKey();
  RxList<DealsModel> categories = <DealsModel>[].obs;
  int? servantselectedValue;
  Street? servantstreetSelectedValue;
  Plots? servantplotstSelectedValue;

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
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.getPlotByStreetUrl + id.toString(), onSuccess: (response) {
            update();
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

  Future<dynamic> getProfileData() async {
    await appPreferences.isPreferenceReady;
    var data = await appPreferences.getProfileData();
    Map<String, dynamic> userMap = jsonDecode(data!);
    print('map $userMap');
  }

  void loadApis() {
    getProfileData();
    // getDealsCategoriesApi();
  }

  GlobalKey<FormState> ownerFormKeyy = GlobalKey();

  GlobalKey<FormState> addServantFormKey = GlobalKey();
  GlobalKey<FormState> addServantFamilyFormKey = GlobalKey();

  Map<String, dynamic> servantData = {};
  int servantDataIndex = 0;
  int servantFamilyDataIndex = 0;

  addServant(index) async {
    ownerSignatureController?.text = fullNameController.text;
    update();
    // if (servantImage == null) {
    //   Utils.showToast(
    //     "Please select image of servant",
    //     true,
    //   );
    // } else if (servantCnicFront == null) {
    //   Utils.showToast(
    //     "Please select image of servant CNIC front side",
    //     true,
    //   );
    // } else if (servantCnicBack == null) {
    //   Utils.showToast(
    //     "Please select image of servant CNIC back side",
    //     true,
    //   );
    // } else {
    final formState = addServantFormKey.currentState;
    if (formState!.validate()) {
      addServantControllers();
      servantData['servant_name[$servantDataIndex]'] = serventfullNameControllers[index].text;
      servantData["servant_father[$servantDataIndex]"] = serventfathersControllers[index].text;
      servantData['servant_cnic[$servantDataIndex]'] = serventcnicControllers[index].text;
      servantData['servant_mobile[$servantDataIndex]'] = serventmobileControllers[index].text;
      servantData['servant_house[$servantDataIndex]'] = serventhouseControllers[index].text;
      servantData['servant_road[$servantDataIndex]'] = serventroadControllers[index].text;
      servantData['servant_street[$servantDataIndex]'] = serventstreetControllers[index].text;
      servantData['servant_village[$servantDataIndex]'] = serventcolonyVillageControllers[index].text;
      servantData['servant_block[$servantDataIndex]'] = servantselectedValue ?? 0;
      servantData['servant_po[$servantDataIndex]'] = serventpostOfficeControllers[index].text;
      servantData['servant_city[$servantDataIndex]'] = serventpostOfficeControllers[index].text;
      servantData['servant_province[$servantDataIndex]'] = serventProvinceControllers[index].text;
      for (var element in servantImages) {
        String filePath1 = element.path;
        if (filePath1.isNotEmpty) {
          servantData['servant_image[$index]'] = await _dio.MultipartFile.fromFile(
            filePath1,
            filename: filePath1.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
        }
      }

      // servantData['servant_image[$servantDataIndex]'] = await _dio.MultipartFile.fromFile(
      //   servantImage!.path,
      //   filename: servantImage!.path.split('/').last,
      //   contentType: _http.MediaType.parse('image/jpeg'),
      // );

      for (var element in servantCnicFronts) {
        String filePath1 = element.path;
        if (filePath1.isNotEmpty) {
          servantData['servant_cnic_front[$index]'] = await _dio.MultipartFile.fromFile(
            filePath1,
            filename: filePath1.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
        }
      }

      // servantData['servant_cnic_front[$servantDataIndex]'] = await _dio.MultipartFile.fromFile(
      //   servantCnicFront!.path,
      //   filename: servantCnicFront!.path.split('/').last,
      //   contentType: _http.MediaType.parse('image/jpeg'),
      // );

      for (var element in servantCnicBacks) {
        String filePath1 = element.path;
        if (filePath1.isNotEmpty) {
          servantData['servant_cnic_back[$index]'] = await _dio.MultipartFile.fromFile(
            filePath1,
            filename: filePath1.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
        }
      }

      // servantData['servant_cnic_back[$servantDataIndex]'] = await _dio.MultipartFile.fromFile(
      //   servantCnicBack!.path,
      //   filename: servantCnicBack!.path.split('/').last,
      //   contentType: _http.MediaType.parse('image/jpeg'),
      // );
      Utils.showToast(
        "Servant Added Successfully",
        false,
      );
      log(servantData.toString());
      // clearServant();
      servantDataIndex = servantDataIndex + 1;
      update();
    }
  }

  // clearServant() {
  //   serventfullNameController.clear();
  //   serventfathersController.clear();
  //   serventcnicController.clear();
  //   serventmobileController.clear();
  //   serventhouseController.clear();
  //   serventroadController.clear();
  //   serventstreetController.clear();
  //   serventblockController.clear();
  //   serventcolonyVillageController.clear();
  //   serventCityController.clear();
  //   serventpostOfficeController.clear();
  //   serventProvinceController.clear();
  //   servantselectedValue = null;
  //   servantplotstSelectedValue = null;
  //   servantstreetSelectedValue = null;
  //   servantCnicBack = null;
  //   servantCnicFront = null;
  //   servantImage = null;
  // }

  addServantFamily(index) async {
    // if (servantFamilyImage == null) {
    //   Utils.showToast(
    //     "Please select image of servant family",
    //     true,
    //   );
    // } else {
    final formState = addServantFamilyFormKey.currentState;
    if (formState!.validate()) {
      addServantFamControllers();
      servantData['family_name[$index]'] = serventfamfullNameControllers[index].text;
      servantData["family_occupation[$index]"] = serventfamoccutionControllers[index].text;
      servantData['family_nic[$index]'] = serventfamCnicControllers[index].text;
      servantData['family_cell[$index]'] = serventfamMobControllers[index].text;
      servantData['family_address[$index]'] = serventfampresentAddControllers[index].text;

      for (var element in servantFamilyImages) {
        String filePath1 = element.path;
        if (filePath1.isNotEmpty) {
          servantData['servant_family_image[$index]'] = await _dio.MultipartFile.fromFile(
            filePath1,
            filename: filePath1.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
        }
        // }

        // servantData['servant_family_image[$servantFamilyDataIndex]'] = await _dio.MultipartFile.fromFile(
        //   servantFamilyImage!.path,
        //   filename: servantFamilyImage!.path.split('/').last,
        //   contentType: _http.MediaType.parse('image/jpeg'),
        // );

        Utils.showToast(
          "Servant Family Added Successfully",
          false,
        );
        // clearServantFamily();
        servantFamilyDataIndex = servantFamilyDataIndex + 1;
        update();
      }
    }
  }

  // clearServantFamily() {
  //   serventfamfullNameController.clear();
  //   serventfamoccutionController.clear();
  //   serventfamCnicController.clear();
  //   serventfamMobController.clear();
  //   serventfampresentAddController.clear();
  //   servantFamilyImage = null;
  // }

  Future<void> submitServantApi(context) async {
    final formState = ownerFormKeyy.currentState;
    if (servantDataIndex == 0) {
      Utils.showToast(
        "Add Servant",
        true,
      );
    } else if (ownerImage == null) {
      Utils.showToast(
        "Please select image of yours",
        true,
      );
    } else if (ownerCnicFront == null) {
      Utils.showToast(
        "Please select image of your CNIC front side",
        true,
      );
    } else if (ownerCnicBack == null) {
      Utils.showToast(
        "Please select image of your CNIC back side",
        true,
      );
    } else if (formState!.validate()) {
      Utils.check().then((value) async {
        // servantData['owner_signature'] = ownerSignatureController.text;
        servantData['date'] = serventdateController.text;

        Map<String, dynamic> ownerInfoData = {
          'name': fullNameController.text,
          "father_name": fathersController.text,
          'cnic': cnicController.text,
          'phone': mobileController.text,
          'house': plotstSelectedValue?.id ?? 0,
          'road': roadController.text,
          'street': streetSelectedValue?.id ?? 0,
          'block': selectedValue ?? 0,
          'residential_area': colonyController.text,
        };
        servantData.addAll(ownerInfoData);
        if (ownerImage != null) {
          String filePath1 = ownerImage?.path ?? '';
          if (filePath1.isNotEmpty) {
            servantData['image'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }

        if (ownerCnicFront != null) {
          String filePath1 = ownerCnicFront?.path ?? '';
          if (filePath1.isNotEmpty) {
            servantData['cnic_image_front'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }
        if (ownerCnicBack != null) {
          String filePath1 = ownerCnicBack?.path ?? '';
          if (filePath1.isNotEmpty) {
            servantData['cnic_image_back'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }

        if (servantImages.isEmpty) {
          Utils.showToast("Please select servant Images", true);
        } else if (servantCnicFronts.isEmpty) {
          Utils.showToast("Please select servant cnic front images", true);
        } else if (servantCnicBacks.isEmpty) {
          Utils.showToast("Please select servant cnic back images", true);
        } else if (servantFamilyImages.isEmpty) {
          Utils.showToast("Please select servant family images", true);
        } else {
          if (value) {
            btnController.start();
            _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
              log(servantData.toString(), name: "servantData");
              var dio = _dio.Dio(_dio.BaseOptions(
                baseUrl: "https://anchorageislamabad.com/api",
                headers: {
                  'Authorization': "Bearer $token",
                },
              ));
              try {
                var response = await dio.post(
                  "/servant-card",
                  data: _dio.FormData.fromMap(servantData),
                  options: _dio.Options(
                    method: 'POST',
                    contentType: 'multipart',
                  ),
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
                    url: "https://anchorageislamabad.com/api/servant-card",
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
        }
      });
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

  addServantControllers() {
    serventfullNameControllers.add(TextEditingController());
    serventfathersControllers.add(TextEditingController());
    serventcnicControllers.add(TextEditingController());
    serventmobileControllers.add(TextEditingController());
    serventhouseControllers.add(TextEditingController());
    serventroadControllers.add(TextEditingController());
    serventstreetControllers.add(TextEditingController());
    serventblockControllers.add(TextEditingController());
    serventcolonyVillageControllers.add(TextEditingController());
    serventpostOfficeControllers.add(TextEditingController());
    serventCityControllers.add(TextEditingController());
    serventProvinceControllers.add(TextEditingController());
    servantImages.add(File(""));
    servantCnicFronts.add(File(""));
    servantCnicBacks.add(File(""));
  }

  addServantFamControllers() {
    serventfamfullNameControllers.add(TextEditingController());
    serventfamCnicControllers.add(TextEditingController());
    serventfamMobControllers.add(TextEditingController());
    serventfamoccutionControllers.add(TextEditingController());
    serventfampresentAddControllers.add(TextEditingController());
    servantFamilyImages.add(File(""));
  }

  @override
  void onInit() {
    super.onInit();
    addServantFamControllers();
    addServantControllers();
  }

  @override
  void onClose() {
    super.onClose();
    serventfamfullNameControllers.clear();
    serventfullNameControllers.clear();
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
