import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CustomController extends GetxController {
  Rx<File> image = File("").obs;

  Future imgFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      // Handle the case where the user cancels the image picking process.
      // You may want to show a message or take some other action.
    }
  }

  Future imgFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      // Handle the case where the user cancels the image picking process.
      // You may want to show a message or take some other action.
    }
  }


  // Future imgFromCamera() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
  //   image.value = File(pickedFile!.path);
  // }
  //
  // Future imgFromGallery() async {
  //   final pickedFile =
  //   await ImagePicker().pickImage(source: ImageSource.gallery);
  //   image.value = File(pickedFile!.path);
  // }

}