import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/core/utils/date_time_utils.dart';
import 'package:anchorageislamabad/core/utils/image_gallery.dart';
import 'package:anchorageislamabad/localization/strings_enum.dart';
import 'package:anchorageislamabad/presentation/entryforms_screen/models/entry_form_data_model.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:anchorageislamabad/widgets/custom_snackbar.dart';
import 'package:anchorageislamabad/widgets/loader_widget.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart' as _http;
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../Shared_prefrences/app_prefrences.dart';
import '../../../core/model_classes/deal_model.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../data/services/api_call_status.dart';
import '../../../data/services/api_exceptions.dart';
import '../../../data/services/base_client.dart';

class EntryFormsController extends GetxController {
  EntryFormDataModel entryFormDataModel = EntryFormDataModel();

  List<TextEditingController> spousefullNameControllers = [];
  // List<TextEditingController> spousefathersControllers = [];
  List<TextEditingController> spousecnicControllers = [];
  List<TextEditingController> spousemobileControllers = [];
  List<TextEditingController> spousehouseControllers = [];
  List<TextEditingController> spouseroadControllers = [];
  List<TextEditingController> spousestreetControllers = [];
  List<TextEditingController> spouseblockControllers = [];
  List<TextEditingController> spousecolonyControllers = [];
  List<TextEditingController> spouseMohallaControllers = [];
  List<TextEditingController> spouseThanaControllers = [];
  List<TextEditingController> spouseCityControllers = [];
  List<TextEditingController> spouseProvinceControllers = [];

  List<TextEditingController> childfullNameControllers = [];
  // List<TextEditingController> childfathersControllers = [];
  List<TextEditingController> childcnicControllers = [];
  List<TextEditingController> childmobileControllers = [];
  List<TextEditingController> childhouseControllers = [];
  List<TextEditingController> childroadControllers = [];
  List<TextEditingController> childstreetControllers = [];
  List<TextEditingController> childblockControllers = [];
  List<TextEditingController> childcolonyControllers = [];
  List<TextEditingController> childMohallaControllers = [];
  List<TextEditingController> childThanaControllers = [];
  List<TextEditingController> childCityControllers = [];
  List<TextEditingController> childProvinceControllers = [];

  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnControllerUseLess = RoundedLoadingButtonController();
  final RoundedLoadingButtonController submitEdittedFormButtonController = RoundedLoadingButtonController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController fathersController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController colonyController = TextEditingController();

  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  Rx<ApiCallStatus> formsLoadingStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();

  RxList<DealsModel> categories = <DealsModel>[].obs;

  final ImagePicker picker = ImagePicker();
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

//owner
  File? ownerImage;
  File? ownerCnicFront;
  File? ownerCnicBack;

  List<File> spouseImages = [];
  List<File> spouseCnicsfronts = [];
  List<File> spouseCnicBacks = [];

  List<File> childImages = [];
  List<File> childCnicsfronts = [];
  List<File> childCnicBacks = [];

  List<Street> streets = [];
  List<Plots> plots = [];

  List<Street> spousestreets = [];
  List<Plots> spouseplots = [];

  List<Street> childstreets = [];
  List<Plots> childplots = [];

  dynamic selectedValue;
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
    spouseImages.clear();
    spouseCnicsfronts.clear();
    spouseCnicBacks.clear();
    childImages.clear();
    childCnicsfronts.clear();
    childCnicBacks.clear();
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;
        formsLoadingStatus.value = ApiCallStatus.loading;
        update();
        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.entryCardUrl + id.toString(), onSuccess: (response) {
            entryFormDataModel = EntryFormDataModel.fromJson(response.data);
            fullNameController.text = entryFormDataModel.data?.name ?? "";
            fathersController.text = entryFormDataModel.data?.fatherName ?? "";
            cnicController.text = entryFormDataModel.data?.cnic ?? "";
            mobileController.text = entryFormDataModel.data?.phone ?? "";
            setSelectedBlock(entryFormDataModel.data?.block.toString() ?? "");
            streetSelectedValue = Street(id: entryFormDataModel.data?.street_id ?? 0, title: entryFormDataModel.data?.street ?? "");
            plotstSelectedValue = Plots(id: entryFormDataModel.data?.house_id ?? 0, title: entryFormDataModel.data?.houseNo ?? "");

            for (var element in entryFormDataModel.data!.spouseDetail!) {
              spousefullNameControllers.add(TextEditingController(text: element.spouseName));
              spousecnicControllers.add(TextEditingController(text: element.spouseCnic));
              spousemobileControllers.add(TextEditingController(text: element.spousePhone));
              spousehouseControllers.add(TextEditingController(text: element.spouseHouse));
              spouseroadControllers.add(TextEditingController(text: element.spouseRoad));
              spousestreetControllers.add(TextEditingController(text: element.spouseStreet));
              spouseMohallaControllers.add(TextEditingController(text: element.spouseVillage));
              spouseThanaControllers.add(TextEditingController(text: element.spousePo));
              spouseCityControllers.add(TextEditingController(text: element.spouseCity));
              spouseProvinceControllers.add(TextEditingController(text: element.spouseProvince));
              spouseImages.add(File(element.spouseImage!));
              spouseCnicsfronts.add(File(element.spouseCnicFront!));
              spouseCnicBacks.add(File(element.spouseCnicBack!));
              spouseEntryFormKey.add(GlobalKey<FormState>());
            }
            spouseDataIndex = entryFormDataModel.data?.spouseDetail?.length ?? 0;

            for (var element in entryFormDataModel.data!.childDetail!) {
              childfullNameControllers.add(TextEditingController(text: element.childName));
              childcnicControllers.add(TextEditingController(text: element.childCnic));
              childmobileControllers.add(TextEditingController(text: element.childPhone));
              childhouseControllers.add(TextEditingController(text: element.childHouse));
              childroadControllers.add(TextEditingController(text: element.childRoad));
              childstreetControllers.add(TextEditingController(text: element.childStreet));
              childMohallaControllers.add(TextEditingController(text: element.childVillage));
              childThanaControllers.add(TextEditingController(text: element.childPo));
              childCityControllers.add(TextEditingController(text: element.childCity));
              childProvinceControllers.add(TextEditingController(text: element.childProvince));
              childImages.add(File(element.childImage!));
              childCnicsfronts.add(File(element.childCnicFront!));
              childCnicBacks.add(File(element.childCnicBack!));
              childEntryFormKey.add(GlobalKey<FormState>());
            }
            childDataIndex = entryFormDataModel.data?.childDetail?.length ?? 0;
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

  getStreetByBlock(id) async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;
        apiCallStatus.value = ApiCallStatus.loading;
        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.getStreetByBlockUrl + id.toString(), onSuccess: (response) {
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

  List<GlobalKey<FormState>> spouseEntryFormKey = [GlobalKey<FormState>()];
  int spouseDataIndex = 0;

  Future<void> spouseEntryFormAPi(context, index) async {
    final formState = spouseEntryFormKey[index].currentState;
    if (formState!.validate()) {
      if (spouseImages.any((element) => element.path == "") ||
          spouseCnicsfronts.any((element) => element.path == "") ||
          spouseCnicBacks.any((element) => element.path == "")) {
        Utils.showToast("Please select all spouse images", true);
      } else {
        addSpouse();
        Utils.check().then((value) async {
          Map<String, dynamic> data = {};
          data = {
            'spouse_name': spousefullNameControllers[index].text,
            // "spouse_father_name": spousefathersControllers[index].text,
            'spouse_cnic': spousecnicControllers[index].text,
            'spouse_phone': spousemobileControllers[index].text,
            'spouse_house': spousehouseControllers[index].text,
            'spouse_road': spouseroadControllers[index].text,
            'spouse_street': spousestreetControllers[index].text,
            'spouse_block': 0,
            "spouse_po": spouseThanaControllers[index].text,
            "spouse_city": spouseCityControllers[index].text,
            "spouse_province": spouseProvinceControllers[index].text,
            'spouse_village': spouseMohallaControllers[index].text,
          };
          data.forEach((key, value) {
            EntryFormData["$key[$index]"] = value;
          });

          for (var element in spouseImages) {
            String filePath1 = element.path;
            if (filePath1.isNotEmpty) {
              EntryFormData['spouse_image[$index]'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          for (var element in spouseCnicsfronts) {
            String filePath1 = element.path;
            if (filePath1.isNotEmpty) {
              EntryFormData['spouse_cnic_front[$index]'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          for (var element in spouseCnicBacks) {
            String filePath1 = element.path;
            if (filePath1.isNotEmpty) {
              EntryFormData['spouse_cnic_back[$index]'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );

              Utils.showToast(
                "Spouse Added Successfully",
                false,
              );
              spouseDataIndex = spouseDataIndex + 1;
              update();
            }
          }
        });
      }
    } else {
      print("Form validation failed");
    }
  }

  Future<void> spouseEditEntryFormAPi(context) async {
    Map<String, dynamic> data = {};

    for (int i = 0; i < entryFormDataModel.data!.spouseDetail!.length; i++) {
      data.addAll({
        'spouse_name[$i]': entryFormDataModel.data!.spouseDetail![i].spouseNameController.text,
        'spouse_cnic[$i]': entryFormDataModel.data!.spouseDetail![i].spouseCnicController.text,
        'spouse_phone[$i]': entryFormDataModel.data!.spouseDetail![i].spousePhoneController.text,
        'spouse_house[$i]': entryFormDataModel.data!.spouseDetail![i].spouseHouseController.text,
        'spouse_road[$i]': entryFormDataModel.data!.spouseDetail![i].spouseRoadController.text,
        'spouse_street[$i]': entryFormDataModel.data!.spouseDetail![i].spouseStreetController.text,
        'spouse_block[$i]': "0",
        "spouse_po[$i]": entryFormDataModel.data!.spouseDetail![i].spousePoController.text,
        "spouse_city[$i]": entryFormDataModel.data!.spouseDetail![i].spouseCityController.text,
        "spouse_province[$i]": entryFormDataModel.data!.spouseDetail![i].spouseProvinceController.text,
        'spouse_village[$i]': entryFormDataModel.data!.spouseDetail![i].spouseVillageController.text,
      });
    }
    ;

    EntryFormData.addAll(data);

    final userDetails = entryFormDataModel.data!.spouseDetail!;

    await prepareMultipartList(
      imageList: spouseImages,
      userDetails: userDetails,
      vehicalData: EntryFormData,
      keyPrefix: 'spouse_image',
      getUrlFromModel: (user) => user.spouseImage ?? "",
    );

    await prepareMultipartList(
      imageList: spouseCnicsfronts,
      userDetails: userDetails,
      vehicalData: EntryFormData,
      keyPrefix: 'spouse_cnic_front',
      getUrlFromModel: (user) => user.spouseCnicFront ?? "",
    );

    await prepareMultipartList(
      imageList: spouseCnicBacks,
      userDetails: userDetails,
      vehicalData: EntryFormData,
      keyPrefix: 'spouse_cnic_back',
      getUrlFromModel: (user) => user.spouseCnicBack ?? "",
    );
  }

  // GlobalKey<FormState> childEntryFormKey = GlobalKey();
  List<GlobalKey<FormState>> childEntryFormKey = [GlobalKey<FormState>()];

  int childDataIndex = 0;

  Future<void> childEntryFormAPi(context, index) async {
    final formState = childEntryFormKey[index].currentState;

    if (formState!.validate()) {
      if (childImages.any((element) => element.path == "") ||
          childCnicsfronts.any((element) => element.path == "") ||
          childCnicBacks.any((element) => element.path == "")) {
        Utils.showToast("Please Select all child images", true);
      } else {
        addChild();
        Utils.check().then((value) async {
          Map<String, dynamic> data = {};

          data = {
            'child_name': childfullNameControllers[index].text,
            'child_cnic': childcnicControllers[index].text,
            'child_phone': childmobileControllers[index].text,
            'child_house': childhouseControllers[index].text,
            'child_road': childroadControllers[index].text,
            'child_street': childstreetControllers[index].text,
            'child_block': 0,
            "child_po": childThanaControllers[index].text,
            "child_city": childCityControllers[index].text,
            "child_province": childProvinceControllers[index].text,
            'child_village': childMohallaControllers[index].text,
          };
          data.forEach((key, value) {
            EntryFormData["$key[$index]"] = value;
          });

          for (var element in childImages) {
            String filePath1 = element.path;
            if (filePath1.isNotEmpty) {
              EntryFormData['child_image[$index]'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }
          for (var element in childCnicsfronts) {
            String filePath1 = element.path;
            if (filePath1.isNotEmpty) {
              EntryFormData['child_cnic_front[$index]'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          for (var element in childCnicBacks) {
            String filePath1 = element.path;
            if (filePath1.isNotEmpty) {
              EntryFormData['child_cnic_back[$index]'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          Utils.showToast(
            "Child Added Successfully",
            false,
          );
          childDataIndex = childDataIndex + 1;
          update();
        });
      }
    } else {
      print("Form validation failed");
    }
  }

  Future<void> prepareMultipartList({
    required List<File> imageList,
    required List<dynamic> userDetails,
    required Map<String, dynamic> vehicalData,
    required String keyPrefix,
    required String Function(dynamic) getUrlFromModel,
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

  Future<void> childEditEntryFormAPi(
    context,
  ) async {
    Map<String, dynamic> data = {};

    for (int i = 0; i < entryFormDataModel.data!.childDetail!.length; i++) {
      data.addAll({
        'child_name[$i]': entryFormDataModel.data!.childDetail![i].childNameController.text,
        'child_cnic[$i]': entryFormDataModel.data!.childDetail![i].childCnicController.text,
        'child_phone[$i]': entryFormDataModel.data!.childDetail![i].childPhoneController.text,
        'child_house[$i]': entryFormDataModel.data!.childDetail![i].childHouseController.text,
        'child_road[$i]': entryFormDataModel.data!.childDetail![i].childRoadController.text,
        'child_street[$i]': entryFormDataModel.data!.childDetail![i].childStreetController.text,
        'child_block[$i]': "0",
        "child_po[$i]": entryFormDataModel.data!.childDetail![i].childPoController.text,
        "child_city[$i]": entryFormDataModel.data!.childDetail![i].childCityController.text,
        "child_province[$i]": entryFormDataModel.data!.childDetail![i].childProvinceController.text,
        'child_village[$i]': entryFormDataModel.data!.childDetail![i].childVillageController.text,
      });
    }
    ;
    EntryFormData.addAll(data);

    final userDetails = entryFormDataModel.data!.childDetail!;

    await prepareMultipartList(
      imageList: childImages,
      userDetails: userDetails,
      vehicalData: EntryFormData,
      keyPrefix: 'child_image',
      getUrlFromModel: (user) => user.childImage ?? "",
    );

    await prepareMultipartList(
      imageList: childCnicsfronts,
      userDetails: userDetails,
      vehicalData: EntryFormData,
      keyPrefix: 'child_cnic_front',
      getUrlFromModel: (user) => user.childCnicFront ?? "",
    );

    await prepareMultipartList(
      imageList: childCnicBacks,
      userDetails: userDetails,
      vehicalData: EntryFormData,
      keyPrefix: 'child_cnic_back',
      getUrlFromModel: (user) => user.childCnicBack ?? "",
    );
  }

  GlobalKey<FormState> EntryCardFormKey = GlobalKey();

  Future<void> SubmitEntryFormApi(context, childFormIndex, spouseFormIndex) async {
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
    } else if (spouseImages.isEmpty) {
      Utils.showToast("Please select spouse Images", true);
    } else if (spouseCnicsfronts.isEmpty) {
      Utils.showToast("Please select spouse cnic front images", true);
    } else if (spouseCnicBacks.isEmpty) {
      Utils.showToast("Please select spouse cnic back images", true);
    } else if (childImages.isEmpty) {
      Utils.showToast("Please select child images", true);
    } else if (childCnicsfronts.isEmpty) {
      Utils.showToast("Please select child cnic front images", true);
    } else if (childCnicBacks.isEmpty) {
      Utils.showToast("Please select child cnic back images", true);
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
      if (spouseEntryFormKey[spouseFormIndex].currentState!.validate() && childEntryFormKey[childFormIndex].currentState!.validate()) {
        Utils.check().then((value) async {
          Map<String, dynamic> ownerInfoData = {
            'name': fullNameController.text,
            "father_name": fathersController.text,
            'cnic': cnicController.text,
            'phone': mobileController.text,
            'house_no': plotstSelectedValue?.id ?? 0,
            'street': streetSelectedValue?.id ?? 0,
            'block': selectedValue ?? 0,
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
            formsLoader(context);

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
                  Navigator.pop(context);
                  log(json.encode(response.data));

                  Get.offAllNamed(AppRoutes.homePage);
                } else {
                  Navigator.pop(context);

                  log(response.data['message'].toString(), name: "eeror api");
                  Utils.showToast(
                    response.data['message'],
                    false,
                  );
                  log(response.statusMessage.toString());
                }
              } on _dio.DioException catch (error) {
                Navigator.pop(context);

                // dio error (api reach the server but not performed successfully
                // no response

                Utils.showToast(
                  error.response?.data.toString() ?? "Error",
                  true,
                );

                if (error.response == null) {
                  var exception = ApiException(
                    url: 'https://anchorageislamabad.com/api/entry-card',
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
      } else {
        Utils.showToast("Some validations failed.", true);
      }
    } else {
      print("Form validation failed");
    }
  }

  Future<void> SubmitEdittedEntryFormApi(context, id, childFormIndex, spouseFormIndex) async {
    if (childEntryFormKey[childFormIndex].currentState!.validate() && spouseEntryFormKey[spouseFormIndex].currentState!.validate()) {
      if (spouseImages.any((element) => element.path == "") ||
          spouseCnicsfronts.any((element) => element.path == "") ||
          spouseCnicBacks.any((element) => element.path == "")) {
        Utils.showToast("Please select all spouse Images", true);
      } else if (childImages.any((element) => element.path == "") ||
          childCnicsfronts.any((element) => element.path == "") ||
          childCnicBacks.any((element) => element.path == "")) {
        Utils.showToast("Please select all child Images", true);
      } else {
        formsLoader(context);
        Utils.check().then((value) async {
          Map<String, dynamic> ownerInfoData = {
            'name': fullNameController.text,
            "father_name": fathersController.text,
            'cnic': cnicController.text,
            'phone': mobileController.text,
            'house_no': plotstSelectedValue?.id ?? 0,
            'street': streetSelectedValue?.id ?? 0,
            'block': selectedValue ?? 0,
            "date": DateTime.now().format("yyyy-MM-dd").toString(),
            "id": id
          };
          EntryFormData.addAll(ownerInfoData);

          if (ownerImage == null) {
            EntryFormData['image'] = await BaseClient.getMultipartFileFromUrl(entryFormDataModel.data?.image ?? "");
          } else {
            String filePath1 = ownerImage?.path ?? '';
            if (filePath1.isNotEmpty) {
              EntryFormData['image'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }

          if (ownerCnicFront == null) {
            EntryFormData['cnic_image_front'] = await BaseClient.getMultipartFileFromUrl(entryFormDataModel.data?.cnicImageFront ?? "");
          } else {
            String filePath1 = ownerCnicFront?.path ?? '';
            if (filePath1.isNotEmpty) {
              EntryFormData['cnic_image_front'] = await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              );
            }
          }
          if (ownerCnicBack == null) {
            EntryFormData['cnic_image_back'] = await BaseClient.getMultipartFileFromUrl(entryFormDataModel.data?.cnicImageBack ?? "");
          } else {
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

          await childEditEntryFormAPi(context);
          await spouseEditEntryFormAPi(context);

          if (value) {
            log(Constants.entryCardUpdateUrl, name: "URL -----------------------------------");
            log(EntryFormData.toString(), name: "DATA -----------------------------------");
            _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
              var dio = _dio.Dio();
              try {
                var response = await dio.request(
                  Constants.entryCardUpdateUrl,
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
                  Navigator.pop(context);
                  log(json.encode(response.data));

                  Get.offAllNamed(AppRoutes.homePage);
                } else {
                  Navigator.pop(context);

                  log(response.data['message'].toString(), name: "eeror api");
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
                    error.response?.data.toString() ?? "Error",
                    true,
                  );
                  log(error.response?.data.toString().substring(1, 250) ?? "", name: "Entry card ERROOOOOOORRRRRR");
                }

                if (error.response == null) {
                  Navigator.pop(context);

                  var exception = ApiException(
                    url: Constants.entryCardUpdateUrl,
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
      Utils.showToast("Some validations failed", true);
    }
  }

  addSpouse() {
    spousefullNameControllers.add(TextEditingController());
    spousecnicControllers.add(TextEditingController());
    spousemobileControllers.add(TextEditingController());
    spousehouseControllers.add(TextEditingController());
    spouseroadControllers.add(TextEditingController());
    spousestreetControllers.add(TextEditingController());
    spouseblockControllers.add(TextEditingController());
    spousecolonyControllers.add(TextEditingController());
    spouseMohallaControllers.add(TextEditingController());
    spouseThanaControllers.add(TextEditingController());
    spouseCityControllers.add(TextEditingController());
    spouseProvinceControllers.add(TextEditingController());
    spouseImages.add(File(""));
    spouseCnicsfronts.add(File(""));
    spouseCnicBacks.add(File(""));
    update();
  }

  addChild() {
    childfullNameControllers.add(TextEditingController());
    childcnicControllers.add(TextEditingController());
    childmobileControllers.add(TextEditingController());
    childhouseControllers.add(TextEditingController());
    childroadControllers.add(TextEditingController());
    childstreetControllers.add(TextEditingController());
    childblockControllers.add(TextEditingController());
    childcolonyControllers.add(TextEditingController());
    childMohallaControllers.add(TextEditingController());
    childThanaControllers.add(TextEditingController());
    childCityControllers.add(TextEditingController());
    childProvinceControllers.add(TextEditingController());
    childImages.add(File(""));
    childCnicsfronts.add(File(""));
    childCnicBacks.add(File(""));
    update();
  }

  @override
  void onClose() {
    super.onClose();
    childImages.clear();
    childCnicsfronts.clear();
    childCnicBacks.clear();
    spouseImages.clear();
    spouseCnicsfronts.clear();
    spouseCnicBacks.clear();
    // spousefathersControllers.clear();
    spousefullNameControllers.clear();
    spousecnicControllers.clear();
    spousemobileControllers.clear();
    spousehouseControllers.clear();
    spouseroadControllers.clear();
    spousestreetControllers.clear();
    spouseblockControllers.clear();
    spousecolonyControllers.clear();
    spouseMohallaControllers.clear();
    spouseThanaControllers.clear();
    spouseCityControllers.clear();
    spouseProvinceControllers.clear();
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
