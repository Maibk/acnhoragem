import 'package:anchorageislamabad/core/utils/size_utils.dart';
import 'package:anchorageislamabad/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_toast.dart';
import 'color_constant.dart';

class HelperFunction {
  static String? emailValidate(String val) {
    if (val.isEmpty) {
      return 'Email is required';
    } else if (val.isEmail == false) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  static String? validateAlphabetsOnly(String? value) {
    final RegExp alphabetRegex = RegExp(r'^[a-zA-Z ]+$');

    if (value == null || value.isEmpty) {
      return "Field cannot be empty";
    } else if (!alphabetRegex.hasMatch(value)) {
      return 'Only alphabets are allowed';
    }
    return null; // Valid input
  }

  static String? validatePakistaniPhoneNumber(String? value) {
    final RegExp phoneRegex = RegExp(r'^03\d{9}$');

    if (value == null || value.isEmpty) {
      return "Field cannot be empty";
    } else if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number (e.g., 03001234567)';
    }
    return null; // Valid input
  }

  static String? otpvalidate(String val) {
    if (val.isEmpty) {
      return 'OTP is required';
    } else if (val.length < 4) {
      return 'Your otp must be 4 digits long.';
    } else {
      return null;
    }
  }

  bool isText(String? inputString, {bool isRequired = false}) {
    bool isInputStringValid = false;

    if ((inputString == null ? true : inputString.isEmpty) && !isRequired) {
      isInputStringValid = true;
    }

    if (inputString != null) {
      // const pattern = r'^[a-zA-Z]+$';
      const pattern = r'[a-zA-Z][a-zA-Z ]+[a-zA-Z]$';
      final regExp = RegExp(pattern);

      isInputStringValid = regExp.hasMatch(inputString);
    }

    return isInputStringValid;
  }

  static String? stringValidate(val, {fieldName}) {
    if (val.isEmpty || val == '') {
      return '${fieldName ?? 'Field'} is required';
    } else {
      return null;
    }
  }

  static String? stringValidateWithLImit(val, limit, {fieldName}) {
    if (val.isEmpty || val == '') {
      return '${fieldName ?? 'Field'} cannot be empty';
    } else if (val.toString().length > limit) {
      return 'Character limit exceeded';
    } else {
      return null;
    }
  }

  static String? fullNameFieldValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Full name field cannot be empty";
    } else if (value.length > 50) {
      return 'Full Name cannot be greater than 25 characters';
    } else {
      return null;
    }
  }

  static String? empthyFieldValidator(String value) {
    if (value.isEmpty || value == "") {
      return "Field cannot be empty";
    }
  }

  static String? passwordValidate(String value, {bool isConfirmPassword = false, String? password}) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    if (value.isEmpty || value == "") {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password is really short please enter at least 8 character.";
    }
    if (!regex.hasMatch(value)) {
      return 'Please enter at least one character uppercase,\none lower case,one special character and one digit';
      // return 'Weak password please enter at least one character uppercase,\none lower case,one special character and one digit';
    }
    if (isConfirmPassword) {
      if (value != password) {
        return "Password and confirm password do not match";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static String? passwordValidateStrong(String value) {
    //r'^
    //   (?=.*[A-Z])       // should contain at least one upper case
    //   (?=.*[a-z])       // should contain at least one lower case
    //   (?=.*?[0-9])      // should contain at least one digit
    //   (?=.*?[!@#\$&*~]) // should contain at least one Special character
    //   .{6,}             // Must be at least 8 characters in length
    // $
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

    if (value.isEmpty || value == "") {
      return "Password field cannot be empty";
    }
    if (value.length < 6) {
      return "Password is really short please enter at least 6 characters.";
    }
    if (!regex.hasMatch(value)) {
      return 'Please enter at least one character uppercase,\none lower case,one special character and one digit';
      // return 'Weak password please enter at least one character uppercase,\none lower case,one special character and one digit';
    } else {
      return null;
    }
  }

  static bool showPassword(bool value) {
    if (value == true) {
      return false;
    } else {
      return true;
    }
  }

  static void showBottomSheet(context,
      {double? bottomSheetHeight, double? spaceBetween, double? radius, String? screenTitle, Widget? save, Widget? widget}) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(radius ?? 30.0), topLeft: Radius.circular(radius ?? 30.0)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Container(
              height: bottomSheetHeight ?? 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: MyText(
                            title: 'Cancel',
                            fontSize: 15,
                            clr: ColorConstant.secondaryTextColor,
                          )),
                      MyText(
                        title: '${screenTitle ?? 'Screen Name'}',
                        customWeight: FontWeight.w700,
                      ),
                      if (save == null)
                        MyText(
                          title: 'Cancel',
                          fontSize: 15,
                          clr: Colors.transparent,
                        ),
                      if (save != null) save
                    ],
                  ),
                  SizedBox(
                    height: spaceBetween ?? 20,
                  ),
                  Expanded(child: widget ?? Container()),
                ],
              ),
            ),
          );
        });
  }

  static bool validateEmail(String email) {
    if (email.isEmpty) {
      CustomToast().showToast("Email can not be empty", true);
      return false;
    } else if (!email.isEmail) {
      CustomToast().showToast("Email format is not correct", true);
      return false;
    }
    return true;
  }

  static bool validatePassword(String password) {
    if (password.isEmpty) {
      CustomToast().showToast("Password can not be empty", true);
      return false;
    } else if (password.length < 8) {
      CustomToast().showToast("Password must be 8 characters long", true);
      return false;
    }
    return true;
  }

  static Color getHashColor({String? color}) {
    Color hashColor;
    int tempColor = int.parse(color!.replaceFirst("#", "0xff"));
    hashColor = Color(tempColor);
    return hashColor;
  }

  static Future<void> clearLocalStorage() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.clear();
  }

  static showBottomSheet2(context, {double? bottomSheetHeight, String? screenTitle, Widget? save, Widget? apply, Widget? widget}) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        useRootNavigator: true,
        builder: (BuildContext bc) {
          return Wrap(
            children: [
              Padding(
                padding: getPadding(left: 20, right: 20, bottom: 20, top: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: MyText(
                          title: 'Cancel',
                          fontSize: 16,
                          clr: ColorConstant.appDescriptionTextColor,
                        )),
                    MyText(
                      title: '${screenTitle ?? 'Screen Name'}',
                      customWeight: FontWeight.w500,
                      fontSize: 18,
                    ),

                    ///putting this widget due to balancing the size of row
                    save != null
                        ? save
                        : apply != null
                            ? apply
                            : MyText(
                                title: 'Cancel',
                                fontSize: 16,
                                clr: Colors.transparent,
                              ),
                  ],
                ),
              ),
              Padding(
                padding: getPadding(left: 20, right: 20),
                child: widget ?? Container(),
              ),
            ],
          );
        });
  }

  // static Future<Map> getUserInfo() async {
  //   SharedPreferences storage = await SharedPreferences.getInstance();
  //   String? id = storage.getString(LocalDBKeys.USERID);
  //   String? token = storage.getString(LocalDBKeys.TOKEN);
  //
  //   return {
  //     "token": token,
  //     "id": id,
  //   };
  // }

  static const double FULL_SCREEN_SIZE = 100.0;
  static const int EMAIL_VALIDATION = 50;
  static const int NAME_VALIDATION = 50;
  static const int ADDRESS_VALIDATION = 150;
  static const int PASSWORD_VALIDATION = 15;
  static const int DESCRIPTION_VALIDATE = 250;

//  Forms padding
  static const double FORM_PADDING = 10.0;
  static const double FORM_PADDING2 = 15.0;

//  Screens padding
  static const double SCREENS_SIDE_PADDING = 5.0;

  static const double TITLE_TEXT_SIZE = 16.0;
}
