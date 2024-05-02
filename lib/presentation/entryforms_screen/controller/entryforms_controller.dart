import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
import '../../../core/utils/constants.dart';
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
class EntryFormsController extends GetxController {
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnControllerUseLess = RoundedLoadingButtonController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController fathersController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController colonyController = TextEditingController();

  TextEditingController spousefullNameController = TextEditingController();
  TextEditingController spousefathersController = TextEditingController();
  TextEditingController spousecnicController = TextEditingController();
  TextEditingController spousemobileController = TextEditingController();
  TextEditingController spousehouseController = TextEditingController();
  TextEditingController spouseroadController = TextEditingController();
  TextEditingController spousestreetController = TextEditingController();
  TextEditingController spouseblockController = TextEditingController();
  TextEditingController spousecolonyController = TextEditingController();

  TextEditingController childfullNameController = TextEditingController();
  TextEditingController childfathersController = TextEditingController();
  TextEditingController childcnicController = TextEditingController();
  TextEditingController childmobileController = TextEditingController();
  TextEditingController childhouseController = TextEditingController();
  TextEditingController childroadController = TextEditingController();
  TextEditingController childstreetController = TextEditingController();
  TextEditingController childblockController = TextEditingController();
  TextEditingController childcolonyController = TextEditingController();

  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();
  final GlobalKey<PagedViewState> pageKey = GlobalKey();
  RxList<DealsModel> categories = <DealsModel>[].obs;

  final ImagePicker picker = ImagePicker();

//owner
  File? ownerImage;
  File? ownerCnicFront;
  File? ownerCnicBack;

  File? spouseImage;
  File? spouseCnicFront;
  File? spouseCnicBack;

  File? childImage;
  File? childCnicFront;
  File? childCnicBack;

  List<Street> streets = [];
  List<Plots> plots = [];

  List<Street> spousestreets = [];
  List<Plots> spouseplots = [];

  List<Street> childstreets = [];
  List<Plots> childplots = [];

  int? selectedValue;
  Street? streetSelectedValue;
  Plots? plotstSelectedValue;

  int? spouseselectedValue;
  Street? spousestreetSelectedValue;
  Plots? spouseplotstSelectedValue;

  int? childselectedValue;
  Street? childstreetSelectedValue;
  Plots? childplotstSelectedValue;
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
          await BaseClient.get(
              headers: {'Authorization': "Bearer $token"},
              Constants.getPlotByStreetUrl + id.toString(), onSuccess: (response) {
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

  Future<File?> imagePicker() async {
    final result = await picker.pickImage(source: ImageSource.gallery);

    if (result != null) {
      update();
      return File(result.path);
    }

    update();
    return null;
  }

  Map<String, dynamic> EntryFormData = {};
  GlobalKey<FormState> spouseEntryFormKey = GlobalKey();
  int spouseDataIndex = 0;

  Future<void> spouseEntryFormAPi(context) async {
    final formState = spouseEntryFormKey.currentState;
    if (formState!.validate()) {
      Utils.check().then((value) async {
        Map<String, dynamic> data = {};

        data = {
          'spouse_name': spousefullNameController.text,
          "spouse_father_name": spousefathersController.text,
          'spouse_cnic': spousecnicController.text,
          'spouse_phone': spousemobileController.text,
          'spouse_house': spousehouseController.text,
          'spouse_road': spouseroadController.text,
          'spouse_street': spousestreetController.text,
          'spouse_block': spouseselectedValue ?? 0,
          "spouse_po": "",
          "spouse_city": "",
          "spouse_province": "",
          'spouse_village': spousecolonyController.text,
        };
        data.forEach((key, value) {
          EntryFormData["$key[$spouseDataIndex]"] = value;
        });
        if (spouseImage != null) {
          String filePath1 = spouseImage?.path ?? '';
          if (filePath1.isNotEmpty) {
            EntryFormData['spouse_image[$spouseDataIndex]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }

        if (spouseCnicFront != null) {
          String filePath1 = spouseCnicFront?.path ?? '';
          if (filePath1.isNotEmpty) {
            EntryFormData['spouse_cnic_front[$spouseDataIndex]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }
        if (spouseCnicBack != null) {
          String filePath1 = spouseCnicBack?.path ?? '';
          if (filePath1.isNotEmpty) {
            EntryFormData['spouse_cnic_back[$spouseDataIndex]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }

        Utils.showToast(
          "Spouse ${spouseDataIndex + 1} Added Successfully",
          false,
        );

        spouseDataIndex = spouseDataIndex + 1;
        update();

        clearSpouseForm();
      });
    } else {
      print("Form validation failed");
    }
  }

  clearSpouseForm() {
    spousefullNameController.clear();
    spousefathersController.clear();
    spousecnicController.clear();
    spousemobileController.clear();
    spousehouseController.clear();
    spouseroadController.clear();
    spousestreetController.clear();
    spouseblockController.clear();
    spousecolonyController.clear();
    spouseselectedValue = null;
    spousestreetSelectedValue = null;
    spouseplotstSelectedValue = null;
    spouseCnicFront = null;
    spouseCnicBack = null;
    spouseImage = null;
  }

  GlobalKey<FormState> childEntryFormKey = GlobalKey();

  int childDataIndex = 0;

  Future<void> childEntryFormAPi(context) async {
    final formState = childEntryFormKey.currentState;
    if (childImage == null) {
      Utils.showToast(
        "Please select image of child",
        true,
      );
    } else if (childCnicFront == null) {
      Utils.showToast(
        "Please select image of child CNIC front side",
        true,
      );
    } else if (childCnicBack == null) {
      Utils.showToast(
        "Please select image of child CNIC back side",
        true,
      );
    } else if (formState!.validate()) {
      Utils.check().then((value) async {
        Map<String, dynamic> data = {};

        data = {
          'child_name': childfullNameController.text,
          "child_father_name": childfathersController.text,
          'child_cnic': childcnicController.text,
          'child_phone': childmobileController.text,
          'child_house': childhouseController.text,
          'child_road': childroadController.text,
          'child_street': childstreetController.text,
          'child_block': childselectedValue ?? 0,
          "child_po": "",
          "child_city": "",
          "child_province": "",
          'child_village': childcolonyController.text,
        };
        data.forEach((key, value) {
          EntryFormData["$key[$childDataIndex]"] = value;
        });
        if (childImage != null) {
          String filePath1 = childImage?.path ?? '';
          if (filePath1.isNotEmpty) {
            EntryFormData['child_image[$childDataIndex]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }

        if (childCnicFront != null) {
          String filePath1 = childCnicFront?.path ?? '';
          if (filePath1.isNotEmpty) {
            EntryFormData['child_cnic_front[$childDataIndex]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }
        if (childCnicBack != null) {
          String filePath1 = childCnicBack?.path ?? '';
          if (filePath1.isNotEmpty) {
            EntryFormData['child_cnic_back[$childDataIndex]'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }

        Utils.showToast(
          "child ${childDataIndex + 1} Added Successfully",
          false,
        );
        childDataIndex = childDataIndex + 1;

        clearchildForm();
        update();
      });
    } else {
      print("Form validation failed");
    }
  }

  clearchildForm() {
    childfullNameController.clear();
    childfathersController.clear();
    childcnicController.clear();
    childmobileController.clear();
    childhouseController.clear();
    childroadController.clear();
    childstreetController.clear();
    childblockController.clear();
    childcolonyController.clear();
    childselectedValue = null;
    childstreetSelectedValue = null;
    childplotstSelectedValue = null;
    childCnicFront = null;
    childCnicBack = null;
    childImage = null;
  }

  GlobalKey<FormState> EntryCardFormKey = GlobalKey();

  Future<void> SubmitEntryFormApi(context) async {
    final formState = EntryCardFormKey.currentState;
    if (spouseDataIndex == 0) {
      Utils.showToast(
        "Add Spouse",
        true,
      );
    } else if (childDataIndex == 0) {
      Utils.showToast(
        "Add Child",
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
        Map<String, dynamic> ownerInfoData = {
          'name': fullNameController.text,
          "father_name": fathersController.text,
          'cnic': cnicController.text,
          'phone': mobileController.text,
          'house_no': plotstSelectedValue?.id ?? 0,
          'road': roadController.text,
          'street': streetSelectedValue?.id ?? 0,
          'block': selectedValue ?? 0,
          'residential_area': colonyController.text,
          "date": DateTime.now().format("yyyy-MM-dd").toString()
        };
        EntryFormData.addAll(ownerInfoData);

        if (ownerImage != null) {
          String filePath1 = ownerImage?.path ?? '';
          if (filePath1.isNotEmpty) {
            EntryFormData['image'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }

        if (ownerCnicFront != null) {
          String filePath1 = ownerCnicFront?.path ?? '';
          if (filePath1.isNotEmpty) {
            EntryFormData['cnic_image_front'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }
        if (ownerCnicBack != null) {
          String filePath1 = ownerCnicBack?.path ?? '';
          if (filePath1.isNotEmpty) {
            EntryFormData['cnic_image_back'] = await _dio.MultipartFile.fromFile(
              filePath1,
              filename: filePath1.split('/').last,
              contentType: _http.MediaType.parse('image/jpeg'),
            );
          }
        }
        log(EntryFormData.toString(), name: "EntryFormData");
        if (value) {
          btnController.start();
          _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
            var dio = _dio.Dio();
            try {
              var response = await dio.request(
                'https://anchorageislamabad.com/api/entry-card',
                options: _dio.Options(
                  method: 'POST',
                  contentType: "multipart",
                  headers: {
                    'Authorization': "Bearer $token",
                  },
                ),
                data: _dio.FormData.fromMap(
                  EntryFormData,
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
                log(response.data['message'].toString(), name: "eeror api");
                Utils.showToast(
                  response.data['message'],
                  false,
                );
                log(response.statusMessage.toString());
              }
            } on _dio.DioException catch (error) {
              // dio error (api reach the server but not performed successfully
              // no response
              log(error.response?.data["message"].toString() ?? "", name: "error api");
              btnController.stop();
              Utils.showToast(
                error.response?.data["message"].toString() ?? error.error.toString(),
                true,
              );

              if (error.response == null) {
                var exception = ApiException(
                  url: 'https://anchorageislamabad.com/api/entry-card',
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

  @override
  void onInit() {
    super.onInit();
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
