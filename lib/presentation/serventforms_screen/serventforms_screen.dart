import 'package:anchorageislamabad/core/utils/app_fonts.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/animated_custom_button.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_expensiontile.dart';
import '../../widgets/custom_textfield_new.dart';
import 'controller/serventforms_controller.dart';

class ServentFormsScreen extends StatefulWidget {
  @override
  State<ServentFormsScreen> createState() => _ServentFormsScreenState();
}

class _ServentFormsScreenState extends State<ServentFormsScreen> {
  ServentFormsController controller = Get.put(ServentFormsController());

  @override
  void initState() {
    controller.servantDataIndex = 0;
    controller.servantFamilyDataIndex = 0;
    controller.servantCnicBack = null;
    controller.servantCnicFront = null;
    controller.servantImage = null;
    controller.servantData = {};
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: getPadding(left: 10),
          child: Column(
            children: [
              CustomAppBar(
                title: MyText(
                  title: "Servant Card",
                  clr: ColorConstant.whiteA700,
                  fontSize: 20,
                  customWeight: FontWeight.w500,
                ),
                centerTitle: true,
                leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios)),
                trailing: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Get.toNamed(AppRoutes.menuPage);
                  },
                ),
              ),
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
                                                keyboardType: TextInputType.emailAddress,
                                                limit: HelperFunction.EMAIL_VALIDATION,
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
                                                            controller.streets.isEmpty ? "Please wait..." : "Streets ",
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
                                                      controller.streets.isEmpty ? "Please wait..." : "Streets",
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
                                                                ? "Please wait..."
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
                                                          ? "Please wait..."
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
                                                fieldText: "Block".tr,
                                                controller: controller.blockController,
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
                                              Icons.add_circle_outline,
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
                                              Icons.add_circle_outline,
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
                                              Icons.add_circle_outline,
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
                                        //   padding: getPadding(left: 10,right: 10),
                                        //   child: MyAnimatedButton(
                                        //     radius: 5.0,
                                        //     height: getVerticalSize(50),
                                        //     width: getHorizontalSize(400),
                                        //     fontSize: 16 ,
                                        //     bgColor: ColorConstant.anbtnBlue,
                                        //     controller: controller.btnController,
                                        //     title: "Add Owner Information".tr,
                                        //     onTap: () async {
                                        //       // controller.loginAPI(context);
                                        //     },
                                        //   ),
                                        // ),
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
                              Form(
                                key: controller.addServantFormKey,
                                child: CustomExpansionTile(
                                  title: MyText(
                                    title: 'Servent Information',
                                    clr: ColorConstant.black900,
                                    fontSize: 16,
                                  ),
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        if (_value.servantDataIndex != 0)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 15),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                                child: MyText(
                                                  title: _value.servantDataIndex.toString(),
                                                  clr: ColorConstant.whiteA700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        CustomTextField(
                                          fieldText: "Full Name".tr,
                                          controller: controller.serventfullNameController,
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
                                          controller: controller.serventfathersController,
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
                                                controller: controller.serventcnicController,
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
                                                fieldText: "Mobile number".tr,
                                                controller: controller.serventmobileController,
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
                                          width: getHorizontalSize(330),
                                          child: DropdownButton(
                                            isExpanded: true,
                                            padding: EdgeInsets.symmetric(horizontal: 2),
                                            hint: controller.servantselectedValue == null
                                                ? Text(
                                                    "Block/COMM ",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: ColorConstant.blackColor.withOpacity(0.5),
                                                      fontFamily: AppFonts.lucidaBright,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  )
                                                : Text(controller.servantselectedValue.toString()),
                                            value: controller.servantselectedValue,
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
                                                controller.servantselectedValue = value!;
                                                controller.servantstreets.clear();
                                                controller.servantplots.clear();
                                                controller.getStreetByBlock(value);
                                              });
                                            },
                                          ).paddingOnly(left: 12),
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
                                                    hint: controller.servantstreetSelectedValue == null
                                                        ? Text(
                                                            controller.streets.isEmpty ? "Please wait..." : "Streets ",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: ColorConstant.blackColor.withOpacity(0.5),
                                                              fontFamily: AppFonts.lucidaBright,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          )
                                                        : Text(controller.servantstreetSelectedValue.toString()),
                                                    value: controller.servantstreetSelectedValue,
                                                    disabledHint: Text(
                                                      controller.streets.isEmpty ? "Please wait..." : "Streets",
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
                                                        controller.servantstreetSelectedValue = value;
                                                        controller.servantplots.clear();
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
                                                    hint: controller.servantplotstSelectedValue == null
                                                        ? Text(
                                                            controller.plots.isEmpty
                                                                ? "Please wait..."
                                                                : controller.plotPlaceHolder,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: ColorConstant.blackColor.withOpacity(0.5),
                                                              fontFamily: AppFonts.lucidaBright,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          )
                                                        : Text(controller.servantplotstSelectedValue.toString()),
                                                    value: controller.servantplotstSelectedValue,
                                                    disabledHint: Text(
                                                      controller.plots.isEmpty
                                                          ? "Please wait..."
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
                                                        controller.servantplotstSelectedValue = value;
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
                                                fieldText: "Block".tr,
                                                controller: controller.serventblockController,
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
                                                fieldText: "Mohalla/Village".tr,
                                                controller: controller.serventcolonyVillageController,
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
                                              Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                            ),
                                            onPressed: () async {
                                              controller.servantImage = await controller.imagePicker();
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
                                              Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                            ),
                                            onPressed: () async {
                                              controller.servantCnicFront = await controller.imagePicker();
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
                                              Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                            ),
                                            onPressed: () async {
                                              controller.servantCnicBack = await controller.imagePicker();
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(15),
                                        ),
                                        Padding(
                                          padding: getPadding(left: 10, right: 10),
                                          child: MyAnimatedButton(
                                            controller: _value.btnControllerUseLess,
                                            radius: 5.0,
                                            height: getVerticalSize(50),
                                            width: getHorizontalSize(400),
                                            fontSize: 16,
                                            bgColor: ColorConstant.anbtnBlue,
                                            // controller:
                                            //     controller.btnController,
                                            title: "Add Servant".tr,
                                            onTap: () async {
                                              controller.addServant();
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
                                key: controller.addServantFamilyFormKey,
                                child: CustomExpansionTile(
                                  title: MyText(
                                    title: 'Servants Family Details (if residing)',
                                    clr: ColorConstant.black900,
                                    fontSize: 16,
                                  ),
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        if (_value.servantFamilyDataIndex != 0)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 15),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                                child: MyText(
                                                  title: _value.servantFamilyDataIndex.toString(),
                                                  clr: ColorConstant.whiteA700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        CustomTextField(
                                          fieldText: "Full Name".tr,
                                          controller: controller.serventfamfullNameController,
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
                                          fieldText: "Occupation".tr,
                                          controller: controller.serventoccutionController,
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
                                                fieldText: "N.I.C / FORM ‘B’".tr,
                                                controller: controller.serventfamCnicController,
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
                                                fieldText: "Mobile number’".tr,
                                                controller: controller.serventfamMobController,
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
                                        CustomTextField(
                                          fieldText: "Present Address".tr,
                                          controller: controller.serventpresentAddController,
                                          isFinal: false,
                                          keyboardType: TextInputType.emailAddress,
                                          limit: HelperFunction.EMAIL_VALIDATION,
                                          validator: (value) {
                                            return HelperFunction.empthyFieldValidator(value!);
                                          },
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
                                            label: "Attach a clear image of servant".tr,
                                            textColor: ColorConstant.anbtnBlue,
                                            borderColor: ColorConstant.anbtnBlue,
                                            prefix: Icon(
                                              Icons.add_circle_outline,
                                              color: ColorConstant.anbtnBlue,
                                            ),
                                            onPressed: () async {
                                              controller.servantFamilyImage = await controller.imagePicker();
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
                                            controller: _value.btnControllerUseLess,
                                            title: "Add Family Member".tr,
                                            onTap: () async {
                                              await controller.addServantFamily();
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
                              CustomExpansionTile(
                                title: MyText(
                                  title: 'Add Signature',
                                  clr: ColorConstant.black900,
                                  fontSize: 16,
                                ),
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CustomTextField(
                                              fieldText: "SIGNATURE OF OWNER:".tr,
                                              readOnly: true,
                                              controller: controller.ownerSignatureController,
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
                                          controller: _value.btnController,
                                          title: "Submit".tr,
                                          onTap: () async {
                                            _value.submitServantApi(context);
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
