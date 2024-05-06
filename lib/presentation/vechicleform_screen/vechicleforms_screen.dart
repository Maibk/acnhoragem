import 'dart:io';

import 'package:anchorageislamabad/core/utils/app_fonts.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/size_utils.dart';
import '../../core/utils/utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/animated_custom_button.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_expensiontile.dart';
import '../../widgets/custom_textfield_new.dart';
import 'controller/vechicleforms_controller.dart';

class VechicleScreen extends StatefulWidget {
  @override
  State<VechicleScreen> createState() => _VechicleScreenState();
}

class _VechicleScreenState extends State<VechicleScreen> {
  VechicleController controller = Get.put(VechicleController());

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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Colors.transparent,
          title: MyText(
            title: "Vehicle Entry",
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
                              CustomExpansionTile(
                                title: MyText(
                                  title: 'STICKER PROFORMA',
                                  clr: ColorConstant.black900,
                                  fontSize: 16,
                                ),
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Form(
                                        key: _value.sticketProformaFormKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                              height: getVerticalSize(10),
                                            ),

                                            Padding(
                                              padding: getPadding(left: 10),
                                              child: MyText(
                                                title: "Select Category:",
                                                fontSize: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: getPadding(left: 10, top: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Icon(
                                                    _value.selectedServiceCategory == 1
                                                        ? Icons.circle
                                                        : Icons.circle_outlined,
                                                    color: ColorConstant.blackColor,
                                                    size: 14,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _value.setServiceCategory(1);
                                                    },
                                                    child: MyText(
                                                      title: " Civilian",
                                                      clr: ColorConstant.antextlightgray,
                                                    ),
                                                  ),
                                                  Icon(
                                                    _value.selectedServiceCategory == 2
                                                        ? Icons.circle
                                                        : Icons.circle_outlined,
                                                    color: ColorConstant.blackColor,
                                                    size: 14,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _value.setServiceCategory(2);
                                                    },
                                                    child: MyText(
                                                      title: " Service Personnel",
                                                      clr: ColorConstant.antextlightgray,
                                                    ),
                                                  ),
                                                  // Icon(
                                                  //   Icons.circle_outlined,
                                                  //   color: ColorConstant.blackColor,
                                                  //   size: 14,
                                                  // ),
                                                  // MyText(
                                                  //   title: " mm/dd/yy",
                                                  //   clr:
                                                  //       ColorConstant.antextlightgray,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(10),
                                            ),
                                            Padding(
                                              padding: getPadding(left: 10, right: 10),
                                              child: Divider(
                                                color: ColorConstant.antextlightgray,
                                              ),
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(5),
                                            ),
                                            // if (_value
                                            //         .selectedServiceCategory ==
                                            //     2)

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: CustomTextField(
                                                    fieldText: "Date".tr,
                                                    controller: controller.dateController,
                                                    isFinal: false,
                                                    onTap: () {
                                                      controller.selectDate(context);
                                                    },
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: CustomTextField(
                                                    fieldText: "Rank/Rate".tr,
                                                    controller: controller.rankController,
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
                                                    fieldText: "Service No".tr,
                                                    controller: controller.servisController,
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
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: CustomTextField(
                                                    fieldText: "CNIC".tr,
                                                    controller: controller.cnicController,
                                                    isFinal: false,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.digitsOnly,
                                                      TextInputFormatterWithPattern('#####-#######-#'),
                                                    ],
                                                    keyboardType: TextInputType.phone,
                                                    limit: HelperFunction.EMAIL_VALIDATION,
                                                    validator: (value) {
                                                      return HelperFunction.empthyFieldValidator(value!);
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextField(
                                                    fieldText: "Office / Department".tr,
                                                    controller: controller.officeController,
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
                                                                "Select Plot",
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
                                                          "Select Plot",
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
                                              height: getVerticalSize(5),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: CustomTextField(
                                                    fieldText: "Cell No.".tr,
                                                    controller: controller.cellNoController,
                                                    isFinal: false,
                                                    keyboardType: TextInputType.phone,
                                                    limit: HelperFunction.EMAIL_VALIDATION,
                                                    validator: (value) {
                                                      return HelperFunction.empthyFieldValidator(value!);
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextField(
                                                    fieldText: "PTCL No.".tr,
                                                    controller: controller.ptclController,
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
                                              height: getVerticalSize(15),
                                            ),
                                            Padding(
                                              padding: getPadding(left: 10),
                                              child: MyText(
                                                title: "Select Residential Status:",
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(15),
                                            ),

                                            Padding(
                                              padding: getPadding(left: 10, top: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Icon(
                                                    _value.selectedResidential == 1
                                                        ? Icons.circle
                                                        : Icons.circle_outlined,
                                                    color: ColorConstant.blackColor,
                                                    size: 14,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _value.setselectedResidential(1);
                                                    },
                                                    child: MyText(
                                                      title: " Civilian",
                                                      clr: ColorConstant.antextlightgray,
                                                    ),
                                                  ),
                                                  Icon(
                                                    _value.selectedResidential == 2
                                                        ? Icons.circle
                                                        : Icons.circle_outlined,
                                                    color: ColorConstant.blackColor,
                                                    size: 14,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _value.setselectedResidential(2);
                                                    },
                                                    child: MyText(
                                                      title: "Tenant",
                                                      clr: ColorConstant.antextlightgray,
                                                    ),
                                                  ),
                                                  Icon(
                                                    _value.selectedResidential == 3
                                                        ? Icons.circle
                                                        : Icons.circle_outlined,
                                                    color: ColorConstant.blackColor,
                                                    size: 14,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _value.setselectedResidential(3);
                                                    },
                                                    child: MyText(
                                                      title: "Visitor / Non-Resident",
                                                      clr: ColorConstant.antextlightgray,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(15),
                                      ),
                                      GetBuilder(
                                          init: controller,
                                          builder: (context) {
                                            return Form(
                                                key: _value.addVehicleFormKey,
                                                child: ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: controller.vehicleNoControllers.length == 0
                                                      ? 1
                                                      : controller.vehicleNoControllers.length,
                                                  itemBuilder: (context, index) {
                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: getPadding(left: 10),
                                                          child: MyText(
                                                            title: "Vehicles Information",
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        // if (_value.vehicleDataIndex != 0)
                                                        //   Row(
                                                        //     mainAxisAlignment: MainAxisAlignment.start,
                                                        //     children: [
                                                        //       Container(
                                                        //         margin: EdgeInsets.only(left: 15),
                                                        //         padding: EdgeInsets.all(10),
                                                        //         decoration: BoxDecoration(
                                                        //             color: Colors.green, shape: BoxShape.circle),
                                                        //         child: MyText(
                                                        //           title: _value.vehicleDataIndex.toString(),
                                                        //           clr: ColorConstant.whiteA700,
                                                        //           fontSize: 16,
                                                        //         ),
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        SizedBox(
                                                          height: getVerticalSize(15),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: CustomTextField(
                                                                  fieldText: "Vehicle No.".tr,
                                                                  controller: controller.vehicleNoControllers[index],
                                                                  isFinal: false,
                                                                  keyboardType: TextInputType.emailAddress,
                                                                  limit: HelperFunction.EMAIL_VALIDATION,
                                                                  validator: (value) {
                                                                    return HelperFunction.empthyFieldValidator(value!);
                                                                  }),
                                                            ),
                                                            Expanded(
                                                              child: CustomTextField(
                                                                  fieldText: "Make".tr,
                                                                  controller: controller.makeControllers[index],
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
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: CustomTextField(
                                                                  fieldText: "Model".tr,
                                                                  controller: controller.modelControllers[index],
                                                                  isFinal: false,
                                                                  keyboardType: TextInputType.emailAddress,
                                                                  limit: HelperFunction.EMAIL_VALIDATION,
                                                                  validator: (value) {
                                                                    return HelperFunction.empthyFieldValidator(value!);
                                                                  }),
                                                            ),
                                                            Expanded(
                                                              child: CustomTextField(
                                                                  fieldText: "Color".tr,
                                                                  controller: controller.colorControllers[index],
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
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: CustomTextField(
                                                                  fieldText: "Engine No".tr,
                                                                  controller: controller.engineNoControllers[index],
                                                                  isFinal: false,
                                                                  keyboardType: TextInputType.emailAddress,
                                                                  limit: HelperFunction.EMAIL_VALIDATION,
                                                                  validator: (value) {
                                                                    return HelperFunction.empthyFieldValidator(value!);
                                                                  }),
                                                            ),
                                                            Expanded(
                                                              child: CustomTextField(
                                                                  fieldText: "Chassis No".tr,
                                                                  controller: controller.chassisControllers[index],
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
                                                        Padding(
                                                          padding: getPadding(left: 10, right: 10),
                                                          child: MyAnimatedButton(
                                                            radius: 5.0,
                                                            height: getVerticalSize(50),
                                                            width: getHorizontalSize(400),
                                                            fontSize: 16,
                                                            bgColor: ColorConstant.anbtnBlue,
                                                            controller: controller.btnControllerUseless,
                                                            title: "Add Vehicle".tr,
                                                            onTap: () async {
                                                              _value.addVehicle(index);
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: getVerticalSize(20),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ));
                                          }),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: getVerticalSize(10),
                              ),
                              GetBuilder(
                                  init: _value,
                                  builder: (context) {
                                    return Form(
                                      key: controller.addUserInfoFormKey,
                                      child: CustomExpansionTile(
                                        title: MyText(
                                          title: 'Users Information',
                                          clr: ColorConstant.black900,
                                          fontSize: 16,
                                        ),
                                        children: <Widget>[
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: controller.userfullNameControllers.length == 0
                                                ? 1
                                                : controller.userfullNameControllers.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  // if (_value.userInfoDataIndex != 0)
                                                  //   Row(
                                                  //     mainAxisAlignment: MainAxisAlignment.start,
                                                  //     children: [
                                                  //       Container(
                                                  //         margin: EdgeInsets.only(left: 15),
                                                  //         padding: EdgeInsets.all(10),
                                                  //         decoration:
                                                  //             BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                                  //         child: MyText(
                                                  //           title: _value.userInfoDataIndex.toString(),
                                                  //           clr: ColorConstant.whiteA700,
                                                  //           fontSize: 16,
                                                  //         ),
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  CustomTextField(
                                                      fieldText: "Full Name".tr,
                                                      controller: controller.userfullNameControllers[index],
                                                      isFinal: false,
                                                      keyboardType: TextInputType.emailAddress,
                                                      limit: HelperFunction.EMAIL_VALIDATION,
                                                      validator: (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "CNIC No.".tr,
                                                            controller: controller.userCnicControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.number,
                                                            limit: HelperFunction.EMAIL_VALIDATION,
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
                                                            controller: controller.userMobileControllers[index],
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
                                                      label: "Attach Driving License Front Side Image".tr,
                                                      textColor: ColorConstant.anbtnBlue,
                                                      borderColor: ColorConstant.anbtnBlue,
                                                      prefix: Icon(
                                                        Icons.add_circle_outline,
                                                        color: ColorConstant.anbtnBlue,
                                                      ),
                                                      onPressed: () async {
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.userDrivingLicenseFrontSideImages
                                                                .add(File(result.path));
                                                          });

                                                          Utils.showToast("Image added", false);
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
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorConstant.whiteA700,
                                                      label: "Attach Driving License Back Side Image".tr,
                                                      textColor: ColorConstant.anbtnBlue,
                                                      borderColor: ColorConstant.anbtnBlue,
                                                      prefix: Icon(
                                                        Icons.add_circle_outline,
                                                        color: ColorConstant.anbtnBlue,
                                                      ),
                                                      onPressed: () async {
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.userDrivingLicenseBackSideImages
                                                                .add(File(result.path));
                                                          });

                                                          Utils.showToast("Image added", false);
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
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.userCnicFrontSideImages.add(File(result.path));
                                                          });

                                                          Utils.showToast("Image added", false);
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
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.userCnicBacktSideImages.add(File(result.path));
                                                          });

                                                          Utils.showToast("Image added", false);
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
                                                      controller: controller.btnControllerUseless,
                                                      title: "Add User".tr,
                                                      onTap: () async {
                                                        controller.addUserInfo(index);
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
                                height: getVerticalSize(10),
                              ),
                              CustomExpansionTile(
                                title: MyText(
                                  title: 'View Undertaking ',
                                  clr: ColorConstant.black900,
                                  fontSize: 16,
                                ),
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: getPadding(left: 10),
                                        child: MyText(
                                          title: "Requirements:",
                                          clr: ColorConstant.antextlightgray,
                                          fontSize: 15,
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
                                          label: "Attach Driving License Front Side Image".tr,
                                          textColor: ColorConstant.anbtnBlue,
                                          borderColor: ColorConstant.anbtnBlue,
                                          prefix: Icon(
                                            controller.underTakingLicenseFrontSideImage != null
                                                ? Icons.check_circle_sharp
                                                : Icons.add_circle_outline,
                                            color: ColorConstant.anbtnBlue,
                                          ),
                                          onPressed: () async {
                                            controller.underTakingLicenseFrontSideImage =
                                                await controller.imagePicker();
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
                                          label: "Attach Driving License Back Side Image".tr,
                                          textColor: ColorConstant.anbtnBlue,
                                          borderColor: ColorConstant.anbtnBlue,
                                          prefix: Icon(
                                            controller.underTakingLicenseBackSideImage != null
                                                ? Icons.check_circle_sharp
                                                : Icons.add_circle_outline,
                                            color: ColorConstant.anbtnBlue,
                                          ),
                                          onPressed: () async {
                                            controller.underTakingLicenseBackSideImage = await controller.imagePicker();
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
                                            controller.underTakingCnicFrontSideImage != null
                                                ? Icons.check_circle_sharp
                                                : Icons.add_circle_outline,
                                            color: ColorConstant.anbtnBlue,
                                          ),
                                          onPressed: () async {
                                            controller.underTakingCnicFrontSideImage = await controller.imagePicker();
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
                                            controller.underTakingCnicBackSideImage != null
                                                ? Icons.check_circle_sharp
                                                : Icons.add_circle_outline,
                                            color: ColorConstant.anbtnBlue,
                                          ),
                                          onPressed: () async {
                                            controller.underTakingCnicBackSideImage = await controller.imagePicker();
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
                                          label: "Attach Vehicle Registration Image".tr,
                                          textColor: ColorConstant.anbtnBlue,
                                          borderColor: ColorConstant.anbtnBlue,
                                          prefix: Icon(
                                            controller.underTakingVehicalRegistrationImage != null
                                                ? Icons.check_circle_sharp
                                                : Icons.add_circle_outline,
                                            color: ColorConstant.anbtnBlue,
                                          ),
                                          onPressed: () async {
                                            controller.underTakingVehicalRegistrationImage =
                                                await controller.imagePicker();
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
                                          label: "Attach Owner Image".tr,
                                          textColor: ColorConstant.anbtnBlue,
                                          borderColor: ColorConstant.anbtnBlue,
                                          prefix: Icon(
                                            controller.underTakingOwnerImage != null
                                                ? Icons.check_circle_sharp
                                                : Icons.add_circle_outline,
                                            color: ColorConstant.anbtnBlue,
                                          ),
                                          onPressed: () async {
                                            controller.underTakingOwnerImage = await controller.imagePicker();
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
                                          label: "Attach Allotment Letter Image".tr,
                                          textColor: ColorConstant.anbtnBlue,
                                          borderColor: ColorConstant.anbtnBlue,
                                          prefix: Icon(
                                            controller.underTakingAllotmentLetterImage != null
                                                ? Icons.check_circle_sharp
                                                : Icons.add_circle_outline,
                                            color: ColorConstant.anbtnBlue,
                                          ),
                                          onPressed: () async {
                                            controller.underTakingAllotmentLetterImage = await controller.imagePicker();
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
                                          label: "Attach Maintenance Bill Image".tr,
                                          textColor: ColorConstant.anbtnBlue,
                                          borderColor: ColorConstant.anbtnBlue,
                                          prefix: Icon(
                                            controller.underTakingMaintenanceBillImage != null
                                                ? Icons.check_circle_sharp
                                                : Icons.add_circle_outline,
                                            color: ColorConstant.anbtnBlue,
                                          ),
                                          onPressed: () async {
                                            controller.underTakingMaintenanceBillImage = await controller.imagePicker();
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
                                          label: "Attach Old Sticker Image".tr,
                                          textColor: ColorConstant.anbtnBlue,
                                          borderColor: ColorConstant.anbtnBlue,
                                          prefix: Icon(
                                            controller.underTakingOldStickerImage != null
                                                ? Icons.check_circle_sharp
                                                : Icons.add_circle_outline,
                                            color: ColorConstant.anbtnBlue,
                                          ),
                                          onPressed: () async {
                                            controller.underTakingOldStickerImage = await controller.imagePicker();
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
                              SizedBox(
                                height: getVerticalSize(30),
                              ),
                              MyAnimatedButton(
                                radius: 5.0,
                                height: getVerticalSize(50),
                                width: getHorizontalSize(400),
                                fontSize: 16,
                                bgColor: ColorConstant.anbtnBlue,
                                controller: controller.btnController,
                                title: "Submit".tr,
                                onTap: () async {
                                  controller.SubmitVehicle(context);
                                },
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
