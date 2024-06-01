import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/core/utils/utils.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/app_fonts.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/animated_custom_button.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_expensiontile.dart';
import '../../widgets/custom_textfield_new.dart';
import 'controller/entryforms_controller.dart';

class EntryFormsScreen extends StatefulWidget {
  @override
  State<EntryFormsScreen> createState() => _EntryFormsScreenState();
}

class _EntryFormsScreenState extends State<EntryFormsScreen> {
  EntryFormsController controller = Get.put(EntryFormsController());

  @override
  void initState() {
    controller.childDataIndex = 0;
    controller.spouseDataIndex = 0;
    controller.ownerImage = null;
    controller.ownerCnicFront = null;
    controller.ownerCnicBack = null;
    controller.childImage = null;
    controller.childCnicFront = null;
    controller.childCnicBack = null;

    super.initState();
  }

  // const DiscoverScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('assets/images/background.png'), // Replace 'assets/background_image.jpg' with your image path
          fit: BoxFit.cover, // Adjust as needed
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Colors.transparent,
          title: MyText(
            title: "Entry Card",
            clr: ColorConstant.whiteA700,
            fontSize: 20,
            customWeight: FontWeight.w500,
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.myformsPage);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Get.toNamed(AppRoutes.menuPage);
              },
            ),
          ],
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: getPadding(left: 10),
          child: Column(
            children: [
              GetBuilder(
                  init: controller,
                  builder: (_value) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: getPadding(all: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: getVerticalSize(10),
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: MyText(
                                    title: "Record Form",
                                    fontSize: 16,
                                    clr: ColorConstant.apppWhite,
                                  )),
                              SizedBox(
                                height: getVerticalSize(10),
                              ),
                              Form(
                                key: controller.EntryCardFormKey,
                                child: CustomExpansionTile(
                                  title: MyText(
                                    title: 'OWNER INFORMATION',
                                    clr: ColorConstant.black900,
                                    fontSize: 16,
                                  ),
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        CustomTextField(
                                          fieldText: "Full Name".tr,
                                          controller: controller.fullNameController,
                                          isFinal: false,
                                          keyboardType: TextInputType.emailAddress,
                                          limit: HelperFunction.EMAIL_VALIDATION,
                                          validator: (value) {
                                            return HelperFunction.empthyFieldValidator(value!);
                                          },
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(5),
                                        ),
                                        CustomTextField(
                                          fieldText: "Father’s Name".tr,
                                          controller: controller.fathersController,
                                          isFinal: false,
                                          keyboardType: TextInputType.emailAddress,
                                          limit: HelperFunction.EMAIL_VALIDATION,
                                          validator: (value) {
                                            return HelperFunction.empthyFieldValidator(value!);
                                          },
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(5),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "CNIC No.".tr,
                                                controller: controller.cnicController,
                                                isFinal: false,
                                                keyboardType: TextInputType.phone,
                                                limit: HelperFunction.EMAIL_VALIDATION,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  TextInputFormatterWithPattern('#####-#######-#'),
                                                ],
                                                validator: (value) {
                                                  return HelperFunction.empthyFieldValidator(value!);
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Mobile number".tr,
                                                controller: controller.mobileController,
                                                isFinal: false,
                                                keyboardType: TextInputType.phone,
                                                validator: (value) {
                                                  return HelperFunction.empthyFieldValidator(value!);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(5),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: getHorizontalSize(330),
                                              child: DropdownButton(
                                                isExpanded: true,
                                                padding: EdgeInsets.symmetric(horizontal: 2),
                                                hint: controller.selectedValue == null
                                                    ? Text(
                                                        "Block/COMM ",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: ColorConstant.blackColor.withOpacity(0.5),
                                                          fontFamily: AppFonts.lucidaBright,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      )
                                                    : Text(controller.selectedValue.toString()),
                                                value: controller.selectedValue,
                                                disabledHint: Text(
                                                  "  ",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: ColorConstant.blackColor.withOpacity(0.5),
                                                    fontFamily: AppFonts.lucidaBright,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                items: controller.block.map((item) {
                                                  return DropdownMenuItem<int>(
                                                    value: item['id'],
                                                    child: Text(item['title']),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    controller.selectedValue = value!;
                                                    controller.streets.clear();
                                                    controller.plots.clear();
                                                    controller.getStreetByBlock(value);
                                                  });
                                                },
                                              ).paddingOnly(left: 12),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: getVerticalSize(5),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GetBuilder(
                                                init: controller,
                                                builder: (context) {
                                                  return Expanded(
                                                      child: DropdownButton<Street>(
                                                    hint: controller.streetSelectedValue == null
                                                        ? Text(
                                                            "Select Street",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: ColorConstant.blackColor.withOpacity(0.5),
                                                              fontFamily: AppFonts.lucidaBright,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          )
                                                        : Text(controller.selectedValue.toString()),
                                                    value: controller.streetSelectedValue,
                                                    disabledHint: Text(
                                                      "Select Street",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: ColorConstant.blackColor.withOpacity(0.5),
                                                        fontFamily: AppFonts.lucidaBright,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    items: controller.streets.map((item) {
                                                      return DropdownMenuItem<Street>(
                                                        value: item,
                                                        child: Text(item.title.toString()),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        controller.streetSelectedValue = value;
                                                        controller.plots.clear();
                                                        controller.getPlotNoByStreet(value!.id);
                                                      });
                                                    },
                                                  ).paddingOnly(left: 12));
                                                }),
                                            GetBuilder(
                                                init: controller,
                                                builder: (context) {
                                                  return Expanded(
                                                      child: DropdownButton<Plots>(
                                                    hint: controller.plotstSelectedValue == null
                                                        ? Text(
                                                            controller.plots.isEmpty
                                                                ? "Select Plot"
                                                                : controller.plotPlaceHolder,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: ColorConstant.blackColor.withOpacity(0.5),
                                                              fontFamily: AppFonts.lucidaBright,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          )
                                                        : Text(controller.plotstSelectedValue.toString()),
                                                    value: controller.plotstSelectedValue,
                                                    disabledHint: Text(
                                                      controller.plots.isEmpty
                                                          ? "Select Plot"
                                                          : controller.plotPlaceHolder,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: ColorConstant.blackColor.withOpacity(0.5),
                                                        fontFamily: AppFonts.lucidaBright,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    items: controller.plots.map((item) {
                                                      return DropdownMenuItem<Plots>(
                                                        value: item,
                                                        child: Text(item.title.toString()),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        controller.plotstSelectedValue = value;
                                                      });
                                                    },
                                                  ).paddingOnly(left: 12));
                                                })
                                          ],
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(5),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Road".tr,
                                                controller: controller.roadController,
                                                isFinal: false,
                                                keyboardType: TextInputType.emailAddress,
                                                validator: (value) {
                                                  return HelperFunction.empthyFieldValidator(value!);
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Colony/Residential Area Name".tr,
                                                controller: controller.colonyController,
                                                isFinal: false,
                                                keyboardType: TextInputType.emailAddress,
                                                validator: (value) {
                                                  return HelperFunction.empthyFieldValidator(value!);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(15),
                                        ),
                                        Padding(
                                          padding: getPadding(left: 10, right: 10),
                                          child: CustomButton(
                                            width: getHorizontalSize(350),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstant.whiteA700,
                                            label: "Attach a clear image of yours".tr,
                                            textColor: ColorConstant.anbtnBlue,
                                            borderColor: ColorConstant.anbtnBlue,
                                            prefix: Icon(
                                              controller.ownerImage != null
                                                  ? Icons.check_circle_sharp
                                                  : Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                              size: 19.r,
                                            ),
                                            onPressed: () async {
                                              controller.ownerImage = await controller.imagePicker();
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(15),
                                        ),
                                        Padding(
                                          padding: getPadding(left: 10, right: 10),
                                          child: CustomButton(
                                            width: getHorizontalSize(350),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstant.whiteA700,
                                            label: "Attach a clear image of your CNIC front side".tr,
                                            textColor: ColorConstant.anbtnBlue,
                                            borderColor: ColorConstant.anbtnBlue,
                                            prefix: Icon(
                                              controller.ownerCnicFront != null
                                                  ? Icons.check_circle_sharp
                                                  : Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                              size: 19.r,

                                            ),
                                            onPressed: () async {
                                              controller.ownerCnicFront = await controller.imagePicker();
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(15),
                                        ),
                                        Padding(
                                          padding: getPadding(left: 10, right: 10),
                                          child: CustomButton(
                                            width: getHorizontalSize(350),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstant.whiteA700,
                                            label: "Attach a clear image of your CNIC back side".tr,
                                            textColor: ColorConstant.anbtnBlue,
                                            borderColor: ColorConstant.anbtnBlue,
                                            prefix: Icon(
                                              controller.ownerCnicBack != null
                                                  ? Icons.check_circle_sharp
                                                  : Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                              size: 19.r,
                                              
                                            ),
                                            onPressed: () async {
                                              controller.ownerCnicBack = await controller.imagePicker();
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(15),
                                        ),
                                        // Padding(
                                        //   padding: getPadding(left: 10, right: 10),
                                        //   child: MyAnimatedButton(
                                        //     radius: 5.0,
                                        //     height: getVerticalSize(50),
                                        //     width: getHorizontalSize(400),
                                        //     fontSize: 16,
                                        //     bgColor: ColorConstant.anbtnBlue,
                                        //     controller: controller.btnController,
                                        //     title: "Add Owner Information".tr,
                                        //     // onTap: () async {
                                        //     //   // controller.loginAPI(context);
                                        //     // },

                                        //     onTap: () async {
                                        //       if (controller.ownerImage == null) {
                                        //         Utils.showToast(
                                        //           "Please select image of yours",
                                        //           true,
                                        //         );
                                        //       } else if (controller.ownerCnicFront ==
                                        //           null) {
                                        //         Utils.showToast(
                                        //           "Please select image of your CNIC front side",
                                        //           true,
                                        //         );
                                        //       } else if (controller.ownerCnicBack ==
                                        //           null) {
                                        //         Utils.showToast(
                                        //           "Please select image of your CNIC back side",
                                        //           true,
                                        //         );
                                        //       } else {
                                        //         controller.SubmitEntryFormApi(context);
                                        //       }
                                        //     },
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: getVerticalSize(20),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getVerticalSize(10),
                              ),
                              GetBuilder(
                                  init: controller,
                                  builder: (context) {
                                    return Form(
                                      key: controller.spouseEntryFormKey,
                                      child: CustomExpansionTile(
                                        title: MyText(
                                          title: 'Spouse',
                                          // title: controller.spouseImages.length.toString(),
                                          clr: ColorConstant.black900,
                                          fontSize: 16,
                                        ),
                                        children: <Widget>[
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: controller.spousefullNameControllers.length == 0
                                                ? 1
                                                : controller.spousefullNameControllers.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  // if (controller.spouseDataIndex != 0)
                                                  //   Row(
                                                  //     mainAxisAlignment: MainAxisAlignment.start,
                                                  //     children: [
                                                  //       Container(
                                                  //         margin: EdgeInsets.only(left: 15),
                                                  //         padding: EdgeInsets.all(10),
                                                  //         decoration: BoxDecoration(
                                                  //             color: Colors.green, shape: BoxShape.circle),
                                                  //         child: MyText(
                                                  //           title: controller.spouseDataIndex.toString(),
                                                  //           clr: ColorConstant.whiteA700,
                                                  //           fontSize: 16,
                                                  //         ),
                                                  //       ),
                                                  //     ],
                                                  //   ),

                                                  if (index != 0)
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              controller.spousefullNameControllers.removeAt(index);
                                                            });
                                                          },
                                                          child: Container(
                                                              margin: EdgeInsets.only(right: 15),
                                                              padding: EdgeInsets.all(8),
                                                              decoration: BoxDecoration(
                                                                  color: Colors.red, shape: BoxShape.circle),
                                                              child: Icon(
                                                                Icons.delete_outlined,
                                                                color: Colors.white,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  CustomTextField(
                                                      fieldText: "Full Name".tr,
                                                      controller: controller.spousefullNameControllers[index],
                                                      isFinal: false,
                                                      keyboardType: TextInputType.emailAddress,
                                                      limit: HelperFunction.EMAIL_VALIDATION,
                                                      validator: (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }),
                                                  // SizedBox(
                                                  //   height: getVerticalSize(5),
                                                  // ),
                                                  // CustomTextField(
                                                  //     fieldText: "Father’s Name".tr,
                                                  //     controller: controller.spousefathersControllers[index],
                                                  //     isFinal: false,
                                                  //     keyboardType: TextInputType.emailAddress,
                                                  //     limit: HelperFunction.EMAIL_VALIDATION,
                                                  //     validator: (value) {
                                                  //       return HelperFunction.empthyFieldValidator(value!);
                                                  //     }),
                                                  // SizedBox(
                                                  //   height: getVerticalSize(5),
                                                  // ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "CNIC No.".tr,
                                                            controller: controller.spousecnicControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.phone,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.digitsOnly,
                                                              TextInputFormatterWithPattern('#####-#######-#'),
                                                            ],
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Mobile number".tr,
                                                            controller: controller.spousemobileControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.phone,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "House/Plot".tr,
                                                            controller: controller.spousehouseControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.emailAddress,
                                                            limit: HelperFunction.EMAIL_VALIDATION,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Road".tr,
                                                            controller: controller.spouseroadControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.emailAddress,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Street".tr,
                                                            controller: controller.spousestreetControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.emailAddress,
                                                            limit: HelperFunction.EMAIL_VALIDATION,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Mohalla/Village.".tr,
                                                            controller: controller.spouseMohallaControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.text,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Post Office/Thana".tr,
                                                            controller: controller.spouseThanaControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.text,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "City".tr,
                                                            controller: controller.spouseCityControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.text,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Province".tr,
                                                            controller: controller.spouseProvinceControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.text,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: CustomButton(
                                                      width: getHorizontalSize(350),
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorConstant.whiteA700, 
                                                      label: "Attach a clear image of spouse".tr,
                                                      textColor: ColorConstant.anbtnBlue,
                                                      borderColor: ColorConstant.anbtnBlue,
                                                      prefix: controller.spouseImages[index].path == "" ||
                                                              controller.spouseImages[index].isBlank!
                                                          ? Icon(
                                                              Icons.add_circle_outline,
                                                              color: ColorConstant.anbtnBlue,
                                              size: 19.r,

                                                            )
                                                          : Icon(
                                                              Icons.check_circle_sharp,
                                                              color: ColorConstant.anbtnBlue,
                                              size: 19.r,

                                                            ),
                                                      onPressed: () async {
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.spouseImages[index] = File(result.path);
                                                          });
                                                        }

                                                        log(controller.spouseImages.toString());
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: CustomButton(
                                                      width: getHorizontalSize(350),
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorConstant.whiteA700,
                                                      label: "Attach a clear image of spouse CNIC front side".tr,
                                                      textColor: ColorConstant.anbtnBlue,
                                                      borderColor: ColorConstant.anbtnBlue,
                                                      prefix: controller.spouseCnicsfronts[index].path == "" ||
                                                              controller.spouseCnicsfronts[index].isBlank!
                                                          ? Icon(
                                                              Icons.add_circle_outline,
                                                              color: ColorConstant.anbtnBlue,
                                              size: 19.r,

                                                            )
                                                          : Icon(
                                                              Icons.check_circle_sharp,
                                                              color: ColorConstant.anbtnBlue,
                                              size: 19.r,

                                                            ),
                                                      onPressed: () async {
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.spouseCnicsfronts[index] = File(result.path);
                                                          });
                                                        }

                                                        log(controller.spouseCnicsfronts.toString());
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: CustomButton(
                                                      width: getHorizontalSize(350),
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorConstant.whiteA700,
                                                      label: "Attach a clear image of Spouse CNIC back side".tr,
                                                      textColor: ColorConstant.anbtnBlue,
                                                      borderColor: ColorConstant.anbtnBlue,
                                                      prefix: controller.spouseCnicBacks[index].path == "" ||
                                                              controller.spouseCnicBacks[index].isBlank!
                                                          ? Icon(
                                                              Icons.add_circle_outline,
                                              size: 19.r,
                                                              color: ColorConstant.anbtnBlue,
                                                            )
                                                          : Icon(
                                                              Icons.check_circle_sharp,
                                                              color: ColorConstant.anbtnBlue,
                                              size: 19.r,

                                                            ),
                                                      onPressed: () async {
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.spouseCnicBacks[index] = File(result.path);
                                                          });
                                                        }

                                                        log(controller.spouseCnicBacks.toString());
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),

                                                  Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: MyAnimatedButton(
                                                      radius: 5.0,
                                                      height: getVerticalSize(50),
                                                      width: getHorizontalSize(400),
                                                      fontSize: 16,
                                                      bgColor: ColorConstant.anbtnBlue,
                                                      controller: controller.btnControllerUseLess,
                                                      title: "Add Spouse".tr,
                                                      onTap: () async {

                                                           log(controller.spouseImages.toString() );
                                                        // for (var element in controller.spousefullNameControllers) {
                                                        //   log(element.text);
                                                        // }

                                                        // for (var i = 0; i < controller.spousefullNameControllers.length; i++) {
                                                        //   log("spouse[$i]" + controller.spousefullNameControllers[i].text);
                                                        // }
                                                        // controller.addSpouse();
                                                        if (controller.spouseImages.isEmpty) {
                                                          Utils.showToast("Please select spouse Images", true);
                                                        } else if (controller.spouseCnicsfronts.isEmpty) {
                                                          Utils.showToast(
                                                              "Please select spouse cnic front images", true);
                                                        } else if (controller.spouseCnicBacks.isEmpty) {
                                                          Utils.showToast(
                                                              "Please select spouse cnic back images", true);
                                                        } else {
                                                          controller.spouseEntryFormAPi(context, index);
                                                        }

                                                        // if (controller.spouseImage == null) {
                                                        //   Utils.showToast(
                                                        //     "Please select image of spouse",
                                                        //     true,
                                                        //   );
                                                        // } else if (controller.spouseCnicFront == null) {
                                                        //   Utils.showToast(
                                                        //     "Please select image of spouse CNIC front side",
                                                        //     true,
                                                        //   );
                                                        // } else if (controller.spouseCnicBack == null) {
                                                        //   Utils.showToast(
                                                        //     "Please select image of spouse CNIC back side",
                                                        //     true,
                                                        //   );
                                                        // } else {
                                                        //   controller.spouseEntryFormAPi(context);
                                                        // }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(20),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: getVerticalSize(10),
                              ),
                              GetBuilder(
                                  init: controller,
                                  builder: (context) {
                                    return Form(
                                      key: controller.childEntryFormKey,
                                      child: CustomExpansionTile(
                                        title: MyText(
                                          title: 'Child',
                                          clr: ColorConstant.black900,
                                          fontSize: 16,
                                        ),
                                        children: <Widget>[
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: controller.childfullNameControllers.length == 0
                                                ? 1
                                                : controller.childfullNameControllers.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  // if (controller.childDataIndex != 0)
                                                  //   Row(
                                                  //     mainAxisAlignment: MainAxisAlignment.end,
                                                  //     children: [
                                                  //       Container(
                                                  //         margin: EdgeInsets.only(left: 15),
                                                  //         padding: EdgeInsets.all(10),
                                                  //         decoration: BoxDecoration(
                                                  //             color: Colors.green, shape: BoxShape.circle),
                                                  //         child: MyText(
                                                  //           title: controller.childDataIndex.toString(),
                                                  //           clr: ColorConstant.whiteA700,
                                                  //           fontSize: 16,
                                                  //         ),
                                                  //       ),
                                                  //     ],
                                                  //   ),

                                                  if (index != 0)
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              controller.childfullNameControllers.removeAt(index);
                                                            });
                                                          },
                                                          child: Container(
                                                              margin: EdgeInsets.only(right: 15),
                                                              padding: EdgeInsets.all(8),
                                                              decoration: BoxDecoration(
                                                                  color: Colors.red, shape: BoxShape.circle),
                                                              child: Icon(
                                                                Icons.delete_outlined,
                                                                color: Colors.white,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  CustomTextField(
                                                      fieldText: "Full Name".tr,
                                                      controller: controller.childfullNameControllers[index],
                                                      isFinal: false,
                                                      keyboardType: TextInputType.emailAddress,
                                                      limit: HelperFunction.EMAIL_VALIDATION,
                                                      validator: (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }),
                                                  // SizedBox(
                                                  //   height: getVerticalSize(5),
                                                  // ),
                                                  // CustomTextField(
                                                  //     fieldText: "Father’s Name".tr,
                                                  //     controller: controller.childfathersControllers[index],
                                                  //     isFinal: false,
                                                  //     keyboardType: TextInputType.emailAddress,
                                                  //     limit: HelperFunction.EMAIL_VALIDATION,
                                                  //     validator: (value) {
                                                  //       return HelperFunction.empthyFieldValidator(value!);
                                                  //     }),
                                                  // SizedBox(
                                                  //   height: getVerticalSize(5),
                                                  // ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "CNIC No.".tr,
                                                            controller: controller.childcnicControllers[index],
                                                            isFinal: false,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.digitsOnly,
                                                              TextInputFormatterWithPattern('#####-#######-#'),
                                                            ],
                                                            keyboardType: TextInputType.number,
                                                            limit: HelperFunction.EMAIL_VALIDATION,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Mobile number".tr,
                                                            controller: controller.childmobileControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.phone,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "House/Plot".tr,
                                                            controller: controller.childhouseControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.emailAddress,
                                                            limit: HelperFunction.EMAIL_VALIDATION,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Road".tr,
                                                            controller: controller.childroadControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.emailAddress,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Street".tr,
                                                            controller: controller.childstreetControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.emailAddress,
                                                            limit: HelperFunction.EMAIL_VALIDATION,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Mohalla/Village.".tr,
                                                            controller: controller.childMohallaControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.text,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Post Office/Thana".tr,
                                                            controller: controller.childThanaControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.text,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "City".tr,
                                                            controller: controller.childCityControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.text,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Province".tr,
                                                            controller: controller.childProvinceControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.text,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: CustomButton(
                                                      width: getHorizontalSize(350),
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorConstant.whiteA700,
                                                      label: "Attach a clear image of child".tr,
                                                      textColor: ColorConstant.anbtnBlue,
                                                      borderColor: ColorConstant.anbtnBlue,
                                                      prefix: controller.childImages[index].path == "" ||
                                                              controller.childImages[index].isBlank!
                                                          ? Icon(
                                                              Icons.add_circle_outline,
                                                              color: ColorConstant.anbtnBlue,
                                              size: 19.r,

                                                            )
                                                          : Icon(
                                                              Icons.check_circle_sharp,
                                              size: 19.r,
                                                              color: ColorConstant.anbtnBlue,
                                                            ),
                                                      onPressed: () async {
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.childImages[index] = File(result.path);
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: CustomButton(
                                                      width: getHorizontalSize(350),
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorConstant.whiteA700,
                                                      label: "Attach a clear image of child CNIC front sides".tr,
                                                      textColor: ColorConstant.anbtnBlue,
                                                      borderColor: ColorConstant.anbtnBlue,
                                                      prefix: controller.childCnicsfronts[index].path == "" ||
                                                              controller.childCnicsfronts[index].isBlank!
                                                          ? Icon(
                                                              Icons.add_circle_outline,
                                                              color: ColorConstant.anbtnBlue,
                                              size: 19.r,

                                                            )
                                                          : Icon(
                                                              Icons.check_circle_sharp,
                                              size: 19.r,

                                                              color: ColorConstant.anbtnBlue,
                                                            ),
                                                      onPressed: () async {
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.childCnicsfronts[index] = File(result.path);
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: CustomButton(
                                                      width: getHorizontalSize(350),
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorConstant.whiteA700,
                                                      label: "Attach a clear image of child CNIC back side".tr,
                                                      textColor: ColorConstant.anbtnBlue,
                                                      borderColor: ColorConstant.anbtnBlue,
                                                      prefix: controller.childCnicBacks[index].path == "" ||
                                                              controller.childCnicBacks[index].isBlank!
                                                          ? Icon(
                                                              Icons.add_circle_outline,
                                                              color: ColorConstant.anbtnBlue,
                                              size: 19.r,

                                                            )
                                                          : Icon(
                                                              Icons.check_circle_sharp,
                                                              color: ColorConstant.anbtnBlue,
                                              size: 19.r,

                                                            ),
                                                      onPressed: () async {
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.childCnicBacks[index] = File(result.path);
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: MyAnimatedButton(
                                                      radius: 5.0,
                                                      height: getVerticalSize(50),
                                                      width: getHorizontalSize(400),
                                                      fontSize: 16,
                                                      bgColor: ColorConstant.anbtnBlue,
                                                      controller: controller.btnControllerUseLess,
                                                      title: "Add Child".tr,
                                                      onTap: () async {
                                                        if (controller.childImages.isEmpty) {
                                                          Utils.showToast("Please select child images", true);
                                                        } else if (controller.childCnicsfronts.isEmpty) {
                                                          Utils.showToast(
                                                              "Please select child cnic front images", true);
                                                        } else if (controller.childCnicBacks.isEmpty) {
                                                          Utils.showToast("Please select child cnic back images", true);
                                                        } else {
                                                          controller.childEntryFormAPi(context, index);
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(20),
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: getVerticalSize(20),
                              ),
                              Padding(
                                padding: getPadding(left: 10, right: 10),
                                child: MyAnimatedButton(
                                  radius: 5.0,
                                  height: getVerticalSize(50),
                                  width: getHorizontalSize(400),
                                  fontSize: 16,
                                  bgColor: ColorConstant.anbtnBlue,
                                  controller: _value.btnController,
                                  title: "Submit".tr,
                                  onTap: () async {
                                    // log(controller.EntryFormData.toString());
                                    controller.SubmitEntryFormApi(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
            ],
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
