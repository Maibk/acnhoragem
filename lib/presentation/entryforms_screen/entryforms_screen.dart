import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/core/utils/constants.dart';
import 'package:anchorageislamabad/core/utils/utils.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/widgets/custom_image_view.dart';
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
  bool isEditable = false;

  final args = Get.arguments;

  @override
  void initState() {
    controller.childDataIndex = 0;
    controller.spouseDataIndex = 0;
    controller.ownerImage = null;
    controller.ownerCnicFront = null;
    controller.ownerCnicBack = null;
    Future.delayed(Duration(), () {
      args['status'] == "Pending" ? controller.getEntryFormsDetails(args['id']) : null;
      args['status'] != "Pending" ? controller.addSpouse() : null;
      args['status'] != "Pending" ? controller.addChild() : null;
    });

    if (args['status'] == Constants.formStatusRejected || args['status'] == "") {
      isEditable = true;
    }

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
                    if (args['status'] == "Pending" && controller.formsLoadingStatus == ApiCallStatus.loading) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    } else {
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
                                         
                                            enabled: args['status'] == Constants.formStatusPending ? false : true,
                                            keyboardType: TextInputType.emailAddress,
                                            limit: HelperFunction.EMAIL_VALIDATION,
                                            validator: (value) {
                                              return HelperFunction.validateAlphabetsOnly(value!);
                                            },
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(5),
                                          ),
                                          CustomTextField(
                                            fieldText: "Father’s Name".tr,
                                            controller: controller.fathersController,
                                            isFinal: false,
                                            enabled: args['status'] == Constants.formStatusPending ? false : true,
                                            keyboardType: TextInputType.emailAddress,
                                            limit: HelperFunction.EMAIL_VALIDATION,
                                            validator: (value) {
                                              return HelperFunction.validateAlphabetsOnly(value!);
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
                                                  enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                  keyboardType: TextInputType.phone,
                                                  limit: HelperFunction.EMAIL_VALIDATION,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly,
                                                    TextInputFormatterWithPattern('#####-#######-#'),
                                                  ],
                                                  validator: (value) {
                                                    return HelperFunction.cnicValidator(value!);
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomTextField(
                                                  fieldText: "Mobile number".tr,
                                                  enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                  controller: controller.mobileController,
                                                  isFinal: false,
                                                  keyboardType: TextInputType.phone,
                                                  validator: (value) {
                                                    return HelperFunction.validatePakistaniPhoneNumber(value!);
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
                                                  onChanged: args['status'] == Constants.formStatusPending
                                                      ? null
                                                      : (value) {
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
                                                      hint: controller.streetSelectedValue?.title == null
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
                                                              controller.plots.isEmpty ? "Select Plot" : controller.plotPlaceHolder,
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: ColorConstant.blackColor.withOpacity(0.5),
                                                                fontFamily: AppFonts.lucidaBright,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            )
                                                          : Text(controller.plotstSelectedValue?.title.toString() ?? ""),
                                                      value: controller.plotstSelectedValue,
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
                                                  enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                  enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                          if (args['status'] == "Pending")
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                MyText(title: "Image").paddingOnly(left: 10),
                                                5.verticalSpace,
                                                GestureDetector(
                                                  onTap: () async {
                                                    controller.ownerImage = await controller.imagePicker();
                                                  },
                                                  child: Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: Container(
                                                      width: getHorizontalSize(350),
                                                      color: ColorConstant.whiteA700,
                                                      child: CustomImageView(
                                                        url: controller.entryFormDataModel.data?.image ?? "",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                5.verticalSpace,
                                              ],
                                            ),
                                          if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                  controller.ownerImage != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
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
                                          if (args['status'] == "Pending")
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                MyText(title: "CNIC Image Front").paddingOnly(left: 10),
                                                5.verticalSpace,
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: Container(
                                                      width: getHorizontalSize(350),
                                                      color: ColorConstant.whiteA700,
                                                      child: CustomImageView(
                                                        url: controller.entryFormDataModel.data?.cnicImageFront ?? "",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                5.verticalSpace
                                              ],
                                            ),
                                          if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                  controller.ownerCnicFront != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
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
                                          if (args['status'] == "Pending")
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                MyText(title: "CNIC Image Back").paddingOnly(left: 10),
                                                5.verticalSpace,
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: Container(
                                                      width: getHorizontalSize(350),
                                                      color: ColorConstant.whiteA700,
                                                      child: CustomImageView(
                                                        url: controller.entryFormDataModel.data?.cnicImageBack ?? "",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                5.verticalSpace,
                                              ],
                                            ),
                                          if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                  controller.ownerCnicBack != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
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
                                            clr: ColorConstant.black900,
                                            fontSize: 16,
                                          ),
                                          children: <Widget>[
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: args['status'] == "Pending"
                                                  ? controller.entryFormDataModel.data?.spouseDetail?.length ?? 0
                                                  : controller.spousefullNameControllers.length == 0
                                                      ? 1
                                                      : controller.spousefullNameControllers.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
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
                                                                decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
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
                                                        enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                        isFinal: false,
                                                        keyboardType: TextInputType.emailAddress,
                                                        limit: HelperFunction.EMAIL_VALIDATION,
                                                        validator: (value) {
                                                          return HelperFunction.validateAlphabetsOnly(value!);
                                                        }),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: CustomTextField(
                                                              fieldText: "CNIC No.".tr,
                                                              controller: controller.spousecnicControllers[index],
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              isFinal: false,
                                                              keyboardType: TextInputType.phone,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter.digitsOnly,
                                                                TextInputFormatterWithPattern('#####-#######-#'),
                                                              ],
                                                              validator: (value) {
                                                                return HelperFunction.cnicValidator(value!);
                                                              }),
                                                        ),
                                                        Expanded(
                                                          child: CustomTextField(
                                                              fieldText: "Mobile number".tr,
                                                              controller: controller.spousemobileControllers[index],
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              isFinal: false,
                                                              keyboardType: TextInputType.phone,
                                                              validator: (value) {
                                                                return HelperFunction.validatePakistaniPhoneNumber(value!);
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                    if (args['status'] == "Pending")
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          MyText(title: "Attachment").paddingOnly(left: 10),
                                                          5.verticalSpace,
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  url: controller.entryFormDataModel.data?.spouseDetail?[index].spouseImage ?? "",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          5.verticalSpace,
                                                        ],
                                                      ),
                                                    if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                          prefix: controller.spouseImages[index].path == "" || controller.spouseImages[index].isBlank!
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
                                                            final result = await controller.picker.pickImage(source: ImageSource.gallery);

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
                                                    if (args['status'] == "Pending")
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          MyText(title: "Attachment").paddingOnly(left: 10),
                                                          5.verticalSpace,
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  url: controller.entryFormDataModel.data?.spouseDetail?[index].spouseCnicFront ?? "",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          5.verticalSpace,
                                                        ],
                                                      ),
                                                    if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                            final result = await controller.picker.pickImage(source: ImageSource.gallery);
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
                                                    if (args['status'] == "Pending")
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          MyText(title: "Attachment").paddingOnly(left: 10),
                                                          5.verticalSpace,
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  url: controller.entryFormDataModel.data?.spouseDetail?[index].spouseCnicBack ?? "",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          5.verticalSpace,
                                                        ],
                                                      ),
                                                    if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                            final result = await controller.picker.pickImage(source: ImageSource.gallery);

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
                                                    if (args['status'] == "")
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
                                                            if (controller.spouseImages.isEmpty) {
                                                              Utils.showToast("Please select spouse Images", true);
                                                            } else if (controller.spouseCnicsfronts.isEmpty) {
                                                              Utils.showToast("Please select spouse cnic front images", true);
                                                            } else if (controller.spouseCnicBacks.isEmpty) {
                                                              Utils.showToast("Please select spouse cnic back images", true);
                                                            } else {
                                                              controller.spouseEntryFormAPi(context, index);
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
                                              itemCount: args['status'] == "Pending"
                                                  ? controller.entryFormDataModel.data?.childDetail?.length ?? 0
                                                  : controller.childfullNameControllers.length == 0
                                                      ? 1
                                                      : controller.childfullNameControllers.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
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
                                                                decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
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
                                                        enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                        isFinal: false,
                                                        keyboardType: TextInputType.emailAddress,
                                                        limit: HelperFunction.EMAIL_VALIDATION,
                                                        validator: (value) {
                                                          return HelperFunction.validateAlphabetsOnly(value!);
                                                        }),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: CustomTextField(
                                                              fieldText: "CNIC No.".tr,
                                                              controller: controller.childcnicControllers[index],
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              isFinal: false,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter.digitsOnly,
                                                                TextInputFormatterWithPattern('#####-#######-#'),
                                                              ],
                                                              keyboardType: TextInputType.number,
                                                              limit: HelperFunction.EMAIL_VALIDATION,
                                                              validator: (value) {
                                                                return HelperFunction.cnicValidator(value!);
                                                              }),
                                                        ),
                                                        Expanded(
                                                          child: CustomTextField(
                                                              fieldText: "Mobile number".tr,
                                                              controller: controller.childmobileControllers[index],
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              isFinal: false,
                                                              keyboardType: TextInputType.phone,
                                                              validator: (value) {
                                                                return HelperFunction.validatePakistaniPhoneNumber(value!);
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              isFinal: false,
                                                              keyboardType: TextInputType.emailAddress,
                                                              limit: HelperFunction.EMAIL_VALIDATION,
                                                              validator: (value) {
                                                                return HelperFunction.empthyFieldValidator(value!);
                                                              }),
                                                        ),
                                                        Expanded(
                                                          child: CustomTextField(
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                    if (args['status'] == "Pending")
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          MyText(title: "Attachment").paddingOnly(left: 10),
                                                          5.verticalSpace,
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  url: controller.entryFormDataModel.data?.childDetail?[index].childImage ?? "",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          5.verticalSpace,
                                                        ],
                                                      ),
                                                    if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                          prefix: controller.childImages[index].path == "" || controller.childImages[index].isBlank!
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
                                                            final result = await controller.picker.pickImage(source: ImageSource.gallery);

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
                                                    if (args['status'] == "Pending")
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          MyText(title: "Attachment").paddingOnly(left: 10),
                                                          5.verticalSpace,
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  url: controller.entryFormDataModel.data?.childDetail?[index].childCnicFront ?? "",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          5.verticalSpace,
                                                        ],
                                                      ),
                                                    if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                            final result = await controller.picker.pickImage(source: ImageSource.gallery);

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
                                                    if (args['status'] == "Pending")
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          MyText(title: "Attachment").paddingOnly(left: 10),
                                                          5.verticalSpace,
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  url: controller.entryFormDataModel.data?.childDetail?[index].childCnicBack ?? "",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          5.verticalSpace,
                                                        ],
                                                      ),
                                                    if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                          prefix:
                                                              controller.childCnicBacks[index].path == "" || controller.childCnicBacks[index].isBlank!
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
                                                            final result = await controller.picker.pickImage(source: ImageSource.gallery);

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
                                                    if (args['status'] == "")
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
                                                              Utils.showToast("Please select child cnic front images", true);
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
                                if (args['status'] == Constants.formStatusRejected || args['status'] == "")
                                  Padding(
                                    padding: getPadding(left: 10, right: 10),
                                    child: MyAnimatedButton(
                                      radius: 5.0,
                                      height: getVerticalSize(50),
                                      width: getHorizontalSize(400),
                                      fontSize: 16,
                                      bgColor: ColorConstant.anbtnBlue,
                                      controller: (args['status'] == Constants.formStatusRejected || args['status'] == "")
                                          ? _value.submitEdittedFormButtonController
                                          : _value.btnController,
                                      title: "Submit".tr,
                                      onTap: () async {
                                        (args['status'] == Constants.formStatusRejected || args['status'] == "")
                                            ? controller.SubmitEdittedEntryFormApi(context, args['id'])
                                            : controller.SubmitEntryFormApi(context);
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
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
