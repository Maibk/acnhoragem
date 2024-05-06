import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../core/utils/color_constant.dart';
import '../widgets/custom_dialogue.dart';

class BaseviewAuthScreen extends StatelessWidget {
  BaseviewAuthScreen({this.child, this.image, this.imageShown, this.closeApp});

  Widget? child;
  bool? closeApp;
  bool? image;
  String? imageShown;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: ColorConstant.whiteA700,
          systemNavigationBarColor: ColorConstant.whiteA700,
          statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
          statusBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark),
    );

    return image == true
        ? Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // colorFilter: ColorFilter.mode(ColorConstant.gray900.withOpacity(0.5), BlendMode.hardLight),
                      image: AssetImage(imageShown!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Scaffold(
                  backgroundColor: Colors.transparent,
                  body: WillPopScope(
                      onWillPop: () async {
                        if (closeApp != null && closeApp != true) {
                          Get.back(); //SystemNavigator.pop();
                          return false;
                        } else {
                          return (await showDialog(
                                  context: context,
                                  builder: (ct) {
                                    return CustomDialogue(
                                      dialogueBoxHeading: 'Exit'.tr,
                                      dialogueBoxText: 'Are you sure want to Exit?'.tr,
                                      actionOnNo: () {
                                        Navigator.pop(ct);
                                      },
                                      actionOnYes: () {
                                        SystemNavigator.pop();
                                      },
                                    );
                                  })
                                  
                                  ) ??
                              false;
                        }
                      },
                      child: SafeArea(
                        child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(new FocusNode());
                            },
                            child: child!),
                      ))),
            ],
          )
        : Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: WillPopScope(
                onWillPop: () async {
                  if (closeApp != null && closeApp != true) {
                    Get.back(); //SystemNavigator.pop();
                    return false;
                  } else {
                    return (
                      
                      
                      await showDialog(
                            context: context,
                            builder: (ct) {
                              return CustomDialogue(
                                dialogueBoxHeading: 'Exit'.tr,
                                dialogueBoxText: 'Are you sure want to Exit?'.tr,
                                actionOnNo: () {
                                  Navigator.pop(ct);
                                },
                                actionOnYes: () {
                                  SystemNavigator.pop();
                                },
                              );
                            })) ??
                        false;
                  }
                },
                child: SafeArea(
                  child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      child: child!),
                )));
  }
}
