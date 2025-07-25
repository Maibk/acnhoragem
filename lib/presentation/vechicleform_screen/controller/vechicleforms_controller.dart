import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/core/utils/constants.dart';
import 'package:anchorageislamabad/core/utils/image_gallery.dart';
import 'package:anchorageislamabad/localization/strings_enum.dart';
import 'package:anchorageislamabad/presentation/vechicleform_screen/models/Vehicle_form_model.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:anchorageislamabad/widgets/custom_snackbar.dart';
import 'package:anchorageislamabad/widgets/loader_widget.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:flutter/material.dart';
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

class VechicleController extends GetxController {
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  final RoundedLoadingButtonController editbtnController = RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnControllerUseless = RoundedLoadingButtonController();
  RxBool isLoading = false.obs;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController fathersController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController rankController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController servisController = TextEditingController();
  TextEditingController officeController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController colonyController = TextEditingController();
  TextEditingController cellNoController = TextEditingController();
  TextEditingController ptclController = TextEditingController();

  List<TextEditingController> vehicleNoControllers = [];
  List<TextEditingController> makeControllers = [];
  List<TextEditingController> modelControllers = [];
  List<TextEditingController> colorControllers = [];
  List<TextEditingController> engineNoControllers = [];
  List<TextEditingController> chassisControllers = [];

  List<TextEditingController> userfullNameControllers = [];
  List<TextEditingController> userCnicControllers = [];
  List<TextEditingController> userMobileControllers = [];

  List<File> userDrivingLicenseFrontSideImages = [];
  List<File> userDrivingLicenseBackSideImages = [];
  List<File> userCnicFrontSideImages = [];
  List<File> userCnicBacktSideImages = [];

  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();

  VehicleFormDataModel vehicleFormDataModel = VehicleFormDataModel();

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

  Rx<ApiCallStatus> formsLoadingStatus = ApiCallStatus.success.obs;

  List<Street> servantstreets = [];
  List<Plots> servantplots = [];

  final ImageGalleryClass imageGalleryClass = ImageGalleryClass();
  Future<File>? imageModal(context) async {
    XFile? file;
    imageGalleryClass.imageGalleryBottomSheet(
      context: context,
      onCameraTap: () async {
        // file = await imageGalleryClass.getImage(ImageSource.camera);
        update();
        Get.back();
      },
      onGalleryTap: () async {
        // file = await imageGalleryClass.getImage(ImageSource.gallery);
        update();
        Get.back();
      },
    );
    if (file != null) {
      return File(file!.path);
    }
    return File("");
  }

  oninit() {
    super.onInit();
    userDrivingLicenseFrontSideImages.clear();
    userCnicFrontSideImages.clear();
    userCnicBacktSideImages.clear();
    userDrivingLicenseBackSideImages.clear();
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
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.getPlotByStreetUrl + id.toString(), onSuccess: (response) {
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

  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;

      dateController.text = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
    }
    update();
  }

  void setSelectedBlock(String blockTitle) {
    var matchingBlock = block.firstWhere(
      (item) => item['title'] == blockTitle,
      orElse: () => {},
    );
    if (matchingBlock.isNotEmpty) {
      selectedValue = matchingBlock['id'];
    } else {
      selectedValue = null; // Handle cases where blockTitle is not found
    }
  }

  getEntryFormsDetails(id) {
    userDrivingLicenseFrontSideImages.clear();
    userDrivingLicenseBackSideImages.clear();
    userCnicFrontSideImages.clear();
    userCnicBacktSideImages.clear();
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;
        formsLoadingStatus.value = ApiCallStatus.loading;
        update();
        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.vehicleFormUrl + id.toString(), onSuccess: (response) {
            vehicleFormDataModel = VehicleFormDataModel.fromJson(response.data);
            fullNameController.text = vehicleFormDataModel.data?.name ?? "";
            fathersController.text = vehicleFormDataModel.data?.fatherName ?? "";
            cnicController.text = vehicleFormDataModel.data?.cnic ?? "";
            cellNoController.text = vehicleFormDataModel.data?.cellNo ?? "";
            ptclController.text = vehicleFormDataModel.data?.ptclNo ?? "";
            selectedValue = vehicleFormDataModel.data?.block_id ?? 0;

            if (vehicleFormDataModel.data?.category.toString() == "civilian") {
              setServiceCategory(1);
            } else {
              setServiceCategory(2);
            }

            dateController.text = vehicleFormDataModel.data?.date ?? "";
            setSelectedBlock(vehicleFormDataModel.data?.block.toString() ?? "");
            streetSelectedValue = Street(id: vehicleFormDataModel.data?.street_id ?? 0, title: vehicleFormDataModel.data?.roadStreet ?? "");
            plotstSelectedValue = Plots(id: vehicleFormDataModel.data?.house_id ?? 0, title: vehicleFormDataModel.data?.houseNo ?? "");
            roadController.text = vehicleFormDataModel.data?.roadStreet ?? "";
            // colonyController.text = vehicleFormDataModel.data?.roadStreet ?? "";

            rankController.text = vehicleFormDataModel.data?.rank ?? "";
            servisController.text = vehicleFormDataModel.data?.serviceNo ?? "";
            officeController.text = vehicleFormDataModel.data?.officeDepartment ?? "";

            updateNocStatus(vehicleFormDataModel.data?.noc ?? "");

            if (vehicleFormDataModel.data?.residentialStatus == "Civilian") {
              setselectedResidential(1);
            } else if (vehicleFormDataModel.data?.residentialStatus == "Tenant") {
              setselectedResidential(2);
            } else {
              setselectedResidential(3);
            }

            for (var element in vehicleFormDataModel.data!.vehicleDetail!) {
              vehicleNoControllers.add(TextEditingController(text: element.vehicleNo));
              makeControllers.add(TextEditingController(text: element.vehicleMake));
              modelControllers.add(TextEditingController(text: element.vehicleModel));
              colorControllers.add(TextEditingController(text: element.vehicleColor));
              engineNoControllers.add(TextEditingController(text: element.vehicleEngine));
              chassisControllers.add(TextEditingController(text: element.vehicleChassis));
              addVehicleFormKey.add(GlobalKey());
            }

            for (var element in vehicleFormDataModel.data!.vehicleUserDetail!) {
              userfullNameControllers.add(TextEditingController(text: element.userName));
              userCnicControllers.add(TextEditingController(text: element.userNic));
              userMobileControllers.add(TextEditingController(text: element.userPhone));
              userDrivingLicenseFrontSideImages.add(File(element.userLicenseFront!));
              userDrivingLicenseBackSideImages.add(File(element.userLicenseBack!));
              userCnicFrontSideImages.add(File(element.userCnicFront!));
              userCnicBacktSideImages.add(File(element.userCnicBack!));
              addUserInfoFormKey.add(GlobalKey());
            }

            formsLoadingStatus.value = ApiCallStatus.success;

            update();

            return true;
          }, onError: (error) {
            ApiException apiException = error;
            print(apiException.message);
            BaseClient.handleApiError(error);
            formsLoadingStatus.value = ApiCallStatus.error;
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
    // userDetails = LoginModel.fromJson(userMap);
  }

  void loadApis() {
    getProfileData();
  }

  List<GlobalKey<FormState>> addVehicleFormKey = [GlobalKey<FormState>()];

  List<GlobalKey<FormState>> addUserInfoFormKey = [GlobalKey<FormState>()];

  GlobalKey<FormState> sticketProformaFormKey = GlobalKey();

  Map<String, dynamic> vehicalData = {};
  int userInfoDataIndex = 0;

  int vehicleDataIndex = 0;

  addVehicle(index) async {
    final formState = addVehicleFormKey[index].currentState;

    if (formState!.validate()) {
      addVehicleControllers();
      vehicalData['vehicle_no[$index]'] = vehicleNoControllers[index].text;
      vehicalData["vehicle_make[$index]"] = makeControllers[index].text;
      vehicalData['vehicle_model[$index]'] = modelControllers[index].text;

      vehicalData['vehicle_color[$index]'] = colorControllers[index].text;
      vehicalData['vehicle_engine[$index]'] = engineNoControllers[index].text;

      vehicalData['vehicle_chassis[$index]'] = chassisControllers[index].text;

      Utils.showToast(
        "Vehicle ${vehicleDataIndex + 1} Added Successfully",
        false,
      );
      vehicleDataIndex = vehicleDataIndex + 1;
      update();
    }
  }

  addUserInfo(index) async {
    if (userDrivingLicenseFrontSideImages.any((element) => element.path == "")) {
      Utils.showToast(
        "Please select image of Driving License Front Side",
        true,
      );
    } else if (userDrivingLicenseBackSideImages.any((element) => element.path == "")) {
      Utils.showToast(
        "Please select image of Driving License Back Side",
        true,
      );
    } else if (userCnicFrontSideImages.any((element) => element.path == "")) {
      Utils.showToast(
        "Please select image of CNIC front side",
        true,
      );
    } else if (userCnicBacktSideImages.any((element) => element.path == "")) {
      Utils.showToast(
        "Please select image of CNIC back side",
        true,
      );
    } else {
      final formState = addUserInfoFormKey[index].currentState;
      if (formState!.validate()) {
        addUserControllers();
        vehicalData['user_name[$index]'] = userfullNameControllers[index].text;
        vehicalData["user_nic[$index]"] = userCnicControllers[index].text;
        vehicalData['user_phone[$index]'] = userMobileControllers[index].text;

        for (var element in userDrivingLicenseFrontSideImages) {
          String filePath1 = element.path;
          if (filePath1.isNotEmpty) {
            vehicalData['user_cnic_front[$index]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }

        for (var element in userDrivingLicenseBackSideImages) {
          String filePath1 = element.path;
          if (filePath1.isNotEmpty) {
            vehicalData['user_cnic_back[$index]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }

        for (var element in userCnicFrontSideImages) {
          String filePath1 = element.path;
          if (filePath1.isNotEmpty) {
            vehicalData['user_license_front[$index]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }

        for (var element in userCnicBacktSideImages) {
          String filePath1 = element.path;
          if (filePath1.isNotEmpty) {
            vehicalData['user_license_back[$index]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }

        Utils.showToast(
          "User Info ${userInfoDataIndex + 1} Added Successfully",
          false,
        );
        userInfoDataIndex = userInfoDataIndex + 1;
        update();
      }
    }
  }

  Future editAddUserInfo() async {
    for (var i = 0; i < vehicleFormDataModel.data!.vehicleUserDetail!.length; i++) {
      vehicalData['user_name[$i]'] = vehicleFormDataModel.data!.vehicleUserDetail![i].userNameController.text;
      vehicalData["user_nic[$i]"] = vehicleFormDataModel.data!.vehicleUserDetail![i].userNicController.text;
      vehicalData['user_phone[$i]'] = vehicleFormDataModel.data!.vehicleUserDetail![i].userPhoneController.text;
    }

    final userDetails = vehicleFormDataModel.data!.vehicleUserDetail!;

    await prepareMultipartList(
      imageList: userDrivingLicenseBackSideImages,
      userDetails: userDetails,
      vehicalData: vehicalData,
      keyPrefix: 'user_cnic_back',
      getUrlFromModel: (user) => user.userCnicBack ?? "",
    );

    await prepareMultipartList(
      imageList: userCnicFrontSideImages,
      userDetails: userDetails,
      vehicalData: vehicalData,
      keyPrefix: 'user_license_front',
      getUrlFromModel: (user) => user.userLicenseFront ?? "",
    );

    await prepareMultipartList(
      imageList: userCnicBacktSideImages,
      userDetails: userDetails,
      vehicalData: vehicalData,
      keyPrefix: 'user_license_back',
      getUrlFromModel: (user) => user.userLicenseBack ?? "",
    );

    await prepareMultipartList(
      imageList: userDrivingLicenseFrontSideImages,
      userDetails: userDetails,
      vehicalData: vehicalData,
      keyPrefix: 'user_cnic_front',
      getUrlFromModel: (user) => user.userLicenseFront ?? "",
    );
  }

  Future<void> prepareMultipartList({
    required List<File> imageList,
    required List<VehicleUserDetail> userDetails,
    required Map<String, dynamic> vehicalData,
    required String keyPrefix,
    required String Function(VehicleUserDetail) getUrlFromModel,
  }) async {
    if (imageList.isNotEmpty) {
      for (var i = 0; i < imageList.length; i++) {
        final path = imageList[i].path;

        if (path.startsWith('http')) {
          vehicalData['$keyPrefix[$i]'] = await BaseClient.getMultipartFileFromUrl(path);
        } else {
          vehicalData['$keyPrefix[$i]'] = await _dio.MultipartFile.fromFile(
            path,
            filename: path.split('/').last,
            contentType: _http.MediaType.parse('image/jpeg'),
          );
        }
      }
    } else {
      for (var i = 0; i < userDetails.length; i++) {
        final url = getUrlFromModel(userDetails[i]);
        vehicalData['$keyPrefix[$i]'] = await BaseClient.getMultipartFileFromUrl(url);
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
            "date": dateController.text,
            'rank': rankController.text.isEmpty ? " " : rankController.text,
            'service_no': servisController.text.isEmpty ? " " : servisController.text,
            'cnic': cnicController.text,
            'office_department': officeController.text,
            'phone': cellNoController.text,
            'house_no': plotstSelectedValue?.id ?? 0,
            'road_street': streetSelectedValue?.id ?? 0,
            'block': selectedValue ?? 0,
            'cell_no': cellNoController.text,
            'ptcl_no': ptclController.text,
            'noc': selectedResidential == 2 ? nocSubmitted : "Not a tenant",
            "residential_status": selectedResidential == 1
                ? "Civilian"
                : selectedResidential == 2
                    ? "Tenant"
                    : "Visitor / Non-Residential",
            // 'residential_area': colonyController.text,
          };

          for (var i = 0; i < vehicleNoControllers.length; i++) {
            vehicalData['vehicle_no[$i]'] = vehicleNoControllers[i].text;
            vehicalData["vehicle_make[$i]"] = makeControllers[i].text;
            vehicalData['vehicle_model[$i]'] = modelControllers[i].text;
            vehicalData['vehicle_color[$i]'] = colorControllers[i].text;
            vehicalData['vehicle_engine[$i]'] = engineNoControllers[i].text;
            vehicalData['vehicle_chassis[$i]'] = chassisControllers[i].text;
          }
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
            log(vehicalData.toString());
            formsLoader(context);
            isLoading.value = true;
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
                  Navigator.pop(context);
                  isLoading.value = false;

                  log(json.encode(response.data));

                  Get.offAllNamed(AppRoutes.homePage);
                } else if (response.statusCode == 500) {
                  Utils.showToast(
                    "Internal Server Error",
                    false,
                  );
                  Navigator.pop(context);

                  Get.offAllNamed(AppRoutes.homePage);
                } else {
                  isLoading.value = false;
                  Navigator.pop(context);

                  Utils.showToast(
                    response.data['message'],
                    false,
                  );
                  log(response.statusMessage.toString());
                }
              } on _dio.DioException catch (error) {
                isLoading.value = false;
                Navigator.pop(context);

                Utils.showToast(
                  error.response?.toString() ?? error.error.toString(),
                  true,
                );
                if (error.response == null) {
                  var exception = ApiException(
                    url: 'https://anchorageislamabad.com/api/servant-card',
                    message: error.message!,
                  );
                  return BaseClient.handleApiError(exception);
                }

                if (error.response?.statusCode == 500) {
                  Navigator.pop(context);

                  isLoading.value = false;

                  Utils.showToast(
                    "Internal Server Error",
                    true,
                  );
                }
              }
            });
          } else {
            CustomSnackBar.showCustomErrorToast(
              message: Strings.noInternetConnection,
            );
            isLoading.value = false;
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

  Future<void> editSubmitVehicle(context, int id, vehicleKeyIndex, userKeyIndex) async {
    if (addVehicleFormKey[vehicleKeyIndex].currentState!.validate() && addUserInfoFormKey[userKeyIndex].currentState!.validate()) {
      if (userDrivingLicenseFrontSideImages.any((e) => e.path == "") ||
          userDrivingLicenseBackSideImages.any((e) => e.path == "") ||
          userCnicFrontSideImages.any((e) => e.path == "") ||
          userCnicBacktSideImages.any((e) => e.path == "")) {
        Utils.showToast("Please select all images of user ", true);
      } else {
        formsLoader(context);
        update();
        Utils.check().then((value) async {
          await editAddUserInfo();
          Map<String, dynamic> ownerInfoData = {
            'id': id,
            'name': fullNameController.text,
            "father_name": fathersController.text,
            "service_category": selectedServiceCategory == 1 ? "civilian" : "service personnel",
            "date": dateController.text,
            'rank': rankController.text.isEmpty ? " " : rankController.text,
            'service_no': servisController.text.isEmpty ? " " : servisController.text,
            'cnic': cnicController.text,
            'office_department': officeController.text,
            'phone': cellNoController.text,
            'house_no': plotstSelectedValue?.id ?? 0,
            'road_street': streetSelectedValue?.id ?? 0,
            'block': selectedValue ?? 0,
            'cell_no': cellNoController.text,
            'ptcl_no': ptclController.text,
            'noc': selectedResidential == 2 ? nocSubmitted : "Not a tenant",
            "residential_status": selectedResidential == 1
                ? "Civilian"
                : selectedResidential == 2
                    ? "Tenant"
                    : "Visitor / Non-Residential",
            // 'residential_area': colonyController.text,
          };
          vehicalData.addAll(ownerInfoData);

          for (var i = 0; i < vehicleFormDataModel.data!.vehicleDetail!.length; i++) {
            vehicalData['vehicle_no[$i]'] = vehicleFormDataModel.data!.vehicleDetail![i].vehicleNoController.text;
            vehicalData["vehicle_make[$i]"] = vehicleFormDataModel.data!.vehicleDetail![i].vehicleMakeController.text;
            vehicalData['vehicle_model[$i]'] = vehicleFormDataModel.data!.vehicleDetail![i].vehicleModelController.text;
            vehicalData['vehicle_color[$i]'] = vehicleFormDataModel.data!.vehicleDetail![i].vehicleColorController.text;
            vehicalData['vehicle_engine[$i]'] = vehicleFormDataModel.data!.vehicleDetail![i].vehicleEngineController.text;
            vehicalData['vehicle_chassis[$i]'] = vehicleFormDataModel.data!.vehicleDetail![i].vehicleChassisController.text;
          }

          if (underTakingLicenseFrontSideImage == null) {
            vehicalData['driving_license_front'] = await BaseClient.getMultipartFileFromUrl(vehicleFormDataModel.data?.drivingLicenseFront ?? "");
          } else {
            String filePath1 = underTakingLicenseFrontSideImage?.path ?? '';
            if (filePath1.isNotEmpty) {
              vehicalData['driving_license_front'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          if (underTakingLicenseBackSideImage == null) {
            vehicalData['driving_license_back'] = await BaseClient.getMultipartFileFromUrl(vehicleFormDataModel.data?.drivingLicenseBack ?? "");
          } else {
            String filePath1 = underTakingLicenseBackSideImage?.path ?? '';
            if (filePath1.isNotEmpty) {
              vehicalData['driving_license_back'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          if (underTakingCnicFrontSideImage == null) {
            vehicalData['cnic_image_front'] = await BaseClient.getMultipartFileFromUrl(vehicleFormDataModel.data?.cnicImageFront ?? "");
          } else {
            String filePath1 = underTakingCnicFrontSideImage?.path ?? '';
            if (filePath1.isNotEmpty) {
              vehicalData['cnic_image_front'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          if (underTakingCnicBackSideImage == null) {
            vehicalData['cnic_image_back'] = await BaseClient.getMultipartFileFromUrl(vehicleFormDataModel.data?.cnicImageBack ?? "");
          } else {
            String filePath1 = underTakingCnicBackSideImage?.path ?? '';
            if (filePath1.isNotEmpty) {
              vehicalData['cnic_image_back'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          if (underTakingVehicalRegistrationImage == null) {
            vehicalData['registration_image'] = await BaseClient.getMultipartFileFromUrl(vehicleFormDataModel.data?.registrationImage ?? "");
          } else {
            String filePath1 = underTakingVehicalRegistrationImage?.path ?? '';
            if (filePath1.isNotEmpty) {
              vehicalData['registration_image'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          if (underTakingOwnerImage == null) {
            vehicalData['owner_image'] = await BaseClient.getMultipartFileFromUrl(vehicleFormDataModel.data?.ownerImage ?? "");
          } else {
            String filePath1 = underTakingOwnerImage?.path ?? '';
            if (filePath1.isNotEmpty) {
              vehicalData['owner_image'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          if (underTakingAllotmentLetterImage == null) {
            vehicalData['allotment_letter_image'] = await BaseClient.getMultipartFileFromUrl(vehicleFormDataModel.data?.allotmentLetterImage ?? "");
          } else {
            String filePath1 = underTakingAllotmentLetterImage?.path ?? '';
            if (filePath1.isNotEmpty) {
              vehicalData['allotment_letter_image'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          if (underTakingMaintenanceBillImage == null) {
            vehicalData['maintenance_bill_image'] = await BaseClient.getMultipartFileFromUrl(vehicleFormDataModel.data?.maintenanceBillImage ?? "");
          } else {
            String filePath1 = underTakingMaintenanceBillImage?.path ?? '';
            if (filePath1.isNotEmpty) {
              vehicalData['maintenance_bill_image'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          if (underTakingOldStickerImage == null) {
            vehicalData['old_sticker_image'] = await BaseClient.getMultipartFileFromUrl(vehicleFormDataModel.data?.oldStickerImage ?? "");
          } else {
            String filePath1 = underTakingOldStickerImage?.path ?? '';
            if (filePath1.isNotEmpty) {
              vehicalData['old_sticker_image'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          if (value) {
            log(vehicalData.toString());

            _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
              var dio = _dio.Dio();
              try {
                var response = await dio.request(
                  'https://anchorageislamabad.com/api/vehicle/update',
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
                  Navigator.pop(context);

                  log(json.encode(response.data));

                  Get.offAllNamed(AppRoutes.homePage);
                } else if (response.statusCode == 500) {
                  Utils.showToast(
                    "Internal Server Error",
                    false,
                  );
                  Get.offAllNamed(AppRoutes.homePage);
                } else {
                  Navigator.pop(context);

                  Utils.showToast(
                    response.data['message'],
                    false,
                  );
                  log(response.statusMessage.toString());
                }
              } on _dio.DioException catch (error) {
                Navigator.pop(context);
                if (error.response?.statusCode == 404) {
                  Navigator.pop(context);
                  Utils.showToast(
                    error.response?.data.toString() ?? '',
                    true,
                  );
                } else {
                  Utils.showToast(
                    error.response?.toString() ?? error.error.toString(),
                    true,
                  );
                }
                if (error.response == null) {
                  var exception = ApiException(
                    url: 'https://anchorageislamabad.com/api/servant-card',
                    message: error.message!,
                  );
                  return BaseClient.handleApiError(exception);
                }

                if (error.response?.statusCode == 500) {
                  Navigator.pop(context);

                  Utils.showToast(
                    "Internal Server Error",
                    true,
                  );
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
    } else {
      Utils.showToast("Some validations failed.", true);
    }
  }

  String nocSubmitted = "";

  updateNocStatus(value) {
    nocSubmitted = value;
    update();
  }

  addVehicleControllers() {
    vehicleNoControllers.add(TextEditingController());
    makeControllers.add(TextEditingController());
    modelControllers.add(TextEditingController());
    colorControllers.add(TextEditingController());
    engineNoControllers.add(TextEditingController());
    chassisControllers.add(TextEditingController());
    update();
  }

  addUserControllers() {
    userfullNameControllers.add(TextEditingController());
    userCnicControllers.add(TextEditingController());
    userMobileControllers.add(TextEditingController());
    userDrivingLicenseFrontSideImages.add(File(''));
    userDrivingLicenseBackSideImages.add(File(''));
    userCnicFrontSideImages.add(File(''));
    userCnicBacktSideImages.add(File(''));
    update();
  }
}

class Street {
  int? id;
  String? title;

  Street({this.id, required this.title});
}

class Plots {
  int? id;
  String? title;

  Plots({this.id, required this.title});
}
