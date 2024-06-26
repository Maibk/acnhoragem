import 'dart:developer';
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

  HomeController homecontroller = Get.put(HomeController());

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
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  TextInputFormatterWithPattern('#####-#######-#'),
                                                ],
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
                                                        : Text(controller.streetSelectedValue.toString()),
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
                                                fieldText: "Road".tr,
                                                controller: controller.roadController,
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
                              GetBuilder(
                                  init: controller,
                                  builder: (context) {
                                    return Form(
                                      key: controller.addServantFormKey,
                                      child: CustomExpansionTile(
                                        title: MyText(
                                          title: 'Servant Information',
                                          clr: ColorConstant.black900,
                                          fontSize: 16,
                                        ),
                                        children: <Widget>[
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: controller.serventfullNameControllers.length == 0
                                                ? 1
                                                : controller.serventfullNameControllers.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  // if (_value.servantDataIndex != 0)
                                                  //   Row(
                                                  //     mainAxisAlignment: MainAxisAlignment.start,
                                                  //     children: [
                                                  //       Container(
                                                  //         margin: EdgeInsets.only(left: 15),
                                                  //         padding: EdgeInsets.all(10),
                                                  //         decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                                  //         child: MyText(
                                                  //           title: _value.servantDataIndex.toString(),
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
                                                              controller.serventfullNameControllers.removeAt(index);
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
                                                      controller: controller.serventfullNameControllers[index],
                                                      isFinal: false,
                                                      keyboardType: TextInputType.emailAddress,
                                                      limit: HelperFunction.EMAIL_VALIDATION,
                                                      validator: (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  CustomTextField(
                                                      fieldText: "Father’s Name".tr,
                                                      controller: controller.serventfathersControllers[index],
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
                                                            controller: controller.serventcnicControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.number,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.digitsOnly,
                                                              TextInputFormatterWithPattern('#####-#######-#'),
                                                            ],
                                                            limit: HelperFunction.EMAIL_VALIDATION,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Mobile number".tr,
                                                            controller: controller.serventmobileControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.phone,
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
                                                            fieldText: "House/Plot".tr,
                                                            controller: controller.serventhouseControllers[index],
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
                                                            controller: controller.serventroadControllers[index],
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
                                                            controller: controller.serventstreetControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.emailAddress,
                                                            limit: HelperFunction.EMAIL_VALIDATION,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Mohalla/Village".tr,
                                                            controller:
                                                                controller.serventcolonyVillageControllers[index],
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
                                                            fieldText: "Post Office/Thana".tr,
                                                            controller: controller.serventpostOfficeControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.emailAddress,
                                                            limit: HelperFunction.EMAIL_VALIDATION,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "City".tr,
                                                            controller: controller.serventCityControllers[index],
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
                                                            fieldText: "Province".tr,
                                                            controller: controller.serventProvinceControllers[index],
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
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.servantImages[index] = File(result.path);
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
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorConstant.whiteA700,
                                                      label: "Attach a clear image of your CNIC front side".tr,
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
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.servantCnicFronts[index] = File(result.path);
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
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorConstant.whiteA700,
                                                      label: "Attach a clear image of your CNIC back side".tr,
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
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.servantCnicBacks[index] = File(result.path);
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
                                                        if (controller.servantImages.isEmpty) {
                                                          Utils.showToast("Please select servant Images", true);
                                                        } else if (controller.servantCnicFronts.isEmpty) {
                                                          Utils.showToast(
                                                              "Please select servant cnic front images", true);
                                                        } else if (controller.servantCnicBacks.isEmpty) {
                                                          Utils.showToast(
                                                              "Please select servant cnic back images", true);
                                                        } else {
                                                          controller.addServant(index);
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
                                height: getVerticalSize(10),
                              ),
                              GetBuilder(
                                  init: controller,
                                  builder: (context) {
                                    return Form(
                                      key: controller.addServantFamilyFormKey,
                                      child: CustomExpansionTile(
                                        title: MyText(
                                          title: 'Servants Family Details (if residing)',
                                          clr: ColorConstant.black900,
                                          fontSize: 16,
                                        ),
                                        children: <Widget>[
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: controller.serventfamfullNameControllers.length == 0
                                                ? 1
                                                : controller.serventfamfullNameControllers.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  // if (_value.servantFamilyDataIndex != 0)
                                                  //   Row(
                                                  //     mainAxisAlignment: MainAxisAlignment.start,
                                                  //     children: [
                                                  //       Container(
                                                  //         margin: EdgeInsets.only(left: 15),
                                                  //         padding: EdgeInsets.all(10),
                                                  //         decoration: BoxDecoration(
                                                  //             color: Colors.green, shape: BoxShape.circle),
                                                  //         child: MyText(
                                                  //           title: _value.servantFamilyDataIndex.toString(),
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
                                                              controller.serventfamfullNameControllers.removeAt(index);
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
                                                      controller: controller.serventfamfullNameControllers[index],
                                                      isFinal: false,
                                                      keyboardType: TextInputType.emailAddress,
                                                      limit: HelperFunction.EMAIL_VALIDATION,
                                                      validator: (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  CustomTextField(
                                                      fieldText: "Occupation".tr,
                                                      controller: controller.serventfamoccutionControllers[index],
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
                                                            fieldText: "N.I.C / FORM ‘B’".tr,
                                                            controller: controller.serventfamCnicControllers[index],
                                                            isFinal: false,
                                                            keyboardType: TextInputType.phone,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.digitsOnly,
                                                              TextInputFormatterWithPattern('#####-#######-#'),
                                                            ],
                                                            limit: HelperFunction.EMAIL_VALIDATION,
                                                            validator: (value) {
                                                              return HelperFunction.empthyFieldValidator(value!);
                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: CustomTextField(
                                                            fieldText: "Mobile number".tr,
                                                            controller: controller.serventfamMobControllers[index],
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
                                                  CustomTextField(
                                                      fieldText: "Present Address".tr,
                                                      controller: controller.serventfampresentAddControllers[index],
                                                      isFinal: false,
                                                      keyboardType: TextInputType.emailAddress,
                                                      limit: HelperFunction.EMAIL_VALIDATION,
                                                      validator: (value) {
                                                        return HelperFunction.empthyFieldValidator(value!);
                                                      }),
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
                                                        final result = await controller.picker
                                                            .pickImage(source: ImageSource.gallery);

                                                        if (result != null) {
                                                          setState(() {
                                                            controller.servantFamilyImages[index] = File(result.path);
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
                                                      controller: _value.btnControllerUseLess,
                                                      title: "Add Family Member".tr,
                                                      onTap: () async {
                                                        if (controller.servantFamilyImages.isEmpty) {
                                                          Utils.showToast("Please select servant family images", true);
                                                        } else {
                                                          await controller.addServantFamily(index);
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
                                              fieldText: "SIGNATURE OF OWNER:".tr,
                                              readOnly: true,

                                              fontStyle: FontStyle.italic,

                                              controller: controller.fullNameController,

                                              // TextEditingController(text: controller.fullNameController.text),
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
                                    ],
                                  )
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
                                  controller: _value.btnController,
                                  title: "Submit".tr,
                                  onTap: () async {
                                    _value.submitServantApi(context);
                                    log(_value.servantData.toString());
                                  },
                                ),
                              ),
                              SizedBox(
                                height: getVerticalSize(20),
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
