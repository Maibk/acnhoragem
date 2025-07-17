import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/core/utils/image_gallery.dart';
import 'package:anchorageislamabad/presentation/complaints_screen/models/complaints_model.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:anchorageislamabad/widgets/custom_textfield_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/animated_custom_button.dart';
import '../../widgets/common_image_view.dart';
import 'controller/complaints_controller.dart';

class CreateNewComplaintScreen extends StatefulWidget {
  @override
  State<CreateNewComplaintScreen> createState() => _CreateNewComplaintScreenState();
}

class _CreateNewComplaintScreenState extends State<CreateNewComplaintScreen> {
  ComplaintsController controller = Get.put(ComplaintsController());
  final ImageGalleryClass imageGalleryClass = ImageGalleryClass();

  @override
  initState() {
    controller.getComplainTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'), // Replace 'assets/background_image.jpg' with your image path
          fit: BoxFit.cover, // Adjust as needed
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Colors.transparent,
          title: MyText(
            title: "Complaint",
            clr: ColorConstant.whiteA700,
            fontSize: 20,
            customWeight: FontWeight.w500,
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.white)),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Get.toNamed(AppRoutes.menuPage);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: getPadding(left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Padding(
                  padding: getPadding(all: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // MyText(title: "Monday Mon-03-2024 10:12 PM",clr: ColorConstant.apppWhite,fontSize: 12,),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.apppWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: double.infinity,
                        padding: getPadding(left: 30, right: 30, top: 20, bottom: 20),
                        child: GetBuilder(
                            init: controller,
                            builder: (_) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 90.h,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: (controller.complaintsImages != null && controller.complaintsImages!.isNotEmpty)
                                            ? Image.file(
                                                controller.complaintsImages!.first,
                                                fit: BoxFit.fitWidth,
                                              )
                                            : MyText(title: "Select Image to upload"),
                                      ),
                                      (controller.complaintsImages != null && controller.complaintsImages!.isNotEmpty)
                                          ? GestureDetector(
                                              onTap: () async {
                                                controller.complaintsImages?.clear();
                                                imageGalleryClass.imageGalleryBottomSheet(
                                                  context: context,
                                                  onCameraTap: () async {
                                                    final List<File> result = await imageGalleryClass.getImages(
                                                      source: ImageSource.camera,
                                                    );

                                                    if (result.isNotEmpty) {
                                                      controller.complaintsImages = result;
                                                    }

                                                    setState(() {});
                                                    Get.back();
                                                  },
                                                  onGalleryTap: () async {
                                                    final List<File> result = await imageGalleryClass.getImages(
                                                      source: ImageSource.gallery,
                                                    );

                                                    if (result.isNotEmpty) {
                                                      controller.complaintsImages = result;
                                                    }

                                                    setState(() {});
                                                    Get.back();
                                                  },
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.check_circle_outline_outlined,
                                                  color: ColorConstant.anbtnBlue,
                                                  size: 55,
                                                ),
                                              ),
                                            )
                                          : Positioned(
                                              bottom: -15, // Position halfway up the image

                                              child: GestureDetector(
                                                  onTap: () async {
                                                    imageGalleryClass.imageGalleryBottomSheet(
                                                      context: context,
                                                      onCameraTap: () async {
                                                        final List<File> result = await imageGalleryClass.getImages(
                                                          source: ImageSource.camera,
                                                        );

                                                        if (result.isNotEmpty) {
                                                          controller.complaintsImages = result;
                                                        }

                                                        setState(() {});
                                                        Get.back();
                                                      },
                                                      onGalleryTap: () async {
                                                        final List<File> result = await imageGalleryClass.getImages(
                                                          source: ImageSource.gallery,
                                                        );

                                                        if (result.isNotEmpty) {
                                                          controller.complaintsImages = result;
                                                        }

                                                        setState(() {});
                                                        Get.back();
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(color: ColorConstant.anbtnBlue, shape: BoxShape.circle),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: ColorConstant.whiteA700,
                                                      size: 45,
                                                    ),
                                                  )),
                                            ),
                                    ],
                                  ),
                                  SizedBox(height: getVerticalSize(10)),
                                  MyText(title: "Select Property", fontSize: 12.h),
                                  SizedBox(height: getVerticalSize(10)),
                                  Container(
                                    width: Get.width,
                                    color: Colors.white,
                                    child: DropdownButton<PropertyName>(
                                      isExpanded: true,
                                      value: controller.selectedProperty,
                                      items: controller.propertyNames.map((property) {
                                        return DropdownMenuItem(
                                          value: property,
                                          child: Text(
                                            property.name,
                                            style: TextStyle(fontSize: 12.h),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          controller.selectedProperty = newValue;

                                          controller.propertyId = newValue?.id ?? 0;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height: getVerticalSize(10)),
                                  MyText(title: "Complaint Category", fontSize: 12.h),
                                  SizedBox(height: getVerticalSize(10)),
                                  Container(
                                    width: Get.width,
                                    child: DropdownButton<CompliantTypesData>(
                                      isExpanded: true,
                                      value: controller.selectedComplaint,
                                      items: controller.complaints.map((complaint) {
                                        return DropdownMenuItem(
                                          value: complaint,
                                          child: Text(
                                            complaint.title ?? "",
                                            style: TextStyle(fontSize: 12.h),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          controller.selectedComplaint = newValue;
                                          controller.selectedDepartment = null;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  MyText(title: "Complaint Type", fontSize: 12.h),
                                  Container(
                                    width: Get.width,
                                    child: DropdownButton<FindDepartments>(
                                      isExpanded: true,
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      value: controller.selectedDepartment,
                                      style: TextStyle(fontSize: 10, color: Colors.black),
                                      items: controller.selectedComplaint?.findDepartments!.map((department) {
                                        return DropdownMenuItem(
                                          value: department,
                                          child: Text(
                                            department.title ?? "",
                                            style: TextStyle(fontSize: 12.h),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (FindDepartments? newValue) {
                                        setState(() {
                                          controller.selectedDepartment = newValue;
                                          log(newValue!.id.toString());
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height: getVerticalSize(10)),
                                  MyText(title: "Description", fontSize: 12),
                                  SizedBox(height: getVerticalSize(10)),
                                  CustomTextField(
                                    fieldText: "Enter Description".tr,
                                    controller: controller.descriptionController,
                                    isFinal: false,
                                    maxLines: 2,
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    keyboardType: TextInputType.emailAddress,
                                    limit: 250,
                                    validator: (value) {
                                      return HelperFunction.empthyFieldValidator(value!);
                                    },
                                  ),
                                  SizedBox(height: getVerticalSize(15)),
                                  MyAnimatedButton(
                                    radius: 5.0,
                                    height: getVerticalSize(45),
                                    width: getHorizontalSize(400),
                                    fontSize: 16,
                                    bgColor: ColorConstant.anbtnBlue,
                                    controller: controller.btnController,
                                    title: "Submit".tr,
                                    onTap: () async {
                                      controller.submitComplaint(context, controller.propertyId);
                                    },
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: getVerticalSize(16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowLeft() {
    Get.back();
  }
}
