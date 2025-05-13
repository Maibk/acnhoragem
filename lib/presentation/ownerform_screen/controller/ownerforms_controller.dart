import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/core/utils/image_gallery.dart';
import 'package:anchorageislamabad/localization/strings_enum.dart';
import 'package:anchorageislamabad/presentation/ownerform_screen/models/owner_form_model.dart';
import 'package:anchorageislamabad/widgets/loader_widget.dart';
// import 'package:csc_picker/csc_picker.dart';
import 'package:csc_picker_plus/csc_picker_plus.dart';
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

  Street? selectedValue;

  String? total_children;
  String? total_wives;

  List children = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List wives = ["1", "2", "3", "4"];

  List<Street> streets = [];
  List<Plots> plots = [];
  Street? streetSelectedValue;
  Plots? plotstSelectedValue;

  String plotPlaceHolder = "Plots";
  final List<Street> block = [
    Street(id: 1, title: "A"),
    Street(id: 2, title: "AH"),
    Street(id: 3, title: "B"),
    Street(id: 4, title: "C"),
    Street(id: 5, title: "D"),
    Street(id: 6, title: "D EXT"),
    Street(id: 7, title: "E"),
    Street(id: 8, title: "F"),
    Street(id: 9, title: "G"),
    Street(id: 10, title: "H"),
    Street(id: 11, title: "J"),
    Street(id: 12, title: "K"),
    Street(id: 13, title: "L"),
    Street(id: 14, title: "M"),
    Street(id: 15, title: "NS-1"),
    Street(id: 16, title: "NS-2"),
    Street(id: 17, title: "NS-5"),
    Street(id: 18, title: "NS-3"),
  ];

  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  final RoundedLoadingButtonController editbtnController = RoundedLoadingButtonController();

  final RoundedLoadingButtonController uselessbtnController = RoundedLoadingButtonController();
  List<String> eTag = [];

  Rx<ApiCallStatus> formsLoadingStatus = ApiCallStatus.success.obs;

  final ImageGalleryClass imageGalleryClass = ImageGalleryClass();
  Future<File?> imageModal(context) async {
    File? file;
    imageGalleryClass.imageGalleryBottomSheet(
      context: context,
      onCameraTap: () async {
        file = await imageGalleryClass.getImage(ImageSource.camera);
        update();
        Get.back();
      },
      onGalleryTap: () async {
        file = await imageGalleryClass.getImage(ImageSource.gallery);
        update();
        Get.back();
      },
    );
    if (file != null) {
      return File(file!.path);
    }
    return null;
  }

  //owners controllers
  TextEditingController fullNameController = TextEditingController();
  TextEditingController fathersController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController natinalityController = TextEditingController(text: "Select");
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
  RxBool isInternetAvailable = true.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();

  CscCountry country = CscCountry.Pakistan;

  OwnerFormModel ownerFormModel = OwnerFormModel();

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  GlobalKey<FormState> formKey = GlobalKey();

  Map<String, dynamic> ownerFormdata = {};

  // GlobalKey<FormState> vehicleFormKey = GlobalKey();
  List<GlobalKey<FormState>> vehicleFormKey = [GlobalKey<FormState>()];
  int vehicleDataIndex = 0;

  Future<void> addvehicle(contex, index) async {
    final formState = vehicleFormKey[index].currentState;

    if (formState!.validate()) {
      if (eTag[index] == "") {
        Utils.showToast(
          "Please select E-Tag",
          true,
        );
        return;
      } else {
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
  }

  addvehicleControllers() {
    vehicleTypeControllers.add(TextEditingController());
    vehicleRegisterNoControllers.add(TextEditingController());
    vehicleColorControllers.add(TextEditingController());
    vehicleStikerControllers.add(TextEditingController());
    eTag.add("");
  }

  // void setSelectedBlock(String blockTitle) {
  //   var matchingBlock = block.firstWhere(
  //     (item) => item['title'] == blockTitle,
  //     orElse: () => {},
  //   );
  //   if (matchingBlock.isNotEmpty) {
  //     selectedValue = matchingBlock['id'];
  //   } else {
  //     selectedValue = null; // Handle cases where blockTitle is not found
  //   }
  // }

  getEntryFormsDetails(id) {
    eTag.clear();
    vehicleFormKey.clear();
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;
        formsLoadingStatus.value = ApiCallStatus.loading;
        update();
        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.ownerFormUrl + id.toString(), onSuccess: (response) {
            ownerFormModel = OwnerFormModel.fromJson(response.data);
            fullNameController.text = ownerFormModel.data?.name ?? "";
            presentAddController.text = ownerFormModel.data?.presentAddress ?? "";
            cnicController.text = ownerFormModel.data?.cnic ?? "";
            telephoneController.text = ownerFormModel.data?.phone ?? "";
            occupationController.text = ownerFormModel.data?.occupation ?? "";
            total_children = ownerFormModel.data?.total_children ?? "";
            total_wives = ownerFormModel.data?.total_wives ?? "";

            if (ownerFormModel.data?.vehicleStatus == "Yes") {
              updateVehicle("Yes");
            } else {
              updateVehicle("No");
            }
            selectedValue = Street(title: ownerFormModel.data?.blockCommercial ?? "", id: ownerFormModel.data?.block_id ?? 0);
            streetSelectedValue = Street(title: ownerFormModel.data?.streetNo ?? "");
            sizeHouseAddController.text = ownerFormModel.data?.sizeOfHousePlot ?? "";
            updateConstructionStatus(ownerFormModel.data?.construction_status ?? "");

            plotstSelectedValue = Plots(title: ownerFormModel.data?.houseNo ?? "", sq_yards: ownerFormModel.data?.sizeOfHousePlot ?? "");
            permanantAddController.text = ownerFormModel.data?.permanentAddress ?? "";

            if (ownerFormModel.data!.allotmentLetter.toString() == "Yes") {
              updateAllotmentLetter("Yes");
            } else {
              updateAllotmentLetter("No");
            }

            if (ownerFormModel.data!.privateArm.toString() == "Yes") {
              updatePrivatearms("Yes");
            } else {
              updatePrivatearms("No");
            }
            natinalityController.text = ownerFormModel.data?.nationality ?? "";
            privateLicenseController.text = ownerFormModel.data?.licenseNo ?? "";
            privateArmsController.text = ownerFormModel.data?.armQuantity.toString() ?? "";
            armQuantityController.text = ownerFormModel.data?.ammunitionQuantity.toString() ?? "";
            privateBoreController.text = ownerFormModel.data?.boreType ?? "";
            setCountry(ownerFormModel.data?.nationality ?? "");

            if (ownerFormModel.data!.completionCertificate.toString() == "Yes") {
              updateCompletionCertificate("Yes");
            } else {
              updateCompletionCertificate("No");
            }
            if (ownerFormModel.data!.vehicle != null) {
              for (var element in ownerFormModel.data!.vehicle!) {
                vehicleTypeControllers.add(TextEditingController(text: element.vehicleType));
                vehicleRegisterNoControllers.add(TextEditingController(text: element.registration));
                vehicleColorControllers.add(TextEditingController(text: element.color));
                vehicleStikerControllers.add(TextEditingController(text: element.stickerNo));
                eTag.add(element.etag ?? "Yes");
                vehicleFormKey.add(GlobalKey<FormState>());
              }

              vehicleDataIndex = ownerFormModel.data!.vehicle!.length;
            }

            update();

            formsLoadingStatus.value = ApiCallStatus.success;

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

  void setCountry(String input) {
    String countryName = input.split(' ').last;
    try {
      country = CscCountry.values.firstWhere(
        (element) => element.name == countryName,
        orElse: () => CscCountry.Pakistan, // Default to Pakistan
      );
    } catch (e) {
      country = CscCountry.Pakistan; // Fallback in case of an unexpected error
    }
    log(country.toString());
  }

  Future<void> ownerFormApi(context, index) async {
    final formState = formKey.currentState;
    if (formState!.validate()) {
      if (hasVehicle == "Yes") {
        if (vehicleFormKey[index].currentState!.validate()) {
          Utils.check().then((value) async {
            Map<String, dynamic> data = {
              'name': fullNameController.text,
              'cnic': cnicController.text,
              'phone': telephoneController.text,
              'nationality': natinalityController.text,
              'occupation': occupationController.text,
              'present_address': presentAddController.text,
              'permanent_address': permanantAddController.text,
              'block_commercial': selectedValue?.id ?? 0,
              // 'block_id': selectedValue?.id ?? 0,
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
              'status': '0',
              'total_wives': total_wives,
              'total_children': total_children,
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
              formsLoader(context);
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
                    // Navigator.pop(context);
                    log(json.encode(response.data));

                    Get.offAllNamed(AppRoutes.homePage);
                  } else {
                    // Navigator.pop(context);

                    Utils.showToast(
                      response.data['message'],
                      false,
                    );
                    log(response.statusMessage.toString());
                  }
                } on _dio.DioException catch (error) {
                  // Navigator.pop(context);

                  if (error.response == null) {
                    var exception = ApiException(
                      url: 'https://anchorageislamabad.com/api/owner-application',
                      message: error.message!,
                    );
                    return BaseClient.handleApiError(exception);
                  }

                  if (error.response?.statusCode == 500) {
                    // Navigator.pop(context);

                    Utils.showToast(
                      "Internal Server Error",
                      true,
                    );
                  }
                }
              });
            } else {
              // Navigator.pop(context);

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
            'block_commercial': selectedValue?.id ?? 0,
            // 'block_id': selectedValue?.id ?? 0,
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
            'status': '0',
            'total_wives': total_wives,
            'total_children': total_children,
          };

          ownerFormdata.addAll(data);

          log(ownerFormdata.toString(), name: "Owner form data");

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
            formsLoader(context);
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
                  // Navigator.pop(context);

                  log(json.encode(response.data));

                  Get.offAllNamed(AppRoutes.homePage);
                } else {
                  // Navigator.pop(context);

                  Utils.showToast(
                    response.data['message'],
                    false,
                  );
                  log(response.statusMessage.toString());
                }
              } on _dio.DioException catch (error) {
                // Navigator.pop(context);
                log(error.response!.data.toString().substring(500), name: "ERROOOOORORRRORO");
                if (error.response == null) {
                  var exception = ApiException(
                    url: 'https://anchorageislamabad.com/api/owner-application',
                    message: error.message!,
                  );
                  return BaseClient.handleApiError(exception);
                }

                if (error.response?.statusCode == 500) {
                  // Navigator.pop(context);

                  Utils.showToast(
                    "Internal Server Error",
                    true,
                  );
                }
              }
            });
          } else {
            // Navigator.pop(context);

            CustomSnackBar.showCustomErrorToast(
              message: Strings.noInternetConnection,
            );
          }
        });
      }
    } else {
      // Navigator.pop(context);

      Utils.showToast(
        "Please fill all the required fields",
        true,
      );
      log("Form validation failed");
    }
  }

  Future<void> editOwnerFormApi(context, int id, index) async {
    if (alottmentletter == "Yes") {
      if (allotmentletter == null && ownerFormModel.data!.allotmentLetterUrl == "") {
        Utils.showToast("Please select allotment letter image", true);
      } else {
        if (completionCertificate == "Yes") {
          if (certificate == null && ownerFormModel.data!.completionCertificateUrl == "") {
            Utils.showToast("Please select completion certificate image", true);
          } else {
            submitEdittedOwner(context, id, index);
          }
        } else {
          submitEdittedOwner(context, id, index);
        }
      }
    } else {
      submitEdittedOwner(context, id, index);
    }
  }

  submitEdittedOwner(context, id, index) {
    if (hasVehicle == "Yes") {
      if (vehicleFormKey[index].currentState!.validate()) {
        if (eTag.any((e) => e == "")) {
          Utils.showToast(
            "Please select E-Tag",
            true,
          );
        } else {
          formsLoader(context);
          Utils.check().then((value) async {
            Map<String, dynamic> data = {
              'name': fullNameController.text,
              'cnic': cnicController.text,
              'phone': telephoneController.text,
              'nationality': natinalityController.text,
              'occupation': occupationController.text,
              'present_address': presentAddController.text,
              'permanent_address': permanantAddController.text,
              'block_commercial': selectedValue?.id ?? 0,
              // 'block_id': selectedValue?.id ?? 0,
              'street_no': streetSelectedValue?.title ?? "",
              'house_no': plotstSelectedValue?.title ?? "",
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
              'status': '0',
              'property_user': 'owner',
              'total_wives': total_wives,
              'total_children': total_children,
            };

            ownerFormdata.addAll(data);

            if (ownerFormModel.data!.vehicleStatus == "Yes") {
              for (int i = 0; i < ownerFormModel.data!.vehicle!.length; i++) {
                ownerFormdata['vehicle_type[$i]'] = ownerFormModel.data!.vehicle![i].vehicleTypeController.text == ""
                    ? null
                    : ownerFormModel.data!.vehicle![i].vehicleTypeController.text;
                ownerFormdata['registration[$i]'] = ownerFormModel.data!.vehicle![i].registrationController.text == ""
                    ? null
                    : ownerFormModel.data!.vehicle![i].registrationController.text;
                ownerFormdata['color[$i]'] =
                    ownerFormModel.data!.vehicle![i].colorController.text == "" ? null : ownerFormModel.data!.vehicle![i].colorController.text;
                ownerFormdata['sticker_no[$i]'] = ownerFormModel.data!.vehicle![i].stickerNoController.text == ""
                    ? null
                    : ownerFormModel.data!.vehicle![i].stickerNoController.text;
                ownerFormdata['etag[$i]'] = eTag[i].toString() == "" ? null : eTag[i].toString();
              }
            } else {
              ownerFormdata['vehicle_type[]'] = null;
              ownerFormdata['registration[]'] = null;
              ownerFormdata['color[]'] = null;
              ownerFormdata['sticker_no[]'] = null;
              ownerFormdata['etag[]'] = null;
            }
            log(ownerFormdata.toString());

            if (alottmentletter == "Yes") {
              final allotment = allotmentletter;
              if (allotment != null) {
                final allotmentPath = allotment.path;

                if (!allotmentPath.startsWith("http")) {
                  if (allotmentPath.isNotEmpty) {
                    ownerFormdata['copy_allotment_letter'] = await _dio.MultipartFile.fromFile(
                      allotmentPath,
                      filename: allotmentPath.split('/').last,
                      contentType: _http.MediaType.parse('image/jpeg'),
                    );
                  }
                } else {
                  final allotmentUrl = ownerFormModel.data?.allotmentLetterUrl;
                  if (allotmentUrl != null && allotmentUrl.isNotEmpty) {
                    ownerFormdata['copy_allotment_letter'] = await BaseClient.getMultipartFileFromUrl(allotmentUrl);
                  }
                }
              }
            } else {
              ownerFormdata['copy_allotment_letter'] = null;
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
            } else {
              try {
                ownerFormdata['copy_approval_building_plan'] =
                    await BaseClient.getMultipartFileFromUrl(ownerFormModel.data?.approvalBuildingPlanUrl ?? "");
              } catch (e) {}
            }

            if (completionCertificate == "Yes") {
              final cert = certificate;
              if (cert != null) {
                final certPath = cert.path;

                if (!certPath.startsWith("http")) {
                  if (certPath.isNotEmpty) {
                    ownerFormdata['copy_completion_certificate'] = await _dio.MultipartFile.fromFile(
                      certPath,
                      filename: certPath.split('/').last,
                      contentType: _http.MediaType.parse('image/jpeg'),
                    );
                  }
                } else {
                  final certUrl = ownerFormModel.data?.completionCertificateUrl;
                  if (certUrl != null && certUrl.isNotEmpty) {
                    ownerFormdata['copy_completion_certificate'] = await BaseClient.getMultipartFileFromUrl(certUrl);
                  }
                }
              }
            }

            if (value) {
              _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
                var dio = _dio.Dio();
                try {
                  var response = await dio.request(
                    'https://anchorageislamabad.com/api/owner-application/update/$id',
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
                    log(json.encode(response.data));

                    Get.offAllNamed(AppRoutes.homePage);
                  } else {
                    Utils.showToast(
                      response.data['message'],
                      false,
                    );
                    log(response.statusMessage.toString());
                  }
                } on _dio.DioException catch (error) {
                  if (error.response?.statusCode == 404) {
                    Utils.showToast(
                      error.response!.data['message'].toString(),
                      true,
                    );
                  }
                  if (error is Response) {
                    Utils.showToast(
                      error.response!.data['message'].toString(),
                      true,
                    );
                  } else {
                    Utils.showToast(
                      error.message.toString(),
                      true,
                    );
                  }

                  if (error.response == null) {
                    var exception = ApiException(
                      url: 'https://anchorageislamabad.com/api/owner-application',
                      message: error.message!,
                    );
                    return BaseClient.handleApiError(exception);
                  }

                  if (error.response?.statusCode == 500) {
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
      }
    } else {
      formsLoader(context);
      Utils.check().then((value) async {
        Map<String, dynamic> data = {
          'name': fullNameController.text,
          'cnic': cnicController.text,
          'phone': telephoneController.text,
          'nationality': natinalityController.text,
          'occupation': occupationController.text,
          'present_address': presentAddController.text,
          'permanent_address': permanantAddController.text,
          'block_commercial': selectedValue?.id ?? 0,
          'street_no': streetSelectedValue?.title ?? "",
          'house_no': plotstSelectedValue?.title ?? "",
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
          'status': '0',
          'property_user': 'owner',
          'total_wives': total_wives,
          'total_children': total_children,
        };

        ownerFormdata.addAll(data);

        if (ownerFormModel.data!.vehicleStatus == "Yes") {
          for (int i = 0; i < ownerFormModel.data!.vehicle!.length; i++) {
            ownerFormdata['vehicle_type[$i]'] = ownerFormModel.data!.vehicle![i].vehicleTypeController.text == ""
                ? null
                : ownerFormModel.data!.vehicle![i].vehicleTypeController.text;
            ownerFormdata['registration[$i]'] = ownerFormModel.data!.vehicle![i].registrationController.text == ""
                ? null
                : ownerFormModel.data!.vehicle![i].registrationController.text;
            ownerFormdata['color[$i]'] =
                ownerFormModel.data!.vehicle![i].colorController.text == "" ? null : ownerFormModel.data!.vehicle![i].colorController.text;
            ownerFormdata['sticker_no[$i]'] =
                ownerFormModel.data!.vehicle![i].stickerNoController.text == "" ? null : ownerFormModel.data!.vehicle![i].stickerNoController.text;
            ownerFormdata['etag[$i]'] = eTag[i].toString() == "" ? null : eTag[i].toString();
          }
        } else {
          ownerFormdata['vehicle_type[]'] = null;
          ownerFormdata['registration[]'] = null;
          ownerFormdata['color[]'] = null;
          ownerFormdata['sticker_no[]'] = null;
          ownerFormdata['etag[]'] = null;
        }
        log(ownerFormdata.toString());

        if (alottmentletter == "Yes") {
          final allotment = allotmentletter;
          if (allotment != null) {
            final allotmentPath = allotment.path;

            if (!allotmentPath.startsWith("http")) {
              if (allotmentPath.isNotEmpty) {
                ownerFormdata['copy_allotment_letter'] = await _dio.MultipartFile.fromFile(
                  allotmentPath,
                  filename: allotmentPath.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                );
              }
            } else {
              final allotmentUrl = ownerFormModel.data?.allotmentLetterUrl;
              if (allotmentUrl != null && allotmentUrl.isNotEmpty) {
                ownerFormdata['copy_allotment_letter'] = await BaseClient.getMultipartFileFromUrl(allotmentUrl);
              }
            }
          }
        } else {
          ownerFormdata['copy_allotment_letter'] = null;
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
        } else {
          try {
            ownerFormdata['copy_approval_building_plan'] =
                await BaseClient.getMultipartFileFromUrl(ownerFormModel.data?.approvalBuildingPlanUrl ?? "");
          } catch (e) {}
        }

        if (completionCertificate == "Yes") {
          final cert = certificate;
          if (cert != null) {
            final certPath = cert.path;

            if (!certPath.startsWith("http")) {
              if (certPath.isNotEmpty) {
                ownerFormdata['copy_completion_certificate'] = await _dio.MultipartFile.fromFile(
                  certPath,
                  filename: certPath.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                );
              }
            } else {
              final certUrl = ownerFormModel.data?.completionCertificateUrl;
              if (certUrl != null && certUrl.isNotEmpty) {
                ownerFormdata['copy_completion_certificate'] = await BaseClient.getMultipartFileFromUrl(certUrl);
              }
            }
          }
        }

        if (value) {
          _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
            var dio = _dio.Dio();
            try {
              var response = await dio.request(
                'https://anchorageislamabad.com/api/owner-application/update/$id',
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
                log(json.encode(response.data));

                Get.offAllNamed(AppRoutes.homePage);
              } else {
                Utils.showToast(
                  response.data['message'],
                  false,
                );
                log(response.statusMessage.toString());
              }
            } on _dio.DioException catch (error) {
              if (error.response?.statusCode == 404) {
                Utils.showToast(
                  error.response!.data['message'].toString(),
                  true,
                );
              }
              if (error is Response) {
                Utils.showToast(
                  error.response!.data['message'].toString(),
                  true,
                );
              } else {
                Utils.showToast(
                  error.message.toString(),
                  true,
                );
              }

              if (error.response == null) {
                var exception = ApiException(
                  url: 'https://anchorageislamabad.com/api/owner-application',
                  message: error.message!,
                );
                return BaseClient.handleApiError(exception);
              }

              if (error.response?.statusCode == 500) {
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
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.getPlotByStreetUrl + id.toString(), onSuccess: (response) {
            update();
            plots.clear;
            for (var element in response.data['data']) {
              plots.add(Plots(id: element["id"] ?? 0, title: element["plot_no"] ?? "", sq_yards: element["sq_yards"] ?? ""));
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
}

class Street {
  int? id;
  String? title;

  Street({this.id, required this.title});
}

class Plots {
  int? id;
  String? title;
  String? sq_yards;

  Plots({this.id, required this.title, required this.sq_yards});
}
