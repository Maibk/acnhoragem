import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import '../../widgets/custom_text.dart';
import 'color_constant.dart';
import 'helper_functions.dart';

class FileManager {
  showModelSheetForImage(
      {int maxFileSize = 10 * 1024,
        List<String> allowedExtensions = const ['jpg', 'pdf', 'doc'],
        void Function(List<String?>)? getImages}) async {
    await HelperFunction.showBottomSheet2(
      Get.context,
      screenTitle: 'Post Image',
      widget : SafeArea(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () async {
              List<String?> imageList =
              await imgFromGallery(maxFileSize, allowedExtensions);
              if (getImages != null) {
                getImages(imageList,);
              }
              Get.back();
            },
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: ColorConstant.appDescriptionTextColor,
                  radius: 30,
                  child: Icon(
                    Icons.image,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                MyText(title: 'Gallery')
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              List<String?> imageList =
              await imgFromCamera(maxFileSize, allowedExtensions);
              if (getImages != null) {
                getImages(imageList);
              }
              Get.back();
            },
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: ColorConstant.appDescriptionTextColor,
                  radius: 30,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                MyText(title: 'Camera')
              ],
            ),
          ),
        ],
      ),),

    );
  }

  Future<List<String?>> imgFromGallery(
      int maxFileSize, List<String>? allowedExtensions) async {
    List<String?> files = [];
    List<Media>? res1 = await ImagesPicker.pick(
        pickType: PickType.image,
        maxSize: maxFileSize,
        count: 10,
        cropOpt: CropOption());
    res1?.forEach((element) {
      var extension = element.path.split('.');
      if (allowedExtensions != null && allowedExtensions.isNotEmpty) {
        print("image path ${element.path}");
        if (allowedExtensions.contains(extension.last)) {
          files.add(element.path);
          print("image path ${element.path}");
        } else {
          Get.snackbar('msg', 'only $allowedExtensions images are allowed');
        }
      } else {
        files.add(element.path);
      }
    });
    return files;
  }

  Future<List<String?>> imgFromCamera(
      int maxFileSize, List<String>? allowedExtensions) async {
    List<String?> files = [];
    List<Media>? res1 = await ImagesPicker.openCamera(
        pickType: PickType.image, maxSize: maxFileSize, cropOpt: CropOption());
    res1?.forEach((element) {
      var extension = element.path.split('.');
      print("image path ${element.path}");
      if (allowedExtensions != null && allowedExtensions.isNotEmpty) {
        if (allowedExtensions.contains(extension.last)) {
          print("image path ${element.path}");
          files.add(element.path);
        } else {
          print("image path ${element.path}");
          Get.snackbar('msg', 'only $allowedExtensions images are allowed');
        }
      } else {
        files.add(element.path);
      }
    });
    return files;
  }

  bool checkExtension(String imageUrls){
    return (imageUrls.endsWith('MOV') || imageUrls.endsWith('mov') || imageUrls.endsWith('MP4') || imageUrls.endsWith('mp4') || imageUrls.endsWith('AVI') || imageUrls.endsWith('avi'));
  }




}
