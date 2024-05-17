// import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/core/model_classes/properties_model.dart';
import 'package:anchorageislamabad/core/model_classes/user_model.dart';
import 'package:anchorageislamabad/presentation/login_screen/controller/login_controller.dart';
import 'package:anchorageislamabad/presentation/myprofile_screen/controller/myprofile_controller.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:dio/dio.dart' as _dio;
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
import '../../../localization/strings_enum.dart';
import '../../../widgets/custom_snackbar.dart';
import '../models/complaints_model.dart';

/// A controller class for the DiscoverScreen.
///
/// This class manages the state of the DiscoverScreen, including the
/// current discoverModelObj
///
class ComplaintsController extends GetxController {
  // Rx<DiscoverModel> discoverModelObj = DiscoverModel().obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  MyprofileController profileController = MyprofileController();

  String complaintType = '';

  int propertyId = 0;

  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences _appPreferences = AppPreferences();
  AppPreferences appPreferences = AppPreferences();
  List<PropertyName> propertyNames = [];
  PropertyName? selectedProperty;
  RxList<DealsModel> categories = <DealsModel>[].obs;
  GlobalKey<FormState> formKey = new GlobalKey();
  List<File>? complaintsImages;
  PropertiesModel? properties;
  Future<PropertiesModel?> getPropertiesApi() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(
              // headers: {'Authorization': "Bearer 15|7zbPqSX0mng6isF9L3iU3v33V6eaoGvEMkE2K7Fg"},
              headers: {'Authorization': "Bearer $token"},
              Constants.getProperties, onSuccess: (response) {
            log(response.toString());

            properties = PropertiesModel.fromJson(response.data);

            for (var element in properties!.data!) {
              propertyNames.add(PropertyName(id: element.id!, name: element.propertyName!));
            }

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

  final ImagePicker picker = ImagePicker();
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

  File? complaintPhoto;

  List<String> indoorComplaints = [];

  Complaint? selectedComplaint;
  Map<String, dynamic>? selectedDepartment;

  final List<Complaint> complaints = [
    Complaint(
      id: 2,
      title: "Indoor Complaint",
      findDepartments: [
        {"id": 16, "title": "Maids/Servants"},
        {"id": 17, "title": "SNGPL"},
        {"id": 18, "title": "Electrical"},
        {"id": 19, "title": "Plumbing"},
        {"id": 20, "title": "Carpenter"},
        {"id": 22, "title": "BIlling Department"},
        {"id": 23, "title": "Civil Engineering Department"},
      ],
    ),
    Complaint(
      id: 1,
      title: "Outdoor Complaints",
      findDepartments: [
        {"id": 5, "title": "Security"},
        {"id": 7, "title": "Road/Street Infrastructure"},
        {"id": 8, "title": "Sewerage/Rain Drainage"},
        {"id": 10, "title": "Waste Management/Garbage Bins"},
        {"id": 11, "title": "Street Lights"},
        {"id": 12, "title": "Water Supply & Maintenance Department"},
        {"id": 13, "title": "Misc"},
        {"id": 14, "title": "Advertisement"},
        {"id": 15, "title": "Society Janitorial Services"},
        {"id": 25, "title": "Horticulture Department"},
        {"id": 26, "title": "Commercial Area"},
        {"id": 27, "title": "Price Control"},
      ],
    ),
  ];

  ComplaintTypes? complaintTypes;
  Future<Complaints?> getComplainTypes() async {
    Utils.check().then((value) async {
      if (value) {
        isInternetAvailable.value = true;

        apiCallStatus.value = ApiCallStatus.loading;

        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          await BaseClient.get(
              // headers: {'Authorization': "Bearer 15|7zbPqSX0mng6isF9L3iU3v33V6eaoGvEMkE2K7Fg"},
              headers: {'Authorization': "Bearer $token"},
              Constants.complaintTypeUrl, onSuccess: (response) {
            log(response.toString());

            complaintTypes = ComplaintTypes.fromJson(response.data);

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

  Future<void> submitComplaint(context, int id) async {
    Utils.check().then((value) async {
      Map<String, dynamic> data = {};

      data = {
        'member_id': UserModel().id,
        'complaint_type_id': selectedDepartment!['id'].toString(),
        'property_id': id,
        'description': descriptionController.text
      };

      if (complaintsImages != null) {
        for (var i = 0; i < complaintsImages!.length; i++) {
          String filePath1 = complaintsImages![i].path;
          if (filePath1.isNotEmpty) {
            data['attachment[$i]'] = await _dio.MultipartFile.fromFile(
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
              'https://anchorageislamabad.com/api/complaint',
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

              Get.offNamed(AppRoutes.myComplaintsPage);
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

  Future<void> submitMessge(context, id) async {
    Utils.check().then((value) async {
      Map<String, dynamic> data = {'complaint_id': id, 'user_id': loginResponseModel?.data?.id ?? 0, 'message': messageController.text};

      if (value) {
        btnController.start();
        _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
          var dio = _dio.Dio();
          try {
            var response = await dio.post(
              'https://anchorageislamabad.com/api/complaint-message',
              options: _dio.Options(
                method: 'POST',
                headers: {
                  'Authorization': "Bearer $token",
                },
              ),
              data: data,
            );
            if (response.statusCode == 200) {
              Utils.showToast(
                response.data['message'],
                false,
              );
              btnController.stop();
              log(json.encode(response.data));

              Get.offNamed(AppRoutes.myComplaintsPage);
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

  changeComplaintType(value) {
    complaintType = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getPropertiesApi();
    // getComplainTypes();
  }
}

class PropertyName {
  final int id;
  final String name;
  PropertyName({
    required this.id,
    required this.name,
  });
}

class Complaint {
  final int id;
  final String title;
  final List<Map<String, dynamic>> findDepartments;

  Complaint({required this.id, required this.title, required this.findDepartments});
}
