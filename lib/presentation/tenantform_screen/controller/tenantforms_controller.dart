import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/core/utils/date_time_utils.dart';
import 'package:anchorageislamabad/localization/strings_enum.dart';
import 'package:anchorageislamabad/presentation/tenantform_screen/models/tenant_form_model.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:anchorageislamabad/widgets/loader_widget.dart';
// import 'package:csc_picker/csc_picker.dart';
import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../../../widgets/custom_snackbar.dart';

/// A controller class for the DiscoverScreen.
///
/// This class manages the state of the DiscoverScreen, including the
/// current discoverModelObj
///
class TenantFornsScreenController extends GetxController {
  File? ownerCnic;
  File? tenantCnic;
  // File? estateAgentCnic;
  File? tenantPhoto;
  File? rentAgreement;
  File? policeForm;
  File? certificate;
  int? selectedValue;

  List<File>? ownerCnicFrontBack;
  List<File>? tenantCnicFrontBack;
  List<File>? estateCnicFrontBack;

  Future<List<File>?> getImages(context) async {
    final pickedFile = await picker.pickMultiImage(imageQuality: 100, maxHeight: 1000, maxWidth: 1000);

    List<File> selectedImages = [];

    List<XFile> xfilePick = pickedFile;
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }

      update();
      return selectedImages;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
    return null;
  }

  String alottmentletter = "";
  String completionCertificate = "";

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

  final RoundedLoadingButtonController uselessbtnController = RoundedLoadingButtonController();
  final RoundedLoadingButtonController editbtnController = RoundedLoadingButtonController();

  String? privatearms = "";
  String? hasVehicle = "";
  List<String> eTag = [];
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
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
  TextEditingController privateAmmunitionController = TextEditingController();
  TextEditingController armQuantityController = TextEditingController();
  TextEditingController privateBoreController = TextEditingController();

//Owner Controllers
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerPermanentAddressController = TextEditingController();
  TextEditingController ownerPresenttAddressController = TextEditingController();
  String? ownerHouseSize;
  TextEditingController ownerPhoneController = TextEditingController();
  TextEditingController ownerCNICController = TextEditingController();
  CscCountry country = CscCountry.Pakistan;

  List<String> ownerHousesSize = [
    "100",
    "125",
    "133",
    "200",
    "225",
    "250",
    "350",
    "448",
    "474",
    "476",
    "481",
    "500",
    "1000",
    "1329",
    "2000",
    "3539",
    "4235"
  ];

  Rx<ApiCallStatus> formsLoadingStatus = ApiCallStatus.success.obs;

  //vichicles controller
  List<TextEditingController> vehicleTypeControllers = [];
  List<TextEditingController> vehicleRegisterNoControllers = [];
  List<TextEditingController> vehicleColorControllers = [];
  List<TextEditingController> vehicleStikerControllers = [];
  // TextEditingController vehicleEngineNoController = TextEditingController();
  TextEditingController vehicleEtagController = TextEditingController();
  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();

  RxList<DealsModel> categories = <DealsModel>[].obs;

  GlobalKey<FormState> formKey = GlobalKey();

  TenantFormModel tenantFormModel = TenantFormModel();

  var tenantFormdata = {};

  Map<String, dynamic> NovehicleFormdata = {'vehicle_type[]': " ", 'registration[]': " ", 'color[]': " ", 'sticker_no[]': " ", 'etag[]': " "};

  List<GlobalKey<FormState>> vehicleFormKey = [GlobalKey<FormState>()];
  int vehicleDataIndex = 0;

  addvehicleControllers() {
    vehicleTypeControllers.add(TextEditingController());
    vehicleRegisterNoControllers.add(TextEditingController());
    vehicleColorControllers.add(TextEditingController());
    vehicleStikerControllers.add(TextEditingController());
    eTag.add("");
  }

  Future<void> addvehicle(context, index) async {
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
          tenantFormdata['vehicle_type[$index]'] = vehicleTypeControllers[index].text;
          tenantFormdata['registration[$index]'] = vehicleRegisterNoControllers[index].text;
          tenantFormdata['color[$index]'] = vehicleColorControllers[index].text;
          tenantFormdata['sticker_no[$index]'] = vehicleStikerControllers[index].text;
          tenantFormdata['etag[$index]'] = eTag[index];
          Utils.showToast(
            "Vehicle Added Successfully",
            false,
          );
          vehicleDataIndex = vehicleDataIndex + 1;
          update();
          log(tenantFormdata.toString());
        });
      }
    }
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

  getEntryFormsDetails(id) {
    eTag.clear();
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;
        formsLoadingStatus.value = ApiCallStatus.loading;
        update();
        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.tenantFormUrl + id.toString(), onSuccess: (response) {
            log(response.data.toString(), name: "Tenant Form data>>");
            tenantFormModel = TenantFormModel.fromJson(response.data);
            fullNameController.text = tenantFormModel.data?.tenantName ?? "";
            fathersController.text = tenantFormModel.data?.fatherName ?? "";
            telephoneController.text = tenantFormModel.data?.tenantPhone ?? "";
            selectedValue = tenantFormModel.data?.blockId;

            streetSelectedValue = Street(id: tenantFormModel.data?.streetId ?? 0, title: tenantFormModel.data?.tenantStreetNo ?? "");
            plotstSelectedValue = Plots(
                id: tenantFormModel.data?.houseId ?? 0,
                title: tenantFormModel.data?.tenantHouseNo ?? "",
                sq_yards: tenantFormModel.data?.tenantSizeOfHousePlot ?? "");
            cnicController.text = tenantFormModel.data?.tenantCnic ?? "";
            occupationController.text = tenantFormModel.data?.tenantOccupation ?? "";
            presentAddController.text = tenantFormModel.data?.tenantPermanentAddress ?? "";
            sizeHouseAddController.text = tenantFormModel.data?.tenantSizeOfHousePlot ?? "";
            permanantAddController.text = tenantFormModel.data?.tenantPermanentAddress ?? "";

            // Particulars of owner

            ownerNameController.text = tenantFormModel.data?.name ?? "";
            ownerCNICController.text = tenantFormModel.data?.cnic ?? "";
            ownerPhoneController.text = tenantFormModel.data?.phone ?? "";
            ownerPermanentAddressController.text = tenantFormModel.data?.permanentAddress ?? "";
            ownerPresenttAddressController.text = tenantFormModel.data?.presentAddress ?? "";
            ownerHouseSize = tenantFormModel.data?.sizeOfHousePlot ?? "";

            if (tenantFormModel.data!.allotmentLetter.toString() == "Yes") {
              updateAllotmentLetter("Yes");
            } else {
              updateAllotmentLetter("No");
            }

            if (tenantFormModel.data!.privateArm.toString() == "Yes") {
              updatePrivatearms("Yes");
            } else {
              updatePrivatearms("No");
            }
            natinalityController.text = tenantFormModel.data?.tenantNationality ?? "";
            privateLicenseController.text = tenantFormModel.data?.licenseNo ?? "";
            privateArmsController.text = tenantFormModel.data?.armQuantity.toString() ?? "";
            privateAmmunitionController.text = tenantFormModel.data?.ammunitionQuantity.toString() ?? "";
            privateBoreController.text = tenantFormModel.data?.boreType ?? "";

            if (tenantFormModel.data!.completionCertificate.toString() == "Yes") {
              updateCompletionCertificate("Yes");
            } else {
              updateCompletionCertificate("No");
            }
            if (tenantFormModel.data?.vehicleStatus == "Yes") {
              updateVehicle("Yes");
            } else {
              updateVehicle("No");
            }
            setCountry(tenantFormModel.data?.tenantNationality ?? "");

            if (tenantFormModel.data!.vehicle != null) {
              for (var element in tenantFormModel.data!.vehicle!) {
                vehicleTypeControllers.add(TextEditingController(text: element.vehicleType));
                vehicleRegisterNoControllers.add(TextEditingController(text: element.registration));
                vehicleColorControllers.add(TextEditingController(text: element.color));
                vehicleStikerControllers.add(TextEditingController(text: element.stickerNo));
                eTag.add(element.etag ?? "Yes");
                vehicleFormKey.add(GlobalKey<FormState>());
              }

              vehicleDataIndex = tenantFormModel.data!.vehicle!.length;
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

  Future<void> tenantFormApi(context) async {
    final formState = formKey.currentState;
    if (formState!.validate()) {
      Utils.check().then((value) async {
        var data = _dio.FormData.fromMap({
          'tenant_name': fullNameController.text,
          'name': ownerNameController.text,
          'phone': ownerPhoneController.text,
          'cnic': ownerCNICController.text,
          'father_name': fathersController.text,
          'tenant_cnic': cnicController.text,
          'tenant_phone': telephoneController.text,
          'tenant_nationality': natinalityController.text,
          'tenant_occupation': occupationController.text,
          'tenant_permanent_address': presentAddController.text,
          'tenant_block_commercial': selectedValue,
          'tenant_street_no': streetSelectedValue?.id ?? 0,
          'tenant_house_no': plotstSelectedValue?.id ?? 0,
          'tenant_size_of_house_plot': sizeHouseAddController.text,
          'present_address': ownerPresenttAddressController.text,
          'permanent_address': ownerPermanentAddressController.text,
          'size_of_house_plot': ownerHouseSize,
          'allotment_letter': alottmentletter,
          'completion_certificate': completionCertificate,
          'construction_status': custructionStatusAddController.text,
          'private_arm': privatearms == "Yes" ? "Yes" : "No",
          'license_no': privatearms == "Yes" ? privateLicenseController.text : "No",
          'arm_quantity': privatearms == "Yes" ? privateArmsController.text : "No",
          'bore_type': privatearms == "Yes" ? privateBoreController.text : "No",
          'ammunition_quantity': privatearms == "Yes" ? privateAmmunitionController.text : "No",
          'vehicle_status': vehicleDataIndex > 0 ? "Yes" : "NO",
          'submit_date': DateTime.now().format("dd-MM-yyyy").toString(),
          'status': '0'
        });
        vehicleDataIndex > 0
            ? {
                tenantFormdata.forEach((key, value) {
                  data.fields.addAll([MapEntry(key, value)]);
                })
              }
            : {
                NovehicleFormdata.forEach((key, value) {
                  data.fields.addAll([MapEntry(key, value)]);
                })
              };
        for (var i = 0; i < ownerCnicFrontBack!.length; i++) {
          data.files.addAll([
            MapEntry(
                "owner_cnic_image[$i]",
                await _dio.MultipartFile.fromFile(
                  ownerCnicFrontBack![i].path,
                  filename: ownerCnicFrontBack![i].path.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                )),
          ]);
        }

        for (var i = 0; i < ownerCnicFrontBack!.length; i++) {
          data.files.addAll([
            MapEntry(
                "owner_cnic_image[$i]",
                await _dio.MultipartFile.fromFile(
                  ownerCnicFrontBack![i].path,
                  filename: ownerCnicFrontBack![i].path.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                )),
          ]);
        }
        for (var i = 0; i < tenantCnicFrontBack!.length; i++) {
          data.files.addAll([
            MapEntry(
                "tenant_cnic_image[$i]",
                await _dio.MultipartFile.fromFile(
                  tenantCnicFrontBack![i].path,
                  filename: tenantCnicFrontBack![i].path.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                )),
          ]);
        }

        if (estateCnicFrontBack != null) {
          for (var i = 0; i < estateCnicFrontBack!.length; i++) {
            data.files.addAll([
              MapEntry(
                  "agent_cnic_image[$i]",
                  await _dio.MultipartFile.fromFile(
                    estateCnicFrontBack![i].path,
                    filename: estateCnicFrontBack![i].path.split('/').last,
                    contentType: _http.MediaType.parse('image/jpeg'),
                  )),
            ]);
          }
        }
        if (tenantPhoto != null) {
          String filePath1 = tenantPhoto?.path ?? '';
          if (filePath1.isNotEmpty) {
            data.files.add(MapEntry(
                'tenant_image',
                await _dio.MultipartFile.fromFile(
                  filePath1,
                  filename: filePath1.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                )));
          }
        }
        if (rentAgreement != null) {
          String filePath1 = rentAgreement?.path ?? '';
          if (filePath1.isNotEmpty) {
            data.files.add(MapEntry(
                'agreement_image',
                await _dio.MultipartFile.fromFile(
                  filePath1,
                  filename: filePath1.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                )));
          }
        }
        if (policeForm != null) {
          String filePath1 = policeForm?.path ?? '';
          if (filePath1.isNotEmpty) {
            data.files.add(MapEntry(
                'police_registration_image',
                await _dio.MultipartFile.fromFile(
                  filePath1,
                  filename: filePath1.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                )));
          }
        }
        if (certificate != null) {
          String filePath1 = certificate?.path ?? '';
          if (filePath1.isNotEmpty) {
            data.files.add(MapEntry(
                'copy_completion_certificate',
                await _dio.MultipartFile.fromFile(
                  filePath1,
                  filename: filePath1.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                )));
          }
        }

        log(data.fields.toString());
        if (value) {
          formsLoader(context);
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
                data: data,
              );
              if (response.statusCode == 200) {
                log(data.toString());
                Navigator.pop(context);
                Utils.showToast(
                  response.data['message'],
                  false,
                );
                log(json.encode(response.data));

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

              if (error.response == null) {
                var exception = ApiException(
                  url: 'https://anchorageislamabad.com/api/owner-application',
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
          Navigator.pop(context);

          CustomSnackBar.showCustomErrorToast(
            message: Strings.noInternetConnection,
          );
        }
      });
    } else {
      print("Form validation failed");
    }
  }

  Future<void> editTenantFormApi(context, int id) async {
    formsLoader(context);
    Utils.check().then((value) async {
      var data = _dio.FormData.fromMap({
        'tenant_name': fullNameController.text,
        'name': ownerNameController.text,
        'phone': ownerPhoneController.text,
        'cnic': ownerCNICController.text,
        'father_name': fathersController.text,
        'tenant_cnic': cnicController.text,
        'tenant_phone': telephoneController.text,
        'tenant_nationality': natinalityController.text,
        'tenant_occupation': occupationController.text,
        'tenant_permanent_address': presentAddController.text,
        'tenant_block_commercial': selectedValue,
        'tenant_street_no': streetSelectedValue?.id ?? "",
        'tenant_house_no': plotstSelectedValue?.id ?? "",
        'tenant_size_of_house_plot': sizeHouseAddController.text,
        'present_address': presentAddController.text,
        'permanent_address': presentAddController.text,
        'size_of_house_plot': ownerHouseSize,
        'allotment_letter': alottmentletter,
        'completion_certificate': completionCertificate,
        'construction_status': custructionStatusAddController.text,
        'private_arm': privatearms == "Yes" ? "Yes" : "No",
        'license_no': privatearms == "Yes" ? privateLicenseController.text : "No",
        'arm_quantity': privatearms == "Yes" ? privateArmsController.text : "No",
        'bore_type': privatearms == "Yes" ? privateBoreController.text : "No",
        'ammunition_quantity': privatearms == "Yes" ? privateAmmunitionController.text : "No",
        'vehicle_status': hasVehicle ?? "No",
        'submit_date': DateTime.now().format("dd-MM-yyyy").toString(),
        'status': '0',
        'property_user': 'tenant',
      });

      if (hasVehicle == "Yes") {
        for (var i = 0; i < tenantFormModel.data!.vehicle!.length; i++) {
          tenantFormdata['vehicle_type[$i]'] = tenantFormModel.data!.vehicle![i].vehicleTypeController.text == ""
              ? null
              : tenantFormModel.data!.vehicle![i].vehicleTypeController.text;
          tenantFormdata['registration[$i]'] = tenantFormModel.data!.vehicle![i].registrationController.text == ""
              ? null
              : tenantFormModel.data!.vehicle![i].registrationController.text;
          tenantFormdata['color[$i]'] =
              tenantFormModel.data!.vehicle![i].colorController.text == "" ? null : tenantFormModel.data!.vehicle![i].colorController.text;
          tenantFormdata['sticker_no[$i]'] =
              tenantFormModel.data!.vehicle![i].stickerNoController.text == "" ? null : tenantFormModel.data!.vehicle![i].stickerNoController.text;
          tenantFormdata['etag[$i]'] = eTag[i].toString() == "" ? null : eTag[i].toString();
        }
        data.fields.addAll(tenantFormdata.entries.map((e) => MapEntry(e.key, e.value?.toString() ?? '')));
      } else {
        var nullData =
            _dio.FormData.fromMap({'vehicle_type[0]': null, 'registration[0]': null, 'color[0]': null, 'sticker_no[0]': null, 'etag[0]': null});
        data.fields.addAll(nullData.fields);
      }

      if (ownerCnicFrontBack != null && ownerCnicFrontBack!.isNotEmpty) {
        for (var i = 0; i < ownerCnicFrontBack!.length; i++) {
          String filePath1 = ownerCnicFrontBack![i].path;
          if (filePath1.isNotEmpty) {
            data.files.addAll([
              MapEntry(
                "owner_cnic_image[$i]",
                await _dio.MultipartFile.fromFile(
                  filePath1,
                  filename: filePath1.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                ),
              ),
            ]);
          }
        }
      } else {
        data.files.addAll([
          MapEntry(
            "owner_cnic_image[0]",
            await BaseClient.getMultipartFileFromUrl(
              tenantFormModel.data!.ownerCnicUrl!.cnicFront ?? "",
            ),
          ),
        ]);
      }

      if (tenantCnicFrontBack != null && tenantCnicFrontBack!.isNotEmpty) {
        for (var i = 0; i < tenantCnicFrontBack!.length; i++) {
          String filePath1 = tenantCnicFrontBack![i].path;
          if (filePath1.isNotEmpty) {
            data.files.addAll([
              MapEntry(
                "tenant_cnic_image[$i]",
                await _dio.MultipartFile.fromFile(
                  filePath1,
                  filename: filePath1.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                ),
              ),
            ]);
          }
        }
      } else {
        data.files.addAll([
          MapEntry(
            "tenant_cnic_image[0]",
            await BaseClient.getMultipartFileFromUrl(
              tenantFormModel.data!.tenantCnicUrl!.cnicFront ?? "",
            ),
          ),
        ]);
      }

      if (estateCnicFrontBack != null && estateCnicFrontBack!.isNotEmpty) {
        for (var i = 0; i < estateCnicFrontBack!.length; i++) {
          String filePath1 = estateCnicFrontBack![i].path;
          if (filePath1.isNotEmpty) {
            data.files.addAll([
              MapEntry(
                "agent_cnic_image[$i]",
                await _dio.MultipartFile.fromFile(
                  filePath1,
                  filename: filePath1.split('/').last,
                  contentType: _http.MediaType.parse('image/jpeg'),
                ),
              ),
            ]);
          }
        }
      } else {
        data.files.addAll([
          MapEntry(
            "agent_cnic_image[0]",
            await BaseClient.getMultipartFileFromUrl(
              tenantFormModel.data!.tenantCnicUrl!.cnicFront ?? "",
            ),
          ),
        ]);
      }

      if (tenantPhoto != null) {
        String filePath1 = tenantPhoto?.path ?? '';
        if (filePath1.isNotEmpty) {
          data.files.add(MapEntry(
              'tenant_image',
              await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              )));
        }
      } else {
        data.files.add(MapEntry('tenant_image', await await BaseClient.getMultipartFileFromUrl(tenantFormModel.data!.tenantImageUrl ?? "")));
      }

      if (rentAgreement != null) {
        String filePath1 = rentAgreement?.path ?? '';
        if (filePath1.isNotEmpty) {
          data.files.add(MapEntry(
              'agreement_image',
              await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              )));
        }
      } else {
        data.files.add(MapEntry('agreement_image', await await BaseClient.getMultipartFileFromUrl(tenantFormModel.data!.agreementImageUrl ?? "")));
      }
      if (policeForm != null) {
        String filePath1 = policeForm?.path ?? '';
        if (filePath1.isNotEmpty) {
          data.files.add(MapEntry(
              'police_registration_image',
              await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              )));
        }
      } else {
        data.files.add(
            MapEntry('police_registration_image', await await BaseClient.getMultipartFileFromUrl(tenantFormModel.data!.policeRegistrationUrl ?? "")));
      }
      if (certificate != null) {
        String filePath1 = certificate?.path ?? '';
        if (filePath1.isNotEmpty) {
          data.files.add(MapEntry(
              'copy_completion_certificate',
              await _dio.MultipartFile.fromFile(
                filePath1,
                filename: filePath1.split('/').last,
                contentType: _http.MediaType.parse('image/jpeg'),
              )));
        }
      } else {
        data.files.add(MapEntry(
            'copy_completion_certificate', await await BaseClient.getMultipartFileFromUrl(tenantFormModel.data!.completionCertificateUrl ?? "")));
      }

      if (value) {
        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          var dio = _dio.Dio();
          try {
            var response = await dio.request(
              'https://anchorageislamabad.com/api/tenant-application/update/$id',
              options: _dio.Options(
                method: 'POST',
                headers: {
                  'Authorization': "Bearer $token",
                },
              ),
              data: data,
            );
            if (response.statusCode == 200) {
              Navigator.pop(context);

              Utils.showToast(
                response.data['message'],
                false,
              );
              log(json.encode(response.data));

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

            if (error.response?.data is Map) {
              Utils.showToast(
                error.response?.data.toString() ?? "",
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
              Navigator.pop(context);
              Utils.showToast(
                "Internal Server Error",
                true,
              );
            }
          }
        });
      } else {
        Navigator.pop(context);

        CustomSnackBar.showCustomErrorToast(
          message: Strings.noInternetConnection,
        );
      }
    });
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

  updateEtag(value) {
    eTag.add(value);
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
