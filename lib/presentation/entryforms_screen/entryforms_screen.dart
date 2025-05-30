import 'dart:developer';
import 'dart:io';

import 'package:anchorageislamabad/core/utils/constants.dart';
import 'package:anchorageislamabad/core/utils/image_gallery.dart';
import 'package:anchorageislamabad/core/utils/utils.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/presentation/entryforms_screen/models/entry_form_data_model.dart';
import 'package:anchorageislamabad/theme/app_style.dart';
import 'package:anchorageislamabad/widgets/custom_image_view.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/foundation.dart';
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
  final ImageGalleryClass imageGalleryClass = ImageGalleryClass();

  bool isEditable = false;

  final args = Get.arguments;

  @override
  void initState() {
    if (args['status'] == Constants.formStatusRejected || args['status'] == "") {
      isEditable = true;
    }
    controller.spouseImages.clear();
    controller.childDataIndex = 0;
    controller.spouseDataIndex = 0;
    controller.ownerImage = null;
    controller.ownerCnicFront = null;
    controller.ownerCnicBack = null;
    Future.delayed(Duration(), () {
      args['status'] != "" ? controller.getEntryFormsDetails(args['id']) : null;
      args['status'] != "" ? null : controller.addSpouse();
      args['status'] != "" ? null : controller.addChild();
    });

    super.initState();
  }

  int childIndex = 0;
  int spouseIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
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
                                          title: "Rejection Reason : " + (controller.entryFormDataModel.data?.rejection_reason ?? ""),
                                          fontSize: 20,
                                          clr: ColorConstant.apppWhite,
                                        )),
                                  ),
                                SizedBox(
                                  height: getVerticalSize(10),
                                ),
                                Form(
                                  key: controller.EntryCardFormKey,
                                  child: CustomExpansionTile(
                                    expanded: args['status'] == "Rejected",
                                    title: MyText(
                                      title: 'OWNER INFORMATION',
                                      clr: ColorConstant.black900,
                                      fontSize: 16,
                                    ),
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                            height: getVerticalSize(10),
                                          ),
                                          Text(
                                            "Block/COMM ",
                                            style: AppStyle.txtSourceSansProRegular16Gray600
                                                .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                          ).paddingOnly(
                                            left: 14,
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
                                                            controller.streetSelectedValue = null;
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
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: GetBuilder(
                                                    init: controller,
                                                    builder: (context) {
                                                      return Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "Street ",
                                                            style: AppStyle.txtSourceSansProRegular16Gray600
                                                                .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                          ).paddingOnly(
                                                            left: 14,
                                                          ),
                                                          DropdownButton<Street>(
                                                            isExpanded: true,
                                                            hint: controller.streetSelectedValue?.title == null
                                                                ? Text(
                                                                    "Select",
                                                                    style: TextStyle(
                                                                      fontSize: 14,
                                                                      color: ColorConstant.blackColor.withOpacity(0.5),
                                                                      fontFamily: AppFonts.lucidaBright,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  )
                                                                : Text(controller.streetSelectedValue!.title.toString()),
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
                                                                controller.plotstSelectedValue = null;
                                                                controller.getPlotNoByStreet(value!.id);
                                                              });
                                                            },
                                                          ).paddingOnly(left: 12),
                                                        ],
                                                      );
                                                    }),
                                              ),
                                              GetBuilder(
                                                  init: controller,
                                                  builder: (context) {
                                                    return Expanded(
                                                        child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Plot ",
                                                          style: AppStyle.txtSourceSansProRegular16Gray600
                                                              .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                        ).paddingOnly(
                                                          left: 14,
                                                        ),
                                                        DropdownButton<Plots>(
                                                          isExpanded: true,
                                                          hint: controller.plotstSelectedValue == null
                                                              ? Text(
                                                                  controller.plots.isEmpty ? "Select" : controller.plotPlaceHolder,
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
                                                        ).paddingOnly(left: 12),
                                                      ],
                                                    ).paddingOnly(right: 12));
                                                  })
                                            ],
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(15),
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
                                                      url: controller.entryFormDataModel.data?.image ?? "",
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
                                                  controller.ownerImage = null;
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
                                                      url: controller.entryFormDataModel.data?.cnicImageFront ?? "",
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
                                                label: "Attach image of your CNIC front side".tr,
                                                textColor: ColorConstant.anbtnBlue,
                                                borderColor: ColorConstant.anbtnBlue,
                                                prefix: Icon(
                                                  controller.ownerCnicFront != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                  color: ColorConstant.anbtnBlue,
                                                  size: 19.r,
                                                ),
                                                onPressed: () async {
                                                  controller.ownerCnicFront = null;

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
                                                      url: controller.entryFormDataModel.data?.cnicImageBack ?? "",
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
                                                label: "Attach image of your CNIC back side".tr,
                                                textColor: ColorConstant.anbtnBlue,
                                                borderColor: ColorConstant.anbtnBlue,
                                                prefix: Icon(
                                                  controller.ownerCnicBack != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                  color: ColorConstant.anbtnBlue,
                                                  size: 19.r,
                                                ),
                                                onPressed: () async {
                                                  controller.ownerCnicBack = null;

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
                                      return CustomExpansionTile(
                                        expanded: args['status'] == "Rejected",
                                        title: MyText(
                                          title: 'Spouse',
                                          clr: ColorConstant.black900,
                                          fontSize: 16,
                                        ),
                                        children: <Widget>[
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: args['status'] != ""
                                                ? (controller.entryFormDataModel.data?.spouseDetail?.length ?? 0) +
                                                    (args['status'] == Constants.formStatusRejected ? 1 : 0)
                                                : controller.spousefullNameControllers.length + 1,
                                            itemBuilder: (context, index) {
                                              spouseIndex = index;
                                              bool isLastIndex = index ==
                                                  (args['status'] != ""
                                                      ? (controller.entryFormDataModel.data?.spouseDetail?.length ?? 0)
                                                      : controller.spousefullNameControllers.length);

                                              if (isLastIndex && (args['status'] == Constants.formStatusRejected || args['status'] == "")) {
                                                return Padding(
                                                  padding: getPadding(left: 10, right: 10, top: 20, bottom: 10),
                                                  child: MyAnimatedButton(
                                                    radius: 5.0,
                                                    height: getVerticalSize(50),
                                                    width: getHorizontalSize(400),
                                                    fontSize: 16,
                                                    bgColor: ColorConstant.anbtnBlue,
                                                    controller: controller.btnControllerUseLess,
                                                    title: "Add Spouse".tr,
                                                    onTap: () async {
                                                      if (args['status'] == Constants.formStatusRejected) {
                                                        if (_value.spouseEntryFormKey[index - 1].currentState?.validate() ?? true) {
                                                          if (controller.spouseImages[index - 1].path == "") {
                                                            Utils.showToast("Please attach spouse image", true);
                                                          } else if (controller.spouseCnicsfronts[index - 1].path == "") {
                                                            Utils.showToast("Please attach spouse cnic front image", true);
                                                          } else if (controller.spouseCnicBacks[index - 1].path == "") {
                                                            Utils.showToast("Please attach spouse cnic back image", true);
                                                          } else {
                                                            controller.spouseImages.add(File(""));
                                                            controller.spouseCnicsfronts.add(File(""));
                                                            controller.spouseCnicBacks.add(File(""));
                                                            controller.entryFormDataModel.data?.spouseDetail?.add(SpouseDetail());
                                                            _value.spouseEntryFormKey.add(GlobalKey());
                                                            controller.update();
                                                          }
                                                        }
                                                      } else {
                                                        _value.spouseEntryFormKey.add(GlobalKey());
                                                        controller.spouseEntryFormAPi(context, index - 1);
                                                      }
                                                    },
                                                  ),
                                                );
                                              }
                                              SpouseDetail? detail;
                                              if ((controller.entryFormDataModel.data?.spouseDetail?.length ?? 0) > 0 &&
                                                  index < (controller.entryFormDataModel.data?.spouseDetail?.length ?? 0)) {
                                                detail = controller.entryFormDataModel.data?.spouseDetail?[index];
                                              }

                                              return Form(
                                                key: controller.spouseEntryFormKey[index],
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
                                                                    controller.spouseImages.removeAt(index);
                                                                    controller.spouseCnicsfronts.removeAt(index);
                                                                    controller.spouseCnicBacks.removeAt(index);
                                                                    controller.entryFormDataModel.data?.spouseDetail?.removeAt(index);
                                                                  } else {
                                                                    controller.spousefullNameControllers.removeAt(index);
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
                                                      title: 'Spouse ${index + 1}',
                                                      clr: ColorConstant.black900,
                                                      fontSize: 16,
                                                    ).paddingOnly(left: 10, bottom: 10),
                                                    CustomTextField(
                                                        fieldText: "Full Name".tr,
                                                        controller: args['status'] == Constants.formStatusRejected
                                                            ? detail?.spouseNameController
                                                            : controller.spousefullNameControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.spouseCnicController
                                                                  : controller.spousecnicControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.spousePhoneController
                                                                  : controller.spousemobileControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.spouseHouseController
                                                                  : controller.spousehouseControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.spouseRoadController
                                                                  : controller.spouseroadControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.spouseStreetController
                                                                  : controller.spousestreetControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.spouseVillageController
                                                                  : controller.spouseMohallaControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.spousePoController
                                                                  : controller.spouseThanaControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.spouseCityController
                                                                  : controller.spouseCityControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.spouseProvinceController
                                                                  : controller.spouseProvinceControllers[index],
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
                                                    if (args['status'] != "")
                                                      if (controller.spouseImages[index].path.isEmpty ||
                                                          !controller.spouseImages[index].path.startsWith("http"))
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
                                                                  url: controller.entryFormDataModel.data?.spouseDetail?[index].spouseImage ?? "",
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
                                                            imageGalleryClass.imageGalleryBottomSheet(
                                                              context: context,
                                                              onCameraTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.camera);
                                                                if (result != null) {
                                                                  controller.spouseImages[index] = File(result.path);
                                                                }
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                              onGalleryTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.gallery);
                                                                if (result != null) {
                                                                  controller.spouseImages[index] = File(result.path);
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
                                                      if (controller.spouseCnicsfronts[index].path.isEmpty ||
                                                          !controller.spouseCnicsfronts[index].path.startsWith("http"))
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
                                                                  url: controller.entryFormDataModel.data?.spouseDetail?[index].spouseCnicFront ?? "",
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
                                                          label: "Attach a spouse's CNIC front image".tr,
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
                                                            imageGalleryClass.imageGalleryBottomSheet(
                                                              context: context,
                                                              onCameraTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.camera);
                                                                if (result != null) {
                                                                  controller.spouseCnicsfronts[index] = File(result.path);
                                                                }
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                              onGalleryTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.gallery);
                                                                if (result != null) {
                                                                  controller.spouseCnicsfronts[index] = File(result.path);
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
                                                      if (controller.spouseCnicBacks[index].path.isEmpty ||
                                                          !controller.spouseCnicBacks[index].path.startsWith("http"))
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
                                                                  url: controller.entryFormDataModel.data?.spouseDetail?[index].spouseCnicBack ?? "",
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
                                                          label: "Attach a spouse's CNIC back image".tr,
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
                                                            imageGalleryClass.imageGalleryBottomSheet(
                                                              context: context,
                                                              onCameraTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.camera);
                                                                if (result != null) {
                                                                  controller.spouseCnicBacks[index] = File(result.path);
                                                                }
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                              onGalleryTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.gallery);
                                                                if (result != null) {
                                                                  controller.spouseCnicBacks[index] = File(result.path);
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
                                        expanded: args['status'] == "Rejected",
                                        title: MyText(
                                          title: 'Child',
                                          clr: ColorConstant.black900,
                                          fontSize: 16,
                                        ),
                                        children: <Widget>[
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: args['status'] != ""
                                                ? (controller.entryFormDataModel.data?.childDetail?.length ?? 0) +
                                                    (args['status'] == Constants.formStatusRejected ? 1 : 0)
                                                : controller.childfullNameControllers.length + 1,
                                            itemBuilder: (context, index) {
                                              childIndex = index;
                                              bool isLastIndex = index ==
                                                  (args['status'] != ""
                                                      ? (controller.entryFormDataModel.data?.childDetail?.length ?? 0)
                                                      : controller.childfullNameControllers.length);

                                              if (isLastIndex && (args['status'] == Constants.formStatusRejected || args['status'] == "")) {
                                                return Padding(
                                                  padding: getPadding(left: 10, right: 10, top: 20, bottom: 10),
                                                  child: MyAnimatedButton(
                                                    radius: 5.0,
                                                    height: getVerticalSize(50),
                                                    width: getHorizontalSize(400),
                                                    fontSize: 16,
                                                    bgColor: ColorConstant.anbtnBlue,
                                                    controller: controller.btnControllerUseLess,
                                                    title: "Add Child".tr,
                                                    onTap: () async {
                                                      if (args['status'] == Constants.formStatusRejected) {
                                                        if (_value.childEntryFormKey[index - 1].currentState?.validate() ?? true) {
                                                          if (controller.childImages[index - 1].path == "") {
                                                            Utils.showToast("Please attach child image", true);
                                                          } else if (controller.childCnicsfronts[index - 1].path == "") {
                                                            Utils.showToast("Please attach child cnic front image", true);
                                                          } else if (controller.childCnicBacks[index - 1].path == "") {
                                                            Utils.showToast("Please attach child cnic back image", true);
                                                          } else {
                                                            controller.childImages.add(File(""));
                                                            controller.childCnicsfronts.add(File(""));
                                                            controller.childCnicBacks.add(File(""));
                                                            controller.entryFormDataModel.data?.childDetail?.add(ChildDetail());
                                                            _value.childEntryFormKey.add(GlobalKey<FormState>());
                                                            controller.update();
                                                          }
                                                        }
                                                      } else {
                                                        _value.childEntryFormKey.add(GlobalKey<FormState>());

                                                        controller.childEntryFormAPi(context, index - 1);
                                                      }
                                                    },
                                                  ),
                                                );
                                              }
                                              ChildDetail? detail;
                                              if ((controller.entryFormDataModel.data?.childDetail?.length ?? 0) > 0 &&
                                                  index < (controller.entryFormDataModel.data?.childDetail?.length ?? 0)) {
                                                detail = controller.entryFormDataModel.data?.childDetail?[index];
                                              }

                                              return Form(
                                                key: controller.childEntryFormKey[index],
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
                                                                    controller.childImages.removeAt(index);
                                                                    controller.childCnicsfronts.removeAt(index);
                                                                    controller.childCnicBacks.removeAt(index);

                                                                    controller.entryFormDataModel.data?.childDetail?.removeAt(index);
                                                                  } else {
                                                                    controller.childfullNameControllers.removeAt(index);
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
                                                      title: 'Child ${index + 1}',
                                                      clr: ColorConstant.black900,
                                                      fontSize: 16,
                                                    ).paddingOnly(left: 10, bottom: 10),
                                                    CustomTextField(
                                                        fieldText: "Full Name".tr,
                                                        controller: args['status'] == Constants.formStatusRejected
                                                            ? detail?.childNameController
                                                            : controller.childfullNameControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.childCnicController
                                                                  : controller.childcnicControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.childPhoneController
                                                                  : controller.childmobileControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.childHouseController
                                                                  : controller.childhouseControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.childRoadController
                                                                  : controller.childroadControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.childStreetController
                                                                  : controller.childstreetControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.childVillageController
                                                                  : controller.childMohallaControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.childPoController
                                                                  : controller.childThanaControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.childCityController
                                                                  : controller.childCityControllers[index],
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
                                                              controller: args['status'] == Constants.formStatusRejected
                                                                  ? detail?.childProvinceController
                                                                  : controller.childProvinceControllers[index],
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
                                                    if (args['status'] != "")
                                                      if (controller.childImages[index].path.isEmpty ||
                                                          !controller.childImages[index].path.startsWith("http"))
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
                                                                  url: controller.entryFormDataModel.data?.childDetail?[index].childImage ?? "",
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
                                                            imageGalleryClass.imageGalleryBottomSheet(
                                                              context: context,
                                                              onCameraTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.camera);
                                                                if (result != null) {
                                                                  controller.childImages[index] = File(result.path);
                                                                }
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                              onGalleryTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.gallery);
                                                                if (result != null) {
                                                                  controller.childImages[index] = File(result.path);
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
                                                      if (controller.childCnicsfronts[index].path.isEmpty ||
                                                          !controller.childCnicsfronts[index].path.startsWith("http"))
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
                                                                  url: controller.entryFormDataModel.data?.childDetail?[index].childCnicFront ?? "",
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
                                                          label: "Attach child's CNIC front images".tr,
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
                                                            imageGalleryClass.imageGalleryBottomSheet(
                                                              context: context,
                                                              onCameraTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.camera);
                                                                if (result != null) {
                                                                  controller.childCnicsfronts[index] = File(result.path);
                                                                }
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                              onGalleryTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.gallery);
                                                                if (result != null) {
                                                                  controller.childCnicsfronts[index] = File(result.path);
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
                                                      if (controller.childCnicBacks[index].path.isEmpty ||
                                                          !controller.childCnicBacks[index].path.startsWith("http"))
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
                                                                  url: controller.entryFormDataModel.data?.childDetail?[index].childCnicBack ?? "",
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
                                                          label: "Attach child's CNIC back images".tr,
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
                                                            imageGalleryClass.imageGalleryBottomSheet(
                                                              context: context,
                                                              onCameraTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.camera);
                                                                if (result != null) {
                                                                  controller.childCnicBacks[index] = File(result.path);
                                                                }
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                              onGalleryTap: () async {
                                                                final result = await imageGalleryClass.getImage(ImageSource.gallery);
                                                                if (result != null) {
                                                                  controller.childCnicBacks[index] = File(result.path);
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
                                          )
                                        ],
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
                                      controller: (args['status'] == Constants.formStatusRejected)
                                          ? _value.submitEdittedFormButtonController
                                          : _value.btnController,
                                      title: "Submit".tr,
                                      onTap: () async {
                                        (args['status'] == Constants.formStatusRejected)
                                            ? controller.SubmitEdittedEntryFormApi(
                                                context,
                                                args['id'],
                                                childIndex > 0 ? childIndex - 1 : 1,
                                                spouseIndex > 0 ? spouseIndex - 1 : 1,
                                              )
                                            : controller.SubmitEntryFormApi(context);
                                      },
                                    ),
                                  ),
                                if (kDebugMode)
                                  ElevatedButton(
                                      onPressed: () => controller.SubmitEdittedEntryFormApi(context, args['id'], 0, 0), child: Text("data"))
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
