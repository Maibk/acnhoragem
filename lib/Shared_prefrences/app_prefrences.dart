import 'dart:convert';
// import 'package:follow_the_arc/app/components/model_classes/ProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/ExtraPayLoad.dart';

class AppPreferences {
  //------------------------------------------------------------- Preference Constants ------------------------------------------------------------
  // Constants for Preference-Value's data-type
  static const String prefTypeBool = "BOOL";
  static const String prefTypeInteger = "INTEGER";
  static const String prefTypeDouble = "DOUBLE";
  static const String prefTypeString = "STRING";

  late Future _isPreferenceInstanceReady;
  late SharedPreferences _preferences;

  // static const String prefNotification = "NOTIFICATION";
  // static const String prefNotificationData = "USER_DETAILS";

  // Constants for Preference-Name
  static const String prefLanguage = "LANGUAGE";
  static const String prefFirstLogin = "FIRST_LOGIN";
  static const String prefShowOnBoarding = "SHOW_ONBOARDING";

  static const String prefLanguageSelected = "LANGUAGE_SELECTED";
  static const String prefUserToken = "USER_TOKEN";
  static const String prefVendorToken = "VENDOR_TOKEN";
  static const String prefCustomAddressId = "CUSTOMER_ADDRESS_ID";
  static const String prefUserData = "USER_DATA";
  static const String prefVendorData = "VENDOR_DATA";
  static const String prefIsVendorLoggedIn = "IS_VENDOR_LOGGED_IN";
  static const String prefCurrentApp = "CURRENT_APP";
  static const String prefDeviceToken = "DEVICE_TOKEN";
  static const String prefDeviceType = "DEVICE_TYPE";
  static const String prefStep1Data = "STEP1_DATA";

  static const String prefUserId = "USER_ID";
  static const String prefEmailForForgotPassword = "EMAIL_FOR_FORGOT_PASSWORD";
  static const String prefBrandId = "BRAND_ID";
  static const String prefBrandUserId = "BRAND_USER_ID";
  static const String prefUserName = "USER_NAME";
  static const String prefUserImage = "USER_IMAGE";
  static const String prefUserPhoneNumber = "USER_PHONE_NUMBER";
  static const String prefUserCity = "USER_CITY";
  static const String prefNotification = "NOTIFICATION";
  static const String prefPrivacyPolicy = "PRIVACY_POLICY";
  static const String prefUserDetails = "USER_DETAILS";
  static const String prefSocialUserDetails = "SOCIAL_USER_DETAILS";
  static const String prefBrandName = "BRAND_NAME";

  static const String prefAppleUserId = "APPLE_USER_ID";
  static const String prefAppleEmail = "APPLE_USER_ID";
  static const String prefAppleName = "APPLE_NAME";
  static const String prefAppleImage = "APPLE_IMAGE";

  static const String prefAccessToken = "ACCESS_TOKEN";
  static const String prefProfile = "PROFILE";
  static const String loginAttempt = "FIRST_LOGIN_ATTEMPT";
  static const String prefFcmToken = "FCM_TOKEN";
  static const String prefStoreId = "STORE_ID";
  static const String prefLoginType = "LOGIN_TYPE";
  static const String prefLoggedIn = "IS_LOGGED_IN";
  static const String prefLoginPlatform = "LOGIN_PLATFORM";
  static const String showUserQR = 'SHOW_QR';

  static const String prefRole = "ROLE";

  static const String prefHasNotification = "HAS_NOTIFICATION";
  static const String prefNotificationPayload = "NOTIFICATION_PAYLOAD";
  static const String prefFirebaseToken = "FIREBASE_TOKEN";
  static const String prefShowAdd = "SHOW_ADD";
  static const String prefGetIsNotification = "PREF_GET_IS_NOTIFICATION";
  static const String prefNotificationType = "PREF_NOTIFICATION_TYPE";
  static const String prefNotificationRefId = "PREF_NOTIFICATION_REF_ID";
  static const String prefNotificationId = "PREF_NOTIFICATION_ID";
  static const String prefNotificationData = "PREF_NOTIFICATION_DATA";
  static const String prefNotificationEventTitle = "PREF_NOTIFICATION_EVENT_TITLE";
  static const String prefPath = "PREF_PATH";

  static const String prefAppleModel = "PREF_APPLE_LOGIN_MODEL";

  //-------------------------------------------------------------------- Singleton ----------------------------------------------------------------------
  // Final static instance of class initialized by private constructor
  static final AppPreferences _instance = AppPreferences._internal();

  // Factory Constructor
  factory AppPreferences() => _instance;

  /// AppPreference Private Internal Constructor -> AppPreference
  /// @param->_
  /// @usage-> Initialize SharedPreference object and notify when operation is complete to future variable.
  AppPreferences._internal() {
    _isPreferenceInstanceReady = SharedPreferences.getInstance().then((preferences) => _preferences = preferences);
  }

  AppPreferences getAppPreferences() {
    return AppPreferences();
  }

  //------------------------------------------------------- Getter Methods -----------------------------------------------------------

  // GETTER for isPreferenceReady future
  Future get isPreferenceReady => _isPreferenceInstanceReady;

  //--------------------------------------------------- Public Preference Methods -------------------------------------------------------------
  void _removeValue(String key) {
    //Remove String
    _preferences.remove(key);
  }

  void setShowAdd({required bool showAdd}) => _setPreference(prefName: prefShowAdd, prefValue: showAdd, prefType: prefTypeBool);
  Future<String> getShowAdd() async => await _getPreference(prefName: prefShowAdd); // Check value for NULL. If NULL provide default value as FALSE.

  void setDeviceToken({required String deviceId}) => _setPreference(prefName: "deviceToken", prefValue: deviceId, prefType: prefTypeString);

  Future<String> getDeviceToken() async =>
      await _getPreference(prefName: "deviceToken"); // Check value for NULL. If NULL provide default value as FALSE.

  void setDeviceType({required String deviceType}) => _setPreference(
        prefName: prefDeviceType,
        prefValue: deviceType,
        prefType: prefTypeString,
      );

  Future<String> getDeviceType() async => await _getPreference(prefName: prefDeviceType);

  void setUserId({required String userId}) => _setPreference(prefName: prefUserId, prefValue: userId, prefType: prefTypeString);

  Future<String> getUserId() async => await _getPreference(prefName: prefUserId);

  void setUserName({required String userName}) => _setPreference(prefName: prefUserName, prefValue: userName, prefType: prefTypeString);

  Future<String> getUserName() async => await _getPreference(prefName: prefUserName);

  void setUserImage({required String userImage}) => _setPreference(prefName: prefUserImage, prefValue: userImage, prefType: prefTypeString);

  void setFirstLogin({required int firstLogin}) => _setPreference(prefName: prefFirstLogin, prefValue: firstLogin, prefType: prefTypeBool);

  void setShowOnBoarding({required bool showOnBoarding}) =>
      _setPreference(prefName: prefShowOnBoarding, prefValue: showOnBoarding, prefType: prefTypeBool);
  Future<bool> getShowOnBoarding() async => await _getPreference(prefName: prefShowOnBoarding);

  Future<bool> getFirstLogin() async => await _getPreference(prefName: prefFirstLogin);

  Future<String> getUserImage() async => await _getPreference(prefName: prefUserImage);

  void setNotification({required bool loggedIn}) => _setPreference(prefName: prefNotification, prefValue: loggedIn, prefType: prefTypeBool);

  Future<bool> getNotification() async {
    return await _getPreference(prefName: prefNotification);
  }

  void setPayload({required String? data}) => _setPreference(prefName: prefNotificationData, prefValue: data, prefType: prefTypeString);

  Future<ExtraPayload?> getPayload() async {
    if (_preferences.getString(prefNotificationData) == null) return null;

    Map<String, dynamic> payloadData = jsonDecode(_preferences.getString(prefNotificationData)!);
    print('map $payloadData');
    var payload = ExtraPayload.fromJson(payloadData);

    return payload;
  }

  void setRole({required String role}) => _setPreference(prefName: prefRole, prefValue: role, prefType: prefTypeString);

  Future<String> getRole() async => await _getPreference(prefName: prefRole);

  void setUserPhoneNumber({required String phoneNumber}) =>
      _setPreference(prefName: prefUserPhoneNumber, prefValue: phoneNumber, prefType: prefTypeString);

  Future<String> getUserPhoneNumber() async => await _getPreference(prefName: prefUserPhoneNumber);

  void setUserCity({required String city}) => _setPreference(prefName: prefUserCity, prefValue: city, prefType: prefTypeString);

  Future<String> getUserCity() async => await _getPreference(prefName: prefUserCity);

  void setBrandId({required String brandId}) => _setPreference(prefName: prefBrandId, prefValue: brandId, prefType: prefTypeString);

  Future<String> getBrandId() async => await _getPreference(prefName: prefBrandId);

  void setBrandUserId({required String brandId}) => _setPreference(prefName: prefBrandUserId, prefValue: brandId, prefType: prefTypeString);

  Future<String> getBrandUserId() async => await _getPreference(prefName: prefBrandUserId);

  void setBrandName({required String brandName}) => _setPreference(prefName: prefBrandName, prefValue: brandName, prefType: prefTypeString);

  Future<String> getBrandName() async => await _getPreference(prefName: prefBrandName);

  void setUserDetails({required String data}) => _setPreference(prefName: prefUserDetails, prefValue: data, prefType: prefTypeString);
  Future<String?> getUserDetail() async => await _getPreference(prefName: prefUserDetails);

  void setFirebaseToken({required String deviceId}) => _setPreference(prefName: prefFirebaseToken, prefValue: deviceId, prefType: prefTypeString);

  Future<String> getFirebaseToken() async =>
      await _getPreference(prefName: prefFirebaseToken); // Check value for NULL. If NULL provide default value as FALSE.

  void setAccessToken({required String token}) => _setPreference(prefName: prefAccessToken, prefValue: token, prefType: prefTypeString);
  Future<String?> getAccessToken({required prefName}) async => await _getPreference(prefName: prefAccessToken);

  void setProfileData({required String data}) => _setPreference(prefName: prefProfile, prefValue: data, prefType: prefTypeString);

  Future<String?> getProfileData() async => await _getPreference(prefName: prefProfile);

  void setUserEmail({required String email}) => _setPreference(prefName: 'prefEmail', prefValue: email, prefType: prefTypeString);

  void setUserEmailForForgotPassword({required String email}) =>
      _setPreference(prefName: prefEmailForForgotPassword, prefValue: email, prefType: prefTypeString);

  void setShowUserQR({required String value}) => _setPreference(prefName: showUserQR, prefValue: value, prefType: prefTypeString);
  Future<String> getUserQR() async => await _getPreference(prefName: showUserQR);

  void setUserLoggedIn({required String loginValue}) => _setPreference(prefName: loginAttempt, prefValue: loginValue, prefType: prefTypeString);
  Future<String> getUserLoggedIn() async => await _getPreference(prefName: loginAttempt);

  void setFcmToken({required String token}) => _setPreference(prefName: prefFcmToken, prefValue: token, prefType: prefTypeString);

  Future<String> getFcmToken() async => await _getPreference(prefName: prefFcmToken);

  Future<String> getUserEmail() async => await _getPreference(prefName: 'prefEmail');

  Future<String> getUserEmailForgotPassword() async => await _getPreference(prefName: prefEmailForForgotPassword);

  void setLoginPlatform({required String platform}) => _setPreference(prefName: prefLoginPlatform, prefValue: platform, prefType: prefTypeString);

  Future<String> getLoginPlatform() async => await _getPreference(prefName: prefLoginPlatform);

  void setIsLoggedIn({required bool loggedIn}) => _setPreference(prefName: prefLoggedIn, prefValue: loggedIn, prefType: prefTypeBool);

  Future<dynamic> getIsLoggedIn() async {
    return await _getPreference(prefName: prefLoggedIn);
  }

  void setHasNotification({required bool hasNotification}) =>
      _setPreference(prefName: prefHasNotification, prefValue: hasNotification, prefType: prefTypeBool);

  bool getHasNotification() {
    return _preferences.getBool(prefHasNotification) ?? false;
  }

  void setNotificationPayload({required String data}) => _setPreference(prefName: prefNotificationPayload, prefValue: data, prefType: prefTypeString);

  //
  // Future<ExtraPayload?> getNotificationPayload() async {
  //   if (_preferences.getString(prefNotificationPayload) == null) return null;
  //   Map<String, dynamic> userMap =
  //   jsonDecode(_preferences.getString(prefNotificationPayload)!);
  //   var userDetails = ExtraPayload.fromJson(userMap);
  //   return userDetails;
  // }

  Future<String> getPrefRole() async {
    return await _getPreference(prefName: prefRole);
  }

  void setAppleUserModel({required String data}) => _setPreference(prefName: prefAppleModel, prefValue: data, prefType: prefTypeString);

  // Future<AppleLoginModel?> getAppleUserModel() async {
  //   if (_preferences.getString(prefAppleModel) == null) return null;
  //   Map<String, dynamic> userMap =
  //       jsonDecode(_preferences.getString(prefAppleModel)!);
  //   var appleUserDetails = AppleLoginModel.fromJson(userMap);
  //   return appleUserDetails;
  // }

  //--------------------------------------------------- Private Preference Methods ----------------------------------------------------
  /// @usage -> This is a generalized method to set preferences with required Preference-Name(Key) with Preference-Value(Value) and Preference-Value's data-type.
  void _setPreference({required String prefName, required dynamic prefValue, required String prefType}) {
    // Make switch for Preference Type i.e. Preference-Value's data-type
    switch (prefType) {
      case prefTypeBool:
        {
          _preferences.setBool(prefName, prefValue);
          break;
        }
      case prefTypeInteger:
        {
          _preferences.setInt(prefName, prefValue);
          break;
        }
      case prefTypeDouble:
        {
          _preferences.setDouble(prefName, prefValue);
          break;
        }
      case prefTypeString:
        {
          _preferences.setString(prefName, prefValue);
          break;
        }
    }
  }

  Future<dynamic> _getPreference({required prefName}) async => _preferences.get(prefName);

  Future<bool> clearPreference() => _preferences.clear();
}
