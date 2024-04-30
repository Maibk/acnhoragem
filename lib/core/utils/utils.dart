
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';

import '../../widgets/custom_toast.dart';
import 'color_constant.dart';



class Utils{


  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode()); //DateFormat('MMM/dd/yyyy').format(date);
  }
  static void showToast(String body,bool error){
    CustomToast().showToast(body, error);
  }

  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }



  static bool validateEmail(String email){
    if(email.isEmpty){
      CustomToast().showToast("Email can not be empty", true);
      return false;
    }else if(!email.isEmail){
      CustomToast().showToast("Email format is not correct", true);
      return false;
    }
    return true;
  }

  static bool validatePassword(String password){
    if(password.isEmpty){
      CustomToast().showToast("Password can not be empty", true);
      return false;
    }else if(password.length<8){
      CustomToast().showToast("Password must be 8 characters long", true);
      return false;
    }
    return true;
  }


  static String? otpValidate(String value) {
    if (value.isEmpty) {
      return "OTP is required";
    } else if (value.length < 4) {
      return "Kindly enter valid OTP Code";
    }
    return null;
  }

  static Future<void> clearLocalStorage() async {
    SharedPreferences storage=await SharedPreferences.getInstance();
    storage.clear();
  }

  // static Future<Map> getUserInfo() async {
  //   SharedPreferences storage=await SharedPreferences.getInstance();
  //   String? id=storage.getString(LocalDBKeys.USERID);
  //   String? token=storage.getString(LocalDBKeys.TOKEN);
  //
  //   return {
  //     "token": token,
  //     "id": id,
  //   };
  // }

  // 07: 00 am



  static String timeFormator(date){
    var time = TimeOfDay.fromDateTime(date);
    print(time.hourOfPeriod);
    print(time.minute);
    print(time.period.name);return '${time.hourOfPeriod <10 ? '0${time.hourOfPeriod}':time.hourOfPeriod} : ${time.minute < 10 ? '0${time.minute}':time.minute} ${time.period.name}';

  }

  // May 26, 07: 00 am
  // static String timeFormatorWithDate( String date){
  //   var a = DateTime.parse(date);
  //   var time = TimeOfDay.fromDateTime(a);
  //   var b = new DateFormat('MMM dd, hh:mm').format(a);
  //   print(time.hourOfPeriod);
  //   print(time.minute);
  //   print(time.period.name);
  //   return b.toString();
  // }

  // May 26, 07: 00 am
  // static String timeFormatorWithDate2( String date){
  //   var a = DateTime.parse(date);
  //   var time = TimeOfDay.fromDateTime(a);
  //   var b = new DateFormat('MMM dd, hh:mm aa').format(a);
  //   print(time.hourOfPeriod);
  //   print(time.minute);
  //   print(time.period.name);
  //   return b.toString();
  // }

  static void hideKeyboard(context) {
    FocusScope.of(context).unfocus();
  }







  // static String getMonth(date){
  //   DateTime dt = DateTime.parse(date);
  //   String formattedDate = DateFormat('dd MMM').format(dt);
  //   return formattedDate;
  // }
  //


  static String getFormatedDate(String date){
    print('abcd $date');
    DateTime dateTime = DateTime.parse(date);
    print(dateTime);
    String formattedDate = DateFormat('dd/MMM/yyyy').format(dateTime);
    return formattedDate;
  }

  static void showBottomSheet(context,
      {double? bottomSheetHeight,
        double? spaceBetween,
        double? radius,
        bool? redclrEndTask,
        bool? isLeftPadding = true,
        bool? isPadding,
        String? screenTitle,
        String? suffixIconImg,
        String? prefixIconImg,
        Function? onTap,
        bool? isScrollControlled,
        Color? color,
        Widget? save,
        Widget? widget}) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: color ?? ColorConstant.apppinkColor,
      //  barrierColor: Colors.black.withOpacity(0.75),
        enableDrag: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(radius ?? 15.0),
              topLeft: Radius.circular(radius ?? 15.0)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return  SingleChildScrollView(
            child: Container(
              height: bottomSheetHeight ?? 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: DarkThemeColors.greyColor,
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(10)
                  //          ),
                  //     ),
                  //     height: 10,
                  //     width: 50,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 20, left: 25, right: 20),
                  //   child: Row(
                  //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       SvgPicture.asset(prefixIconImg!,
                  //         color: DarkThemeColors.yellowColor,
                  //         height: 20.0,),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 12.0),
                  //         child: Text(
                  //           '${screenTitle ?? 'Screen Name'}',
                  //           style: MyStyles.getRegularTextStyle(fontSize: 16.0.sp).copyWith(color: DarkThemeColors.whiteColor),
                  //         ),
                  //       ),
                  //       Spacer(),
                  //       GestureDetector(
                  //           onTap: () {
                  //             if (onTap != null) {
                  //               onTap();
                  //             } else {
                  //               Get.back();
                  //             }
                  //           },
                  //           child: SvgPicture.asset(suffixIconImg!,
                  //             height: 20.0,),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: isLeftPadding == false ? 0 : 0, right: 0),
                        child: widget ?? Container(),
                      )),
                ],
              ),
            ),
          );

        });
  }



  //
  // static String relativeTime(date){
  //   DateTime dt = DateTime.parse(date);
  //   return Jiffy("${dt.year}-${dt.month}-${dt.day}", "yyyy-MM-dd").fromNow();
  // }

  // static void launchUrl(String url) async {
  //   debugPrint('_url $url');
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     Utils.showToast('Invalid URL', true);
  //   }
  // }

}