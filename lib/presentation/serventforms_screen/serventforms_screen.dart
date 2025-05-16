import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/core/utils/app_fonts.dart';
import 'package:anchorageislamabad/core/utils/constants.dart';
import 'package:anchorageislamabad/core/utils/image_gallery.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/presentation/serventforms_screen/models/servant_form_data_model.dart.dart';
import 'package:anchorageislamabad/theme/app_style.dart';
import 'package:anchorageislamabad/widgets/custom_image_view.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/size_utils.dart';
import '../../core/utils/utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/animated_custom_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_expensiontile.dart';
import '../../widgets/custom_textfield_new.dart';
import '../home_screen/controller/home_controller.dart';
import 'controller/serventforms_controller.dart';

class ServentFormsScreen extends StatefulWidget {
  @override
  State<ServentFormsScreen> createState() => _ServentFormsScreenState();
}

class _ServentFormsScreenState extends State<ServentFormsScreen> {
  ServentFormsController controller = Get.put(ServentFormsController());

  final ImageGalleryClass imageGalleryClass = ImageGalleryClass();

  HomeController homecontroller = Get.put(HomeController());

  final args = Get.arguments;
  bool isEditable = false;

  int servantIndex = 0;
  int servantFamilyIndex = 0;

  @override
  initState() {
    if (args['status'] == Constants.formStatusRejected || args['status'] == "") {
      isEditable = true;
    }
    controller.servantDataIndex = 0;
    controller.servantFamilyDataIndex = 0;
    controller.servantCnicBack = null;
    controller.servantCnicFront = null;
    controller.servantImage = null;
    controller.servantData = {};

    Future.delayed(Duration(), () {
      args['status'] != "" ? controller.getEntryFormsDetails(args['id']) : null;
      args['status'] != "" ? null : controller.addServantFamControllers();
      args['status'] != "" ? null : controller.addServantControllers();
    });

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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Colors.transparent,
          title: MyText(
            title: "Servant Card",
            clr: ColorConstant.whiteA700,
            fontSize: 20,
            customWeight: FontWeight.w500,
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.offAllNamed(AppRoutes.myformsPage);
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
        body: Padding(
          padding: getPadding(left: 10),
          child: Column(
            children: [
              GetBuilder(
                  init: controller,
                  builder: (_value) {
                    if (args['status'] != "" && controller.formsLoadingStatus == ApiCallStatus.loading) {
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
                                if (args['status'] == "Rejected")
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(7)),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: MyText(
                                          title: "Rejection Reason : " + (controller.servantFormDataModel.data?.rejection_reason ?? ""),
                                          fontSize: 20,
                                          clr: ColorConstant.apppWhite,
                                        )),
                                  ),
                                SizedBox(
                                  height: getVerticalSize(10),
                                ),
                                CustomExpansionTile(
                                  title: MyText(
                                    title: 'OWNER INFORMATION',
                                    clr: ColorConstant.black900,
                                    fontSize: 16,
                                  ),
                                  children: <Widget>[
                                    Form(
                                      key: _value.ownerFormKeyy,
                                      child: Column(
                                        children: [
                                          CustomTextField(
                                            fieldText: "Full Name".tr,
                                            enabled: args['status'] == Constants.formStatusPending ? false : true,
                                            controller: controller.fullNameController,
                                            isFinal: false,
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
                                            enabled: args['status'] == Constants.formStatusPending ? false : true,
                                            controller: controller.fathersController,
                                            isFinal: false,
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
                                                  enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                  fieldText: "CNIC No.".tr,
                                                  controller: controller.cnicController,
                                                  isFinal: false,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly,
                                                    TextInputFormatterWithPattern('#####-#######-#'),
                                                  ],
                                                  limit: HelperFunction.EMAIL_VALIDATION,
                                                  validator: (value) {
                                                    return HelperFunction.cnicValidator(value!);
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomTextField(
                                                  enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                  fieldText: "Mobile number".tr,
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
                                            height: getVerticalSize(10),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: getHorizontalSize(330),
                                                child: AbsorbPointer(
                                                  absorbing: false,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Block/COMM ",
                                                        style: AppStyle.txtSourceSansProRegular16Gray600
                                                            .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                      ).paddingOnly(
                                                        left: 14,
                                                      ),
                                                      DropdownButton(
                                                        isExpanded: true,
                                                        padding: EdgeInsets.symmetric(horizontal: 2),
                                                        hint: controller.selectedValue == null
                                                            ? Text(
                                                                "Select",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: ColorConstant.blackColor.withOpacity(0.5),
                                                                  fontFamily: AppFonts.lucidaBright,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              )
                                                            : Text(controller.selectedValue.toString()),
                                                        value: controller.selectedValue,
                                                        items: controller.block.map((item) {
                                                          return DropdownMenuItem<int>(
                                                            value: item['id'],
                                                            child: Text(item['title']),
                                                          );
                                                        }).toList(),
                                                        onChanged: args['status'] == Constants.formStatusPending
                                                            ? null
                                                            : (int? value) {
                                                                setState(() {
                                                                  controller.selectedValue = value!;
                                                                  controller.streetSelectedValue = null;
                                                                  controller.streets.clear();
                                                                  controller.plots.clear();
                                                                  controller.getStreetByBlock(value);
                                                                });
                                                              },
                                                      ).paddingOnly(left: 12),
                                                    ],
                                                  ),
                                                ),
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
                                                        child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Street",
                                                          style: AppStyle.txtSourceSansProRegular16Gray600
                                                              .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                        ).paddingOnly(
                                                          left: 14,
                                                        ),
                                                        DropdownButton<Street>(
                                                          isExpanded: true,
                                                          hint: controller.streetSelectedValue == null
                                                              ? Text(
                                                                  "Select",
                                                                  style: TextStyle(
                                                                    fontSize: 14,
                                                                    color: ColorConstant.blackColor.withOpacity(0.5),
                                                                    fontFamily: AppFonts.lucidaBright,
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                )
                                                              : Text(controller.streetSelectedValue?.title.toString() ?? ""),
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
                                                              controller.plotstSelectedValue = null;
                                                              controller.plots.clear();
                                                              controller.getPlotNoByStreet(value!.id);
                                                            });
                                                          },
                                                        ).paddingOnly(left: 12),
                                                      ],
                                                    ));
                                                  }),
                                              GetBuilder(
                                                  init: controller,
                                                  builder: (context) {
                                                    return Expanded(
                                                        child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Plot",
                                                          style: AppStyle.txtSourceSansProRegular16Gray600
                                                              .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                        ).paddingOnly(
                                                          left: 14,
                                                        ),
                                                        DropdownButton<Plots>(
                                                          isExpanded: true,
                                                          hint: controller.plotstSelectedValue == null
                                                              ? Text(
                                                                  "Select ",
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
                                                          onChanged: (Plots? value) {
                                                            setState(() {
                                                              controller.plotstSelectedValue = value;
                                                            });
                                                          },
                                                        ).paddingOnly(left: 12),
                                                      ],
                                                    ).paddingOnly(right: 10));
                                                  })
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: getVerticalSize(5),
                                          // ),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     Expanded(
                                          //       child: CustomTextField(
                                          //         fieldText: "Road".tr,
                                          //         enabled: args['status'] == Constants.formStatusPending ? false : true,
                                          //         controller: controller.roadController,
                                          //         isFinal: false,
                                          //         keyboardType: TextInputType.emailAddress,
                                          //         limit: HelperFunction.EMAIL_VALIDATION,
                                          //         validator: (value) {
                                          //           return HelperFunction.empthyFieldValidator(value!);
                                          //         },
                                          //       ),
                                          //     ),
                                          //     Expanded(
                                          //       child: CustomTextField(
                                          //         enabled: args['status'] == Constants.formStatusPending ? false : true,
                                          //         fieldText: "Colony/Residential Area Name".tr,
                                          //         controller: controller.colonyController,
                                          //         isFinal: false,
                                          //         keyboardType: TextInputType.emailAddress,
                                          //         validator: (value) {
                                          //           return HelperFunction.empthyFieldValidator(value!);
                                          //         },
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          SizedBox(
                                            height: getVerticalSize(10),
                                          ),
                                          if (args['status'] != "")
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                MyText(title: "Image").paddingOnly(left: 10),
                                                5.verticalSpace,
                                                Padding(
                                                  padding: getPadding(left: 10, right: 10),
                                                  child: Container(
                                                    width: getHorizontalSize(350),
                                                    color: ColorConstant.whiteA700,
                                                    child: CustomImageView(
                                                      radius: BorderRadius.circular(6),
                                                      border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                      url: controller.servantFormDataModel.data?.cnicImage?.ownerImage ?? "",
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
                                                label: "Attach clear image of yours".tr,
                                                textColor: ColorConstant.anbtnBlue,
                                                borderColor: ColorConstant.anbtnBlue,
                                                prefix: Icon(
                                                  controller.ownerImage != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                  color: ColorConstant.anbtnBlue,
                                                ),
                                                onPressed: () async {
                                                  imageGalleryClass.imageGalleryBottomSheet(
                                                    context: context,
                                                    onCameraTap: () async {
                                                      controller.ownerImage = await imageGalleryClass.getImage(ImageSource.camera);
                                                      setState(() {});
                                                      Get.back();
                                                    },
                                                    onGalleryTap: () async {
                                                      controller.ownerImage = await imageGalleryClass.getImage(ImageSource.gallery);
                                                      setState(() {});
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          SizedBox(
                                            height: getVerticalSize(15),
                                          ),
                                          if (args['status'] != "")
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                MyText(title: "CNIC Image Front").paddingOnly(left: 10),
                                                5.verticalSpace,
                                                Padding(
                                                  padding: getPadding(left: 10, right: 10),
                                                  child: Container(
                                                    width: getHorizontalSize(350),
                                                    color: ColorConstant.whiteA700,
                                                    child: CustomImageView(
                                                      radius: BorderRadius.circular(6),
                                                      border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                      url: controller.servantFormDataModel.data?.cnicImage?.ownerCnicFront ?? "",
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
                                                label: "Attach your CNIC front image".tr,
                                                textColor: ColorConstant.anbtnBlue,
                                                borderColor: ColorConstant.anbtnBlue,
                                                prefix: Icon(
                                                  controller.ownerCnicFront != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                  color: ColorConstant.anbtnBlue,
                                                ),
                                                onPressed: () async {
                                                  imageGalleryClass.imageGalleryBottomSheet(
                                                    context: context,
                                                    onCameraTap: () async {
                                                      controller.ownerCnicFront = await imageGalleryClass.getImage(ImageSource.camera);
                                                      setState(() {});
                                                      Get.back();
                                                    },
                                                    onGalleryTap: () async {
                                                      controller.ownerCnicFront = await imageGalleryClass.getImage(ImageSource.gallery);
                                                      setState(() {});
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          SizedBox(
                                            height: getVerticalSize(15),
                                          ),
                                          if (args['status'] != "")
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                MyText(title: "CNIC Image Back").paddingOnly(left: 10),
                                                5.verticalSpace,
                                                Padding(
                                                  padding: getPadding(left: 10, right: 10),
                                                  child: Container(
                                                    width: getHorizontalSize(350),
                                                    color: ColorConstant.whiteA700,
                                                    child: CustomImageView(
                                                      radius: BorderRadius.circular(6),
                                                      border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                      url: controller.servantFormDataModel.data?.cnicImage?.ownerCnicFront ?? "",
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
                                                label: "Attach your CNIC front image".tr,
                                                textColor: ColorConstant.anbtnBlue,
                                                borderColor: ColorConstant.anbtnBlue,
                                                prefix: Icon(
                                                  controller.ownerCnicBack != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                  color: ColorConstant.anbtnBlue,
                                                ),
                                                onPressed: () async {
                                                  imageGalleryClass.imageGalleryBottomSheet(
                                                    context: context,
                                                    onCameraTap: () async {
                                                      controller.ownerCnicBack = await imageGalleryClass.getImage(ImageSource.camera);
                                                      setState(() {});
                                                      Get.back();
                                                    },
                                                    onGalleryTap: () async {
                                                      controller.ownerCnicBack = await imageGalleryClass.getImage(ImageSource.gallery);
                                                      setState(() {});
                                                      Get.back();
                                                    },
                                                  );
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
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: getVerticalSize(10),
                                ),
                                GetBuilder(
                                    init: controller,
                                    builder: (context) {
                                      return CustomExpansionTile(
                                        title: MyText(
                                          title: 'Servant Information',
                                          clr: ColorConstant.black900,
                                          fontSize: 16,
                                        ),
                                        children: <Widget>[
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: args['status'] != ""
                                                ? (controller.servantFormDataModel.data?.servantDetail?.length ?? 0) +
                                                    (args['status'] == Constants.formStatusRejected ? 1 : 0)
                                                : controller.serventfullNameControllers.length + 1,
                                            itemBuilder: (context, index) {
                                              servantIndex = index;
                                              bool isLastIndex = index ==
                                                  (args['status'] != ""
                                                      ? (controller.servantFormDataModel.data?.servantDetail?.length ?? 0)
                                                      : controller.serventfullNameControllers.length);

                                              if (isLastIndex && (args['status'] == Constants.formStatusRejected || args['status'] == "")) {
                                                return Padding(
                                                  padding: getPadding(left: 10, right: 10, top: 20, bottom: 10),
                                                  child: MyAnimatedButton(
                                                    radius: 5.0,
                                                    height: getVerticalSize(50),
                                                    width: getHorizontalSize(400),
                                                    fontSize: 16,
                                                    bgColor: ColorConstant.anbtnBlue,
                                                    controller: _value.btnControllerUseLess,
                                                    title: "Add Servant".tr,
                                                    onTap: () async {
                                                      if (args['status'] == Constants.formStatusRejected) {
                                                        if (_value.addServantFormKey[index - 1].currentState?.validate() ?? true) {
                                                          if (controller.servantImages[index - 1].path == "") {
                                                            Utils.showToast("Please attach servant image", true);
                                                          } else if (controller.servantCnicFronts[index - 1].path == "") {
                                                            Utils.showToast("Please attach servant cnic front image", true);
                                                          } else if (controller.servantCnicBacks[index - 1].path == "") {
                                                            Utils.showToast("Please attach servant cnic back image", true);
                                                          } else {
                                                            controller.servantImages.add(File(""));
                                                            controller.servantCnicFronts.add(File(""));
                                                            controller.servantCnicBacks.add(File(""));
                                                            controller.servantFormDataModel.data?.servantDetail?.add(ServantDetail());
                                                            _value.addServantFormKey.add(GlobalKey<FormState>());
                                                            controller.update();
                                                          }
                                                        }
                                                      } else {
                                                        _value.addServantFormKey.add(GlobalKey<FormState>());
                                                        controller.addServant(index - 1);
                                                      }
                                                    },
                                                  ),
                                                );
                                              }
                                              ServantDetail? detail;
                                              if ((controller.servantFormDataModel.data?.servantDetail?.length ?? 0) > 0 &&
                                                  index < (controller.servantFormDataModel.data?.servantDetail?.length ?? 0)) {
                                                detail = controller.servantFormDataModel.data?.servantDetail?[index];
                                              }
                                              // shrinkWrap: true,
                                              // physics: NeverScrollableScrollPhysics(),
                                              // itemCount: args['status'] != ""
                                              //     ? controller.servantFormDataModel.data?.servantDetail?.length ?? 0
                                              //     : controller.serventfullNameControllers.length == 0
                                              //         ? 1
                                              //         : controller.serventfullNameControllers.length,
                                              // itemBuilder: (context, index) {
                                              //   ServantDetail? detail;
                                              //   if ((controller.servantFormDataModel.data?.servantDetail?.length ?? 0) > 0) {
                                              //     detail = controller.servantFormDataModel.data?.servantDetail?[index];
                                              //   }
                                              return Form(
                                                key: controller.addServantFormKey[index],
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    if (index != 0)
                                                      if (args['status'] != Constants.formStatusPending)
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (args['status'] == Constants.formStatusRejected) {
                                                                    controller.servantImages.removeAt(index);
                                                                    controller.servantCnicFronts.removeAt(index);
                                                                    controller.servantCnicBacks.removeAt(index);
                                                                    controller.servantFormDataModel.data?.servantDetail?.removeAt(index);
                                                                  } else {
                                                                    controller.servantImages.removeAt(index);
                                                                    controller.servantCnicFronts.removeAt(index);
                                                                    controller.servantCnicBacks.removeAt(index);
                                                                    controller.serventfullNameControllers.removeAt(index);
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                  margin: EdgeInsets.only(right: 15, top: 10),
                                                                  padding: EdgeInsets.all(8),
                                                                  decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                                                  child: Icon(
                                                                    Icons.delete_outlined,
                                                                    color: Colors.white,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                    MyText(
                                                      title: 'Servant ${index + 1}',
                                                      clr: ColorConstant.black900,
                                                      fontSize: 16,
                                                    ).paddingOnly(left: 10, bottom: 10),
                                                    CustomTextField(
                                                        enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                        fieldText: "Full Name".tr,
                                                        controller: args['status'] == Constants.formStatusRejected
                                                            ? detail?.servantNameController
                                                            : controller.serventfullNameControllers[index],
                                                        isFinal: false,
                                                        keyboardType: TextInputType.emailAddress,
                                                        limit: HelperFunction.EMAIL_VALIDATION,
                                                        validator: (value) {
                                                          return HelperFunction.validateAlphabetsOnly(value!);
                                                        }),
                                                    SizedBox(
                                                      height: getVerticalSize(5),
                                                    ),
                                                    CustomTextField(
                                                        enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                        fieldText: "Father’s Name".tr,
                                                        controller: args['status'] == Constants.formStatusRejected
                                                            ? detail?.servantFatherController
                                                            : controller.serventfathersControllers[index],
                                                        isFinal: false,
                                                        keyboardType: TextInputType.emailAddress,
                                                        limit: HelperFunction.EMAIL_VALIDATION,
                                                        validator: (value) {
                                                          return HelperFunction.validateAlphabetsOnly(value!);
                                                        }),
                                                    SizedBox(
                                                      height: getVerticalSize(5),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: CustomTextField(
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              fieldText: "CNIC No.".tr,
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.servantCnicController
                                                                  : controller.serventcnicControllers[index],
                                                              isFinal: false,
                                                              keyboardType: TextInputType.number,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter.digitsOnly,
                                                                TextInputFormatterWithPattern('#####-#######-#'),
                                                              ],
                                                              limit: HelperFunction.EMAIL_VALIDATION,
                                                              validator: (value) {
                                                                return HelperFunction.cnicValidator(value!);
                                                              }),
                                                        ),
                                                        Expanded(
                                                          child: CustomTextField(
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              fieldText: "Mobile number".tr,
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.servantPhoneController
                                                                  : controller.serventmobileControllers[index],
                                                              isFinal: false,
                                                              keyboardType: TextInputType.phone,
                                                              validator: (value) {
                                                                return HelperFunction.validatePakistaniPhoneNumber(value!);
                                                              }),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: getVerticalSize(15),
                                                    ),
                                                    Padding(
                                                      padding: getPadding(left: 10),
                                                      child: Align(
                                                        alignment: Alignment.topLeft,
                                                        child: MyText(
                                                          title: "Permanent Address",
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: getVerticalSize(5),
                                                    ),
                                                    SizedBox(
                                                      height: getVerticalSize(5),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: CustomTextField(
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              fieldText: "House/Plot".tr,
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.servantHouseController
                                                                  : controller.serventhouseControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.servantRoadController
                                                                  : controller.serventroadControllers[index],
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              fieldText: "Street".tr,
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.servantStreetController
                                                                  : controller.serventstreetControllers[index],
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
                                                              fieldText: "Mohalla/Village".tr,
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.servantVillageController
                                                                  : controller.serventcolonyVillageControllers[index],
                                                              isFinal: false,
                                                              keyboardType: TextInputType.emailAddress,
                                                              validator: (value) {
                                                                return HelperFunction.empthyFieldValidator(value!);
                                                              }),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: getVerticalSize(15),
                                                    ),
                                                    SizedBox(
                                                      height: getVerticalSize(5),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: CustomTextField(
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              fieldText: "Post Office/Thana".tr,
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.servantPoController
                                                                  : controller.serventpostOfficeControllers[index],
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
                                                              fieldText: "City".tr,
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.servantCityController
                                                                  : controller.serventCityControllers[index],
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              fieldText: "Province".tr,
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.servantProvinceController
                                                                  : controller.serventProvinceControllers[index],
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
                                                    if (args['status'] != "")
                                                      if (controller.servantImages[index].path.isEmpty ||
                                                          !controller.servantImages[index].path.startsWith("http"))
                                                        SizedBox.shrink()
                                                      else
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            MyText(title: "Attachment").paddingOnly(left: 10),
                                                            5.verticalSpace,
                                                            Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  radius: BorderRadius.circular(6),
                                                                  border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                                  url: controller.servantFormDataModel.data?.servantDetail?[index].servantImage ?? "",
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
                                                          label: "Attach clear image of your servant".tr,
                                                          textColor: ColorConstant.anbtnBlue,
                                                          borderColor: ColorConstant.anbtnBlue,
                                                          prefix: controller.servantImages[index].path == ""
                                                              ? Icon(
                                                                  Icons.add_circle_outline,
                                                                  color: ColorConstant.anbtnBlue,
                                                                )
                                                              : Icon(
                                                                  Icons.check_circle_sharp,
                                                                  color: ColorConstant.anbtnBlue,
                                                                ),
                                                          onPressed: () async {
                                                            imageGalleryClass.imageGalleryBottomSheet(
                                                              context: context,
                                                              onCameraTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.camera);
                                                                if (result != null) {
                                                                  controller.servantImages[index] = File(result.path);
                                                                }
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                              onGalleryTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.gallery);
                                                                if (result != null) {
                                                                  controller.servantImages[index] = File(result.path);
                                                                }
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      height: getVerticalSize(15),
                                                    ),
                                                    if (args['status'] != "")
                                                      if (controller.servantCnicFronts[index].path.isEmpty ||
                                                          !controller.servantCnicFronts[index].path.startsWith("http"))
                                                        SizedBox.shrink()
                                                      else
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            MyText(title: "Servant CNIC front").paddingOnly(left: 10),
                                                            5.verticalSpace,
                                                            Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  radius: BorderRadius.circular(6),
                                                                  border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                                  url: controller.servantFormDataModel.data?.servantDetail?[index].servantCnicFront ??
                                                                      "",
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
                                                          label: "Attach a servant's CNIC front image".tr,
                                                          textColor: ColorConstant.anbtnBlue,
                                                          borderColor: ColorConstant.anbtnBlue,
                                                          prefix: controller.servantCnicFronts[index].path == ""
                                                              ? Icon(
                                                                  Icons.add_circle_outline,
                                                                  color: ColorConstant.anbtnBlue,
                                                                )
                                                              : Icon(
                                                                  Icons.check_circle_sharp,
                                                                  color: ColorConstant.anbtnBlue,
                                                                ),
                                                          onPressed: () async {
                                                            imageGalleryClass.imageGalleryBottomSheet(
                                                              context: context,
                                                              onCameraTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.camera);
                                                                if (result != null) {
                                                                  controller.servantCnicFronts[index] = File(result.path);
                                                                }
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                              onGalleryTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.gallery);
                                                                if (result != null) {
                                                                  controller.servantCnicFronts[index] = File(result.path);
                                                                }
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      height: getVerticalSize(15),
                                                    ),
                                                    if (args['status'] != "")
                                                      if (controller.servantCnicBacks[index].path.isEmpty ||
                                                          !controller.servantCnicBacks[index].path.startsWith("http"))
                                                        SizedBox.shrink()
                                                      else
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            MyText(title: "Servant CNIC BACK").paddingOnly(left: 10),
                                                            5.verticalSpace,
                                                            Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  radius: BorderRadius.circular(6),
                                                                  border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                                  url: controller.servantFormDataModel.data?.servantDetail?[index].servantCnicBack ??
                                                                      "",
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
                                                          label: "Attach a servant's CNIC back image".tr,
                                                          textColor: ColorConstant.anbtnBlue,
                                                          borderColor: ColorConstant.anbtnBlue,
                                                          prefix: controller.servantCnicBacks[index].path == ""
                                                              ? Icon(
                                                                  Icons.add_circle_outline,
                                                                  color: ColorConstant.anbtnBlue,
                                                                )
                                                              : Icon(
                                                                  Icons.check_circle_sharp,
                                                                  color: ColorConstant.anbtnBlue,
                                                                ),
                                                          onPressed: () async {
                                                            imageGalleryClass.imageGalleryBottomSheet(
                                                              context: context,
                                                              onCameraTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.camera);
                                                                if (result != null) {
                                                                  controller.servantCnicBacks[index] = File(result.path);
                                                                }
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                              onGalleryTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.gallery);
                                                                if (result != null) {
                                                                  controller.servantCnicBacks[index] = File(result.path);
                                                                }
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    // SizedBox(
                                                    //   height: getVerticalSize(15),
                                                    // ),
                                                    // if (args['status'] != Constants.formStatusPending)
                                                    //   Padding(
                                                    //     padding: getPadding(left: 10, right: 10),
                                                    //     child: MyAnimatedButton(
                                                    //       controller: _value.btnControllerUseLess,
                                                    //       radius: 5.0,
                                                    //       height: getVerticalSize(50),
                                                    //       width: getHorizontalSize(400),
                                                    //       fontSize: 16,
                                                    //       bgColor: ColorConstant.anbtnBlue,
                                                    //       title: "Add Servant".tr,
                                                    //       onTap: () async {
                                                    //         if (controller.servantImages.isEmpty) {
                                                    //           Utils.showToast("Please select servant Images", true);
                                                    //         } else if (controller.servantCnicFronts.isEmpty) {
                                                    //           Utils.showToast("Please select servant cnic front images", true);
                                                    //         } else if (controller.servantCnicBacks.isEmpty) {
                                                    //           Utils.showToast("Please select servant cnic back images", true);
                                                    //         } else {
                                                    //           if (args['status'] == "Rejected") {
                                                    //             controller.servantImages.add(File(""));
                                                    //             controller.servantCnicFronts.add(File(""));
                                                    //             controller.servantCnicBacks.add(File(""));
                                                    //             controller.servantFormDataModel.data?.servantDetail?.add(ServantDetail());
                                                    //             setState(() {});
                                                    //           } else {
                                                    //             controller.addServant(index);
                                                    //           }
                                                    //         }
                                                    //       },
                                                    //     ),
                                                    //   ),
                                                    // SizedBox(
                                                    //   height: getVerticalSize(20),
                                                    // ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      );
                                    }),
                                SizedBox(
                                  height: getVerticalSize(10),
                                ),
                                GetBuilder(
                                    init: controller,
                                    builder: (context) {
                                      return CustomExpansionTile(
                                        title: MyText(
                                          title: 'Servants Family Details',
                                          clr: ColorConstant.black900,
                                          fontSize: 16,
                                        ),
                                        children: <Widget>[
                                          AbsorbPointer(
                                            absorbing: !isEditable,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: getPadding(left: 10),
                                                  child: Text(
                                                    "Residing",
                                                    style: AppStyle.txtSourceSansProRegular16Gray600
                                                        .copyWith(fontSize: 16, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: getHorizontalSize(20),
                                                ),
                                                GetBuilder(
                                                  init: controller,
                                                  builder: (controller) {
                                                    return GestureDetector(
                                                      behavior: HitTestBehavior.opaque,
                                                      onTap: () {
                                                        controller.updateFamilyStatus("Yes");
                                                        if (args['status'] == Constants.formStatusRejected) {
                                                          setState(() {
                                                            controller.servantFormDataModel.data?.servantFamilyDetail = [ServantFamilyDetail()];
                                                            controller.addServantFamilyFormKey.add(GlobalKey());
                                                            controller.servantFamilyImages.add(File(""));
                                                          });
                                                        } else {
                                                          controller.servantFamilyImages.add(File(""));
                                                          controller.addServantFamilyFormKey.add(GlobalKey<FormState>());
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          controller.isFamilyResiding == "Yes"
                                                              ? Icon(
                                                                  Icons.circle,
                                                                  color: ColorConstant.blackColor,
                                                                  size: 14,
                                                                )
                                                              : Icon(
                                                                  Icons.circle_outlined,
                                                                  color: ColorConstant.blackColor,
                                                                  size: 14,
                                                                ),
                                                          SizedBox(
                                                            width: getHorizontalSize(10),
                                                          ),
                                                          Text(
                                                            "Yes",
                                                            style: AppStyle.txtSourceSansProRegular16Gray600
                                                                .copyWith(fontSize: 16, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  width: getHorizontalSize(20),
                                                ),
                                                GetBuilder(
                                                  init: controller,
                                                  builder: (controller) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        controller.servantFormDataModel.data?.servantFamilyDetail = null;
                                                        controller.addServantFamilyFormKey.clear();
                                                        controller.servantFamilyImages.clear();
                                                        controller.updateFamilyStatus("No");
                                                        // controller.serventfamfullNameControllers.clear();
                                                        // controller.serventfamoccutionControllers.clear();
                                                        // controller.serventfamCnicControllers.clear();
                                                        // controller.serventfamMobControllers.clear();
                                                        // controller.serventfampresentAddControllers.clear();
                                                        if (args['status'] == Constants.formStatusRejected) {
                                                          setState(() {
                                                            controller.servantFormDataModel.data?.servantFamilyDetail = [ServantFamilyDetail()];
                                                            controller.addServantFamilyFormKey.clear();
                                                            // controller.serventfamfullNameControllers.clear();
                                                            // controller.serventfamoccutionControllers.clear();
                                                            // controller.serventfamCnicControllers.clear();
                                                            // controller.serventfamMobControllers.clear();
                                                            // controller.serventfampresentAddControllers.clear();
                                                            controller.servantFamilyImages.add(File(""));
                                                          });
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          controller.isFamilyResiding == "No"
                                                              ? Icon(
                                                                  Icons.circle,
                                                                  color: ColorConstant.blackColor,
                                                                  size: 14,
                                                                )
                                                              : Icon(
                                                                  Icons.circle_outlined,
                                                                  color: ColorConstant.blackColor,
                                                                  size: 14,
                                                                ),
                                                          SizedBox(
                                                            width: getHorizontalSize(10),
                                                          ),
                                                          Text(
                                                            "No",
                                                            style: AppStyle.txtSourceSansProRegular16Gray600
                                                                .copyWith(fontSize: 16, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(5),
                                          ),
                                          Visibility(
                                            visible: (controller.isFamilyResiding == "Yes") ? true : false,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: args['status'] != ""
                                                  ? (controller.servantFormDataModel.data?.servantFamilyDetail?.length ?? 0) +
                                                      (args['status'] == Constants.formStatusRejected ? 1 : 0)
                                                  : controller.serventfamfullNameControllers.length + 1,
                                              itemBuilder: (context, index) {
                                                servantFamilyIndex = index;
                                                bool isLastIndex = index ==
                                                    (args['status'] != ""
                                                        ? (controller.servantFormDataModel.data?.servantFamilyDetail?.length ?? 0)
                                                        : controller.serventfamfullNameControllers.length);

                                                if (isLastIndex && (args['status'] != Constants.formStatusPending)) {
                                                  return Padding(
                                                    padding: getPadding(left: 10, right: 10, top: 20, bottom: 10),
                                                    child: MyAnimatedButton(
                                                      radius: 5.0,
                                                      height: getVerticalSize(50),
                                                      width: getHorizontalSize(400),
                                                      fontSize: 16,
                                                      bgColor: ColorConstant.anbtnBlue,
                                                      controller: _value.btnControllerUseLess,
                                                      title: "Add Family Member".tr,
                                                      onTap: () async {
                                                        if (args['status'] == Constants.formStatusRejected) {
                                                          if (_value.addServantFamilyFormKey[index - 1].currentState?.validate() ?? true) {
                                                            if (controller.servantFamilyImages[index - 1].path.isEmpty) {
                                                              Utils.showToast("Please select servant Image", true);
                                                            } else {
                                                              controller.servantFamilyImages.add(File(""));
                                                              controller.servantFormDataModel.data?.servantFamilyDetail?.add(ServantFamilyDetail());
                                                              _value.addServantFamilyFormKey.add(GlobalKey<FormState>());
                                                              controller.update();
                                                            }
                                                          }
                                                        } else {
                                                          _value.addServantFamilyFormKey.add(GlobalKey<FormState>());
                                                          await controller.addServantFamily(index - 1);
                                                        }
                                                      },
                                                    ),
                                                  );
                                                }
                                                ServantFamilyDetail? detail;
                                                if ((controller.servantFormDataModel.data?.servantFamilyDetail?.length ?? 0) > 0 &&
                                                    index < (controller.servantFormDataModel.data?.servantFamilyDetail?.length ?? 0)) {
                                                  detail = controller.servantFormDataModel.data?.servantFamilyDetail?[index];
                                                }

                                                return Form(
                                                  key: controller.addServantFamilyFormKey[index],
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      if (index != 0)
                                                        if (args['status'] != Constants.formStatusPending)
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    if (args['status'] == Constants.formStatusRejected) {
                                                                      controller.servantFamilyImages.removeAt(index);
                                                                      controller.servantFormDataModel.data?.servantFamilyDetail?.removeAt(index);
                                                                      controller.addServantFamilyFormKey.removeAt(index);
                                                                    } else {
                                                                      controller.servantFamilyImages.removeAt(index);

                                                                      controller.serventfamfullNameControllers.removeAt(index);
                                                                    }
                                                                  });
                                                                },
                                                                child: Container(
                                                                    margin: EdgeInsets.only(right: 15, top: 10),
                                                                    padding: EdgeInsets.all(8),
                                                                    decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                                                    child: Icon(
                                                                      Icons.delete_outlined,
                                                                      color: Colors.white,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                      MyText(
                                                        title: 'Servant Family  ${index + 1}',
                                                        clr: ColorConstant.black900,
                                                        fontSize: 16,
                                                      ).paddingOnly(left: 10, bottom: 10),
                                                      CustomTextField(
                                                          enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                          fieldText: "Full Name".tr,
                                                          controller: args['status'] == Constants.formStatusRejected
                                                              ? detail?.familyNameController
                                                              : controller.serventfamfullNameControllers[index],
                                                          isFinal: false,
                                                          keyboardType: TextInputType.emailAddress,
                                                          limit: HelperFunction.EMAIL_VALIDATION,
                                                          validator: (value) {
                                                            return HelperFunction.validateAlphabetsOnly(value!);
                                                          }),
                                                      SizedBox(
                                                        height: getVerticalSize(5),
                                                      ),
                                                      CustomTextField(
                                                          enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                          fieldText: "Occupation".tr,
                                                          controller: args['status'] == Constants.formStatusRejected
                                                              ? detail?.familyOccupationController
                                                              : controller.serventfamoccutionControllers[index],
                                                          isFinal: false,
                                                          keyboardType: TextInputType.emailAddress,
                                                          limit: HelperFunction.EMAIL_VALIDATION,
                                                          validator: (value) {
                                                            return HelperFunction.validateAlphabetsOnly(value!);
                                                          }),
                                                      SizedBox(
                                                        height: getVerticalSize(5),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: CustomTextField(
                                                                enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                                fieldText: "N.I.C / FORM ‘B’".tr,
                                                                controller: args['status'] == Constants.formStatusRejected
                                                                    ? detail?.familyNicController
                                                                    : controller.serventfamCnicControllers[index],
                                                                isFinal: false,
                                                                keyboardType: TextInputType.phone,
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter.digitsOnly,
                                                                  TextInputFormatterWithPattern('#####-#######-#'),
                                                                ],
                                                                limit: HelperFunction.EMAIL_VALIDATION,
                                                                validator: (value) {
                                                                  return HelperFunction.cnicValidator(value!);
                                                                }),
                                                          ),
                                                          Expanded(
                                                            child: CustomTextField(
                                                                enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                                fieldText: "Mobile number".tr,
                                                                controller: args['status'] == Constants.formStatusRejected
                                                                    ? detail?.familyCellController
                                                                    : controller.serventfamMobControllers[index],
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
                                                      CustomTextField(
                                                          enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                          fieldText: "Present Address".tr,
                                                          controller: args['status'] == Constants.formStatusRejected
                                                              ? detail?.familyAddressController
                                                              : controller.serventfampresentAddControllers[index],
                                                          isFinal: false,
                                                          keyboardType: TextInputType.emailAddress,
                                                          limit: HelperFunction.EMAIL_VALIDATION,
                                                          validator: (value) {
                                                            return HelperFunction.empthyFieldValidator(value!);
                                                          }),
                                                      SizedBox(
                                                        height: getVerticalSize(15),
                                                      ),
                                                      if (args['status'] != "")
                                                        if (controller.servantFamilyImages[index].path.isEmpty ||
                                                            !controller.servantFamilyImages[index].path.startsWith("http"))
                                                          SizedBox.shrink()
                                                        else
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              MyText(title: "Attachment").paddingOnly(left: 10),
                                                              5.verticalSpace,
                                                              Padding(
                                                                padding: getPadding(left: 10, right: 10),
                                                                child: Container(
                                                                  width: getHorizontalSize(350),
                                                                  color: ColorConstant.whiteA700,
                                                                  child: CustomImageView(
                                                                    radius: BorderRadius.circular(6),
                                                                    border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                                    url: controller
                                                                            .servantFormDataModel.data?.servantFamilyDetail?[index].attachment ??
                                                                        "",
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
                                                            label: "Attach clear image of servant".tr,
                                                            textColor: ColorConstant.anbtnBlue,
                                                            borderColor: ColorConstant.anbtnBlue,
                                                            prefix: controller.servantFamilyImages[index].path == "" ||
                                                                    controller.servantFamilyImages[index].isBlank!
                                                                ? Icon(
                                                                    Icons.add_circle_outline,
                                                                    color: ColorConstant.anbtnBlue,
                                                                  )
                                                                : Icon(
                                                                    Icons.check_circle_sharp,
                                                                    color: ColorConstant.anbtnBlue,
                                                                  ),
                                                            onPressed: () async {
                                                              imageGalleryClass.imageGalleryBottomSheet(
                                                                context: context,
                                                                onCameraTap: () async {
                                                                  final result = await imageGalleryClass.getImage(ImageSource.camera);
                                                                  if (result != null) {
                                                                    controller.servantFamilyImages[index] = File(result.path);
                                                                  }
                                                                  setState(() {});
                                                                  Get.back();
                                                                },
                                                                onGalleryTap: () async {
                                                                  final result = await imageGalleryClass.getImage(ImageSource.gallery);
                                                                  if (result != null) {
                                                                    controller.servantFamilyImages[index] = File(result.path);
                                                                  }
                                                                  setState(() {});
                                                                  Get.back();
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                                SizedBox(
                                  height: getVerticalSize(10),
                                ),
                                CustomExpansionTile(
                                  title: MyText(
                                    title: 'Add Signature',
                                    clr: ColorConstant.black900,
                                    fontSize: 16,
                                    customWeight: FontWeight.w600,
                                  ),
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CustomTextField(
                                                enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                fieldText: "SIGNATURE OF OWNER:".tr,
                                                readOnly: true,
                                                fontStyle: FontStyle.italic,
                                                controller: controller.fullNameController,
                                                isFinal: false,
                                                keyboardType: TextInputType.emailAddress,
                                                limit: HelperFunction.EMAIL_VALIDATION,
                                                validator: (value) {
                                                  return HelperFunction.empthyFieldValidator(value!);
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextField(
                                                enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                fieldText: "mm/dd/yyyy".tr,
                                                readOnly: true,
                                                controller: controller.serventdateController,
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
                                          height: getVerticalSize(5),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: getVerticalSize(15),
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
                                      controller: (args['status'] == Constants.formStatusRejected)
                                          ? _value.submitEdittedFormButtonController
                                          : _value.btnController,
                                      title: "Submit".tr,
                                      onTap: () async {
                                        (args['status'] == Constants.formStatusRejected)
                                            ? _value.submitEditServantApi(
                                                context,
                                                args['id'],
                                                servantIndex - 1,
                                                servantFamilyIndex - 1,
                                              )
                                            : _value.submitServantApi(
                                                context,
                                                servantIndex - 1,
                                                servantFamilyIndex - 1,
                                              );
                                      },
                                    ),
                                  ),
                                if (kDebugMode)
                                  ElevatedButton(
                                      onPressed: () => _value.submitEditServantApi(
                                            context,
                                            args['id'],
                                            servantIndex - 1,
                                            servantFamilyIndex - 1,
                                          ),
                                      child: Text("Test button")),
                                SizedBox(
                                  height: getVerticalSize(20),
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
