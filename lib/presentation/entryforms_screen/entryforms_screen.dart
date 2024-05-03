import 'package:anchorageislamabad/core/utils/utils.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

    controller.spouseImage = null;
    controller.spouseCnicFront = null;
    controller.spouseCnicBack = null;

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
                                            fontSize: 12,
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
                                            fontSize: 12,
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
                                            fontSize: 12,
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
                              Form(
                                key: controller.spouseEntryFormKey,
                                child: CustomExpansionTile(
                                  title: MyText(
                                    title: 'Spouse',
                                    clr: ColorConstant.black900,
                                    fontSize: 16,
                                  ),
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        if (controller.spouseDataIndex != 0)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 15),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                                child: MyText(
                                                  title: controller.spouseDataIndex.toString(),
                                                  clr: ColorConstant.whiteA700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        CustomTextField(
                                          fieldText: "Full Name".tr,
                                          controller: controller.spousefullNameController,
                                          isFinal: false,
                                          keyboardType: TextInputType.emailAddress,
                                          limit: HelperFunction.EMAIL_VALIDATION,
                                          validator: controller.spouseDataIndex > 1
                                              ? (value) {
                                                  return HelperFunction.empthyFieldValidator(value!);
                                                }
                                              : null,
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(5),
                                        ),
                                        CustomTextField(
                                          fieldText: "Father’s Name".tr,
                                          controller: controller.spousefathersController,
                                          isFinal: false,
                                          keyboardType: TextInputType.emailAddress,
                                          limit: HelperFunction.EMAIL_VALIDATION,
                                          validator: controller.spouseDataIndex > 1
                                              ? (value) {
                                                  return HelperFunction.empthyFieldValidator(value!);
                                                }
                                              : null,
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
                                                controller: controller.spousecnicController,
                                                isFinal: false,
                                                keyboardType: TextInputType.phone,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  TextInputFormatterWithPattern('#####-#######-#'),
                                                ],
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Mobile number".tr,
                                                controller: controller.spousemobileController,
                                                isFinal: false,
                                                keyboardType: TextInputType.phone,
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
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
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "House/Plot".tr,
                                                controller: controller.spousehouseController,
                                                isFinal: false,
                                                keyboardType: TextInputType.emailAddress,
                                                limit: HelperFunction.EMAIL_VALIDATION,
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Road".tr,
                                                controller: controller.spouseroadController,
                                                isFinal: false,
                                                keyboardType: TextInputType.emailAddress,
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
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
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Street".tr,
                                                controller: controller.spousestreetController,
                                                isFinal: false,
                                                keyboardType: TextInputType.emailAddress,
                                                limit: HelperFunction.EMAIL_VALIDATION,
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
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
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Mohalla/Village.".tr,
                                                controller: controller.spouseMohallaController,
                                                isFinal: false,
                                                keyboardType: TextInputType.text,
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Post Office/Thana".tr,
                                                controller: controller.spouseThanaController,
                                                isFinal: false,
                                                keyboardType: TextInputType.text,
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
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
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "City".tr,
                                                controller: controller.spouseCityController,
                                                isFinal: false,
                                                keyboardType: TextInputType.text,
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Province".tr,
                                                controller: controller.spouseProvinceController,
                                                isFinal: false,
                                                keyboardType: TextInputType.text,
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
                                              ),
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstant.whiteA700,
                                            label: "Attach a clear image of spouse".tr,
                                            textColor: ColorConstant.anbtnBlue,
                                            borderColor: ColorConstant.anbtnBlue,
                                            prefix: Icon(
                                              controller.spouseImage != null
                                                  ? Icons.check_circle_sharp
                                                  : Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                            ),
                                            onPressed: () async {
                                              controller.spouseImage = await controller.imagePicker();
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstant.whiteA700,
                                            label: "Attach a clear image of spouse CNIC front side".tr,
                                            textColor: ColorConstant.anbtnBlue,
                                            borderColor: ColorConstant.anbtnBlue,
                                            prefix: Icon(
                                              controller.spouseCnicFront != null
                                                  ? Icons.check_circle_sharp
                                                  : Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                            ),
                                            onPressed: () async {
                                              controller.spouseCnicFront = await controller.imagePicker();
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstant.whiteA700,
                                            label: "Attach a clear image of Spouse CNIC back side".tr,
                                            textColor: ColorConstant.anbtnBlue,
                                            borderColor: ColorConstant.anbtnBlue,
                                            prefix: Icon(
                                              controller.spouseCnicBack != null
                                                  ? Icons.check_circle_sharp
                                                  : Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                            ),
                                            onPressed: () async {
                                              controller.spouseCnicBack = await controller.imagePicker();
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
                                              if (controller.spouseImage == null) {
                                                Utils.showToast(
                                                  "Please select image of spouse",
                                                  true,
                                                );
                                              } else if (controller.spouseCnicFront == null) {
                                                Utils.showToast(
                                                  "Please select image of spouse CNIC front side",
                                                  true,
                                                );
                                              } else if (controller.spouseCnicBack == null) {
                                                Utils.showToast(
                                                  "Please select image of spouse CNIC back side",
                                                  true,
                                                );
                                              } else {
                                                controller.spouseEntryFormAPi(context);
                                              }
                                            },
                                          ),
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
                              Form(
                                key: controller.childEntryFormKey,
                                child: CustomExpansionTile(
                                  title: MyText(
                                    title: 'Child',
                                    clr: ColorConstant.black900,
                                    fontSize: 16,
                                  ),
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        if (controller.childDataIndex != 0)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 15),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                                child: MyText(
                                                  title: controller.childDataIndex.toString(),
                                                  clr: ColorConstant.whiteA700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        CustomTextField(
                                          fieldText: "Full Name".tr,
                                          controller: controller.childfullNameController,
                                          isFinal: false,
                                          keyboardType: TextInputType.emailAddress,
                                          limit: HelperFunction.EMAIL_VALIDATION,
                                          validator: controller.childDataIndex > 1
                                              ? (value) {
                                                  return HelperFunction.empthyFieldValidator(value!);
                                                }
                                              : null,
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(5),
                                        ),
                                        CustomTextField(
                                          fieldText: "Father’s Name".tr,
                                          controller: controller.childfathersController,
                                          isFinal: false,
                                          keyboardType: TextInputType.emailAddress,
                                          limit: HelperFunction.EMAIL_VALIDATION,
                                          validator: controller.childDataIndex > 1
                                              ? (value) {
                                                  return HelperFunction.empthyFieldValidator(value!);
                                                }
                                              : null,
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
                                                controller: controller.childcnicController,
                                                isFinal: false,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  TextInputFormatterWithPattern('#####-#######-#'),
                                                ],
                                                keyboardType: TextInputType.number,
                                                limit: HelperFunction.EMAIL_VALIDATION,
                                                validator: controller.childDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Mobile number".tr,
                                                controller: controller.childmobileController,
                                                isFinal: false,
                                                keyboardType: TextInputType.phone,
                                                validator: controller.childDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
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
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "House/Plot".tr,
                                                controller: controller.childhouseController,
                                                isFinal: false,
                                                keyboardType: TextInputType.emailAddress,
                                                limit: HelperFunction.EMAIL_VALIDATION,
                                                validator: controller.childDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Road".tr,
                                                controller: controller.childroadController,
                                                isFinal: false,
                                                keyboardType: TextInputType.emailAddress,
                                                validator: controller.childDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(15),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Street".tr,
                                                controller: controller.childstreetController,
                                                isFinal: false,
                                                keyboardType: TextInputType.emailAddress,
                                                limit: HelperFunction.EMAIL_VALIDATION,
                                                validator: controller.childDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
                                              ),
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
                                                fieldText: "Mohalla/Village.".tr,
                                                controller: controller.childMohallaController,
                                                isFinal: false,
                                                keyboardType: TextInputType.text,
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Post Office/Thana".tr,
                                                controller: controller.childThanaController,
                                                isFinal: false,
                                                keyboardType: TextInputType.text,
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
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
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "City".tr,
                                                controller: controller.childCityController,
                                                isFinal: false,
                                                keyboardType: TextInputType.text,
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextField(
                                                fieldText: "Province".tr,
                                                controller: controller.childProvinceController,
                                                isFinal: false,
                                                keyboardType: TextInputType.text,
                                                validator: controller.spouseDataIndex > 1
                                                    ? (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }
                                                    : null,
                                              ),
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstant.whiteA700,
                                            label: "Attach a clear image of child".tr,
                                            textColor: ColorConstant.anbtnBlue,
                                            borderColor: ColorConstant.anbtnBlue,
                                            prefix: Icon(
                                              controller.childImage != null
                                                  ? Icons.check_circle_sharp
                                                  : Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                            ),
                                            onPressed: () async {
                                              controller.childImage = await controller.imagePicker();
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstant.whiteA700,
                                            label: "Attach a clear image of child CNIC front sides".tr,
                                            textColor: ColorConstant.anbtnBlue,
                                            borderColor: ColorConstant.anbtnBlue,
                                            prefix: Icon(
                                              controller.childCnicFront != null
                                                  ? Icons.check_circle_sharp
                                                  : Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                            ),
                                            onPressed: () async {
                                              controller.childCnicFront = await controller.imagePicker();
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstant.whiteA700,
                                            label: "Attach a clear image of child CNIC back side".tr,
                                            textColor: ColorConstant.anbtnBlue,
                                            borderColor: ColorConstant.anbtnBlue,
                                            prefix: Icon(
                                              controller.childCnicBack != null
                                                  ? Icons.check_circle_sharp
                                                  : Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                            ),
                                            onPressed: () async {
                                              controller.childCnicBack = await controller.imagePicker();
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
                                              controller.childEntryFormAPi(context);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
