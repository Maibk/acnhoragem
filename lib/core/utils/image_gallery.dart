import 'dart:io';

import 'package:anchorageislamabad/core/utils/color_constant.dart';
import 'package:anchorageislamabad/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageGalleryClass {
  ImagePicker picker = ImagePicker();
  XFile? getFilePath;
  File? imageFile;

  //Select Image Start
  void imageGalleryBottomSheet(
      {required BuildContext context, bool? showVideo = false, VoidCallback? onCameraTap, VoidCallback? onVideoTap, VoidCallback? onGalleryTap}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: ColorConstant.whiteA700, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: onCameraTap,
                  child: Container(
                    color: ColorConstant.whiteA700,
                    margin: const EdgeInsets.only(top: 15.0, bottom: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(
                          Icons.camera_enhance,
                          color: ColorConstant.anblueText,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          "Camera",
                          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                          textScaleFactor: 1.3,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: ColorConstant.primaryColor.withOpacity(0.3),
                  thickness: 1,
                ),
                GestureDetector(
                  onTap: onGalleryTap,
                  child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(top: 9.0, bottom: 15.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(
                          Icons.image,
                          color: ColorConstant.anblueText,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                          textScaleFactor: 1.3,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<XFile?> getImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        return pickedFile;
      } else {
        Utils.showToast("Image selection cancelled", false); // or any custom feedback
      }
    } on PlatformException catch (e) {
      Utils.showToast(e.message ?? "Something went wrong", true);
    }

    return null;
  }

  Future<String?> getVideo() async {
    try {
      getFilePath = await picker.pickVideo(
        source: ImageSource.gallery,
      );
      if (getFilePath != null) {
        print("getFilePath!.path gallery");
        print(getFilePath!.path);
        return getFilePath!.path;
      }
    } on PlatformException catch (e) {
      Utils.showToast(e.message ?? "Something went wrong", true);
    }
    return null;
  }
}
