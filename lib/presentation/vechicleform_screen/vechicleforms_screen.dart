import 'dart:io';

import 'package:anchorageislamabad/core/utils/app_fonts.dart';
import 'package:anchorageislamabad/core/utils/constants.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/presentation/vechicleform_screen/models/Vehicle_form_model.dart';
import 'package:anchorageislamabad/widgets/custom_image_view.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/animated_custom_button.dart';
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

  final args = Get.arguments;
  bool isEditable = false;

  @override
  initState() {
    if (args['status'] == Constants.formStatusRejected || args['status'] == "") {
      isEditable = true;
    }
    Future.delayed(Duration(), () {
      args['status'] != "" ? controller.getEntryFormsDetails(args['id']) : null;
      args['status'] != "" ? null : controller.addUserControllers();
      args['status'] != "" ? null : controller.addVehicleControllers();
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
                                          title: "Rejection Reason : " + (controller.vehicleFormDataModel.data?.rejection_reason ?? ""),
                                          fontSize: 20,
                                          clr: ColorConstant.apppWhite,
                                        )),
                                  ),
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
                                                enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                fieldText: "Full Name".tr,
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
                                                enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                fieldText: "Father’s Name".tr,
                                                controller: controller.fathersController,
                                                isFinal: false,
                                                keyboardType: TextInputType.emailAddress,
                                                limit: HelperFunction.EMAIL_VALIDATION,
                                                validator: (value) {
                                                  return HelperFunction.validateAlphabetsOnly(value!);
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
                                                      _value.selectedServiceCategory == 1 ? Icons.circle : Icons.circle_outlined,
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
                                                      _value.selectedServiceCategory == 2 ? Icons.circle : Icons.circle_outlined,
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
                                                      enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                      enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                      enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                        return HelperFunction.cnicValidator(value!);
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: CustomTextField(
                                                      enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                  onChanged: args['status'] == Constants.formStatusPending
                                                      ? null
                                                      : (int? value) {
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

                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //   children: [
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

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: CustomTextField(
                                                      enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                      fieldText: "Cell No.".tr,
                                                      controller: controller.cellNoController,
                                                      isFinal: false,
                                                      keyboardType: TextInputType.phone,
                                                      limit: HelperFunction.EMAIL_VALIDATION,
                                                      validator: (value) {
                                                        return HelperFunction.validatePakistaniPhoneNumber(value!);
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: CustomTextField(
                                                      enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                      fieldText: "PTCL No.".tr,
                                                      controller: controller.ptclController,
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
                                              AbsorbPointer(
                                                absorbing: !isEditable,
                                                child: Padding(
                                                  padding: getPadding(left: 10, top: 10, right: 10),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Icon(
                                                            _value.selectedResidential == 1 ? Icons.circle : Icons.circle_outlined,
                                                            color: ColorConstant.blackColor,
                                                            size: 14,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller.updateNocStatus("");
                                                              _value.setselectedResidential(1);
                                                            },
                                                            child: MyText(
                                                              title: " Civilian",
                                                              clr: ColorConstant.antextlightgray,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 30,
                                                          ),
                                                          Icon(
                                                            _value.selectedResidential == 2 ? Icons.circle : Icons.circle_outlined,
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
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            _value.selectedResidential == 3 ? Icons.circle : Icons.circle_outlined,
                                                            color: ColorConstant.blackColor,
                                                            size: 14,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller.updateNocStatus("");

                                                              _value.setselectedResidential(3);
                                                            },
                                                            child: MyText(
                                                              title: " Visitor / Non-Resident",
                                                              clr: ColorConstant.antextlightgray,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        _value.selectedResidential == 2
                                            ? GetBuilder(
                                                init: controller,
                                                builder: (context) {
                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      AbsorbPointer(
                                                        absorbing: !isEditable,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: getPadding(left: 10),
                                                              child: MyText(
                                                                title: "NOC submitted",
                                                                clr: ColorConstant.antextlightgray,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: getHorizontalSize(20),
                                                            ),
                                                            GetBuilder(
                                                              init: controller,
                                                              builder: (_) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    controller.updateNocStatus("Yes");
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      controller.nocSubmitted == "Yes"
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
                                                                      MyText(
                                                                        title: "Yes",
                                                                        clr: ColorConstant.antextlightgray,
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
                                                              builder: (_) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    controller.updateNocStatus("No");
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      controller.nocSubmitted == "No"
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
                                                                      MyText(
                                                                        title: "No",
                                                                        clr: ColorConstant.antextlightgray,
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
                                                        height: getVerticalSize(20),
                                                      ),
                                                    ],
                                                  );
                                                }).paddingOnly(top: 15)
                                            : SizedBox.shrink(),
                                        SizedBox(
                                          height: getVerticalSize(5),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: getVerticalSize(10),
                                ),
                                CustomExpansionTile(
                                    title: MyText(
                                      title: 'Vehicle Information',
                                      clr: ColorConstant.black900,
                                      fontSize: 16,
                                    ),
                                    children: [
                                      GetBuilder(
                                          init: controller,
                                          builder: (context) {
                                            return Form(
                                                key: _value.addVehicleFormKey,
                                                child: ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  itemCount: args['status'] != ""
                                                      ? controller.vehicleFormDataModel.data?.vehicleDetail?.length ?? 0
                                                      : controller.vehicleNoControllers.length == 0
                                                          ? 1
                                                          : controller.vehicleNoControllers.length,
                                                  itemBuilder: (context, index) {
                                                    VehicleDetail? detail;
                                                    if ((controller.vehicleFormDataModel.data?.vehicleDetail?.length ?? 0) > 0) {
                                                      detail = controller.vehicleFormDataModel.data?.vehicleDetail?[index];
                                                    }

                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        MyText(
                                                          title: 'Vehicle ${index + 1}',
                                                          clr: ColorConstant.black900,
                                                          fontSize: 16,
                                                        ).paddingOnly(left: 10, bottom: 10),
                                                        if (index != 0)
                                                          if (args['status'] != Constants.formStatusPending)
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      if (args['status'] == Constants.formStatusRejected) {
                                                                        controller.vehicleFormDataModel.data?.vehicleDetail?.removeAt(index);
                                                                      } else {
                                                                        controller.vehicleNoControllers.removeAt(index);
                                                                      }
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
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: CustomTextField(
                                                                  enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                                  fieldText: "Vehicle No.".tr,
                                                                  controller: isEditable
                                                                      ? detail?.vehicleNoController
                                                                      : controller.vehicleNoControllers[index],
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
                                                                  controller:
                                                                      isEditable ? detail?.vehicleMakeController : controller.makeControllers[index],
                                                                  isFinal: false,
                                                                  keyboardType: TextInputType.emailAddress,
                                                                  enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                                  enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                                  controller: isEditable
                                                                      ? detail?.vehicleModelController
                                                                      : controller.modelControllers[index],
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
                                                                  enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                                  controller: isEditable
                                                                      ? detail?.vehicleColorController
                                                                      : controller.colorControllers[index],
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
                                                                  enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                                  controller: isEditable
                                                                      ? detail?.vehicleEngineController
                                                                      : controller.engineNoControllers[index],
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
                                                                  enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                                  controller: isEditable
                                                                      ? detail?.vehicleChassisController
                                                                      : controller.chassisControllers[index],
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
                                                        // if (args['status'] == "")
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
                                                              if (isEditable) {
                                                                controller.vehicleFormDataModel.data?.vehicleDetail?.add(VehicleDetail());
                                                              }
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
                                    ]),
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
                                              itemCount:
                                                  controller.userfullNameControllers.length == 0 ? 1 : controller.userfullNameControllers.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    if (index != 0)
                                                      if (args['status'] != Constants.formStatusPending)
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  controller.userfullNameControllers.removeAt(index);
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
                                                        controller: controller.userfullNameControllers[index],
                                                        isFinal: false,
                                                        keyboardType: TextInputType.emailAddress,
                                                        limit: HelperFunction.EMAIL_VALIDATION,
                                                        enabled: args['status'] == Constants.formStatusPending ? false : true,
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
                                                              fieldText: "CNIC No.".tr,
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              controller: controller.userCnicControllers[index],
                                                              isFinal: false,
                                                              keyboardType: TextInputType.number,
                                                              limit: HelperFunction.EMAIL_VALIDATION,
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
                                                              enabled: args['status'] == Constants.formStatusPending ? false : true,
                                                              controller: controller.userMobileControllers[index],
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
                                                    SizedBox(
                                                      height: getVerticalSize(15),
                                                    ),
                                                    if (args['status'] != "")
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          MyText(title: "User license front").paddingOnly(left: 10),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          GestureDetector(
                                                            child: Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  url: controller
                                                                          .vehicleFormDataModel.data?.vehicleUserDetail?[index].userLicenseFront ??
                                                                      "",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                        ],
                                                      ),
                                                    if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                          prefix: controller.userDrivingLicenseFrontSideImages[index].path == ""
                                                              ? Icon(
                                                                  Icons.add_circle_outline,
                                                                  color: ColorConstant.anbtnBlue,
                                                                )
                                                              : Icon(
                                                                  Icons.check_circle_sharp,
                                                                  color: ColorConstant.anbtnBlue,
                                                                ),
                                                          onPressed: () async {
                                                            final result = await controller.picker.pickImage(source: ImageSource.gallery);

                                                            if (result != null) {
                                                              setState(() {
                                                                controller.userDrivingLicenseFrontSideImages[index] = File(result.path);
                                                              });
                                                            }
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
                                                          MyText(title: "User license back").paddingOnly(left: 10),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          GestureDetector(
                                                            child: Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  url: controller
                                                                          .vehicleFormDataModel.data?.vehicleUserDetail?[index].userLicenseBack ??
                                                                      "",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                        ],
                                                      ),
                                                    if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                          prefix: controller.userDrivingLicenseBackSideImages[index].path == ""
                                                              ? Icon(
                                                                  Icons.add_circle_outline,
                                                                  color: ColorConstant.anbtnBlue,
                                                                )
                                                              : Icon(
                                                                  Icons.check_circle_sharp,
                                                                  color: ColorConstant.anbtnBlue,
                                                                ),
                                                          onPressed: () async {
                                                            final result = await controller.picker.pickImage(source: ImageSource.gallery);

                                                            if (result != null) {
                                                              setState(() {
                                                                controller.userDrivingLicenseBackSideImages[index] = File(result.path);
                                                                ;
                                                              });
                                                            }
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
                                                          MyText(title: "User CNIC front").paddingOnly(left: 10),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          GestureDetector(
                                                            child: Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  url:
                                                                      controller.vehicleFormDataModel.data?.vehicleUserDetail?[index].userCnicFront ??
                                                                          "",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                        ],
                                                      ),
                                                    if (args['status'] == Constants.formStatusRejected || args['status'] == "")
                                                      Padding(
                                                        padding: getPadding(left: 10, right: 10),
                                                        child: CustomButton(
                                                          width: getHorizontalSize(350),
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                          color: ColorConstant.whiteA700,
                                                          label: "Attach image of your CNIC front side".tr,
                                                          textColor: ColorConstant.anbtnBlue,
                                                          borderColor: ColorConstant.anbtnBlue,
                                                          prefix: controller.userCnicFrontSideImages[index].path == ""
                                                              ? Icon(
                                                                  Icons.add_circle_outline,
                                                                  color: ColorConstant.anbtnBlue,
                                                                )
                                                              : Icon(
                                                                  Icons.check_circle_sharp,
                                                                  color: ColorConstant.anbtnBlue,
                                                                ),
                                                          onPressed: () async {
                                                            final result = await controller.picker.pickImage(source: ImageSource.gallery);

                                                            if (result != null) {
                                                              setState(() {
                                                                controller.userCnicFrontSideImages[index] = File(result.path);
                                                              });
                                                            }
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
                                                          MyText(title: "User CNIC back").paddingOnly(left: 10),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          GestureDetector(
                                                            child: Padding(
                                                              padding: getPadding(left: 10, right: 10),
                                                              child: Container(
                                                                width: getHorizontalSize(350),
                                                                color: ColorConstant.whiteA700,
                                                                child: CustomImageView(
                                                                  url: controller.vehicleFormDataModel.data?.vehicleUserDetail?[index].userCnicBack ??
                                                                      "",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                        ],
                                                      ),
                                                    if (args['status'] == Constants.formStatusRejected || args['status'] == "")
                                                      Padding(
                                                        padding: getPadding(left: 10, right: 10),
                                                        child: CustomButton(
                                                          width: getHorizontalSize(350),
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                          color: ColorConstant.whiteA700,
                                                          label: "Attach image of your CNIC back side".tr,
                                                          textColor: ColorConstant.anbtnBlue,
                                                          borderColor: ColorConstant.anbtnBlue,
                                                          prefix: controller.userCnicBacktSideImages[index].path == ""
                                                              ? Icon(
                                                                  Icons.add_circle_outline,
                                                                  color: ColorConstant.anbtnBlue,
                                                                )
                                                              : Icon(
                                                                  Icons.check_circle_sharp,
                                                                  color: ColorConstant.anbtnBlue,
                                                                ),
                                                          onPressed: () async {
                                                            final result = await controller.picker.pickImage(source: ImageSource.gallery);

                                                            if (result != null) {
                                                              setState(() {
                                                                controller.userCnicBacktSideImages[index] = File(result.path);
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
                                    title: 'Requirements :',
                                    clr: ColorConstant.black900,
                                    fontSize: 16,
                                  ),
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (_) => Center(
                                                child: AlertDialog(
                                                  insetPadding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  backgroundColor: Colors.transparent,
                                                  shadowColor: Colors.transparent,
                                                  surfaceTintColor: Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(25),
                                                  ),
                                                  actions: [
                                                    Container(
                                                        padding: EdgeInsets.all(15),
                                                        // height: MediaQuery.of(context).size.height,
                                                        // width: MediaQuery.of(context).size.width,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.white),
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: Color(0xffFFFFFF)),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Undertaking",
                                                                  textAlign: TextAlign.left,
                                                                  style: TextStyle(fontSize: 18.h, color: ColorConstant.blackColor),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.back();
                                                                  },
                                                                  child: Icon(
                                                                    Icons.close_sharp,
                                                                    color: ColorConstant.gray600,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Divider(
                                                              height: 30,
                                                              color: ColorConstant.appTextGray.withOpacity(.7),
                                                            ),
                                                            Text(
                                                              """I hereby undertake to ensure that no unauthorized person or material will be transported in/out of Naval Anchorage in this vehicle; I will follow the rules/regulations and accept traffic penalties in Naval Anchorage. It is also certified that my vehicles will not be used in any illegitimate activity. I will be responsible for safe custody of the stickers and will be liable to return the stickers upon sale of vehicle/expiry date.
                                                                                """,
                                                              textAlign: TextAlign.left,
                                                              style: TextStyle(fontSize: 12.h, color: ColorConstant.greyColor),
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                text: 'Name : \n',
                                                                style: TextStyle(
                                                                  fontSize: 11.h,
                                                                  color: ColorConstant.greyColor,
                                                                  fontWeight: FontWeight.bold,
                                                                  decoration: TextDecoration.none,
                                                                ),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                      text: "1. ",
                                                                      style: TextStyle(
                                                                          fontSize: 11.h,
                                                                          fontStyle: FontStyle.italic,
                                                                          color: ColorConstant.greyColor,
                                                                          decoration: TextDecoration.none,
                                                                          fontWeight: FontWeight.bold)),
                                                                  TextSpan(
                                                                      text: 'Stickers will be issued to original owner only.\n',
                                                                      style: TextStyle(
                                                                          fontSize: 11.h,
                                                                          color: ColorConstant.greyColor,
                                                                          decoration: TextDecoration.none,
                                                                          fontWeight: FontWeight.normal)),
                                                                  TextSpan(
                                                                      text: "2. ",
                                                                      style: TextStyle(
                                                                          fontSize: 11.h,
                                                                          color: ColorConstant.greyColor,
                                                                          decoration: TextDecoration.none,
                                                                          fontWeight: FontWeight.bold)),
                                                                  TextSpan(
                                                                      text: 'Vehicles will be driven by applicant and authorized drivers only.',
                                                                      style: TextStyle(
                                                                          fontSize: 11.h,
                                                                          color: ColorConstant.greyColor,
                                                                          decoration: TextDecoration.none,
                                                                          fontWeight: FontWeight.normal)),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: getVerticalSize(5),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                RichText(
                                                                  text: TextSpan(
                                                                    text: 'Name : \n',
                                                                    style: TextStyle(
                                                                      fontSize: 11.h,
                                                                      color: ColorConstant.greyColor,
                                                                      decoration: TextDecoration.none,
                                                                    ),
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: controller.fullNameController.text,
                                                                          style: TextStyle(
                                                                              fontSize: 13.h,
                                                                              fontStyle: FontStyle.italic,
                                                                              color: ColorConstant.greyColor,
                                                                              decoration: TextDecoration.none,
                                                                              fontWeight: FontWeight.bold)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: getVerticalSize(5),
                                                                ),
                                                                RichText(
                                                                  text: TextSpan(
                                                                    text: 'Signature of owner : \n',
                                                                    style: TextStyle(
                                                                      fontSize: 11.h,
                                                                      color: ColorConstant.greyColor,
                                                                      decoration: TextDecoration.none,
                                                                    ),
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: controller.fullNameController.text,
                                                                          style: TextStyle(
                                                                              fontSize: 11.h,
                                                                              color: ColorConstant.greyColor,
                                                                              fontStyle: FontStyle.italic,
                                                                              decoration: TextDecoration.none,
                                                                              fontWeight: FontWeight.bold)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: getVerticalSize(5),
                                                                ),
                                                                RichText(
                                                                  text: TextSpan(
                                                                    text: 'CNIC : \n',
                                                                    style: TextStyle(
                                                                      fontSize: 11.h,
                                                                      color: ColorConstant.greyColor,
                                                                      decoration: TextDecoration.none,
                                                                    ),
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: controller.cnicController.text,
                                                                          style: TextStyle(
                                                                              fontSize: 11.h,
                                                                              color: ColorConstant.greyColor,
                                                                              decoration: TextDecoration.none,
                                                                              fontStyle: FontStyle.italic,
                                                                              fontWeight: FontWeight.bold)),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.back();
                                                                  },
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(7),
                                                                      color: ColorConstant.gray600,
                                                                    ),
                                                                    child: Text(
                                                                      "Close",
                                                                      style: TextStyle(fontSize: 16.h, color: Colors.white),
                                                                    ).paddingSymmetric(horizontal: 15, vertical: 10),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: getPadding(left: 10),
                                            child: MyText(
                                              title: "View Undertaking:",
                                              under: true,
                                              clr: ColorConstant.antextlightgray,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(15),
                                        ),
                                        if (args['status'] != "")
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyText(title: "Driving license front").paddingOnly(left: 10),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              GestureDetector(
                                                child: Padding(
                                                  padding: getPadding(left: 10, right: 10),
                                                  child: Container(
                                                    width: getHorizontalSize(350),
                                                    color: ColorConstant.whiteA700,
                                                    child: CustomImageView(
                                                      url: controller.vehicleFormDataModel.data?.drivingLicenseFront ?? "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                controller.underTakingLicenseFrontSideImage = await controller.imagePicker();
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
                                              MyText(title: "Driving license back").paddingOnly(left: 10),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              GestureDetector(
                                                child: Padding(
                                                  padding: getPadding(left: 10, right: 10),
                                                  child: Container(
                                                    width: getHorizontalSize(350),
                                                    color: ColorConstant.whiteA700,
                                                    child: CustomImageView(
                                                      url: controller.vehicleFormDataModel.data?.drivingLicenseBack ?? "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                        if (args['status'] != "")
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyText(title: "CNIC image front").paddingOnly(left: 10),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              GestureDetector(
                                                child: Padding(
                                                  padding: getPadding(left: 10, right: 10),
                                                  child: Container(
                                                    width: getHorizontalSize(350),
                                                    color: ColorConstant.whiteA700,
                                                    child: CustomImageView(
                                                      url: controller.vehicleFormDataModel.data?.cnicImageFront ?? "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        if (args['status'] == Constants.formStatusRejected || args['status'] == "")
                                          Padding(
                                            padding: getPadding(left: 10, right: 10),
                                            child: CustomButton(
                                              width: getHorizontalSize(350),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.whiteA700,
                                              label: "Attach image of your CNIC front side".tr,
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
                                        if (args['status'] != "")
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyText(title: "CNIC image back").paddingOnly(left: 10),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              GestureDetector(
                                                child: Padding(
                                                  padding: getPadding(left: 10, right: 10),
                                                  child: Container(
                                                    width: getHorizontalSize(350),
                                                    color: ColorConstant.whiteA700,
                                                    child: CustomImageView(
                                                      url: controller.vehicleFormDataModel.data?.cnicImageBack ?? "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        if (args['status'] == Constants.formStatusRejected || args['status'] == "")
                                          Padding(
                                            padding: getPadding(left: 10, right: 10),
                                            child: CustomButton(
                                              width: getHorizontalSize(350),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.whiteA700,
                                              label: "Attach image of your CNIC back side".tr,
                                              textColor: ColorConstant.anbtnBlue,
                                              borderColor: ColorConstant.anbtnBlue,
                                              prefix: Icon(
                                                controller.underTakingCnicBackSideImage != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
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
                                        if (args['status'] != "")
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyText(title: "Registration image").paddingOnly(left: 10),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              GestureDetector(
                                                child: Padding(
                                                  padding: getPadding(left: 10, right: 10),
                                                  child: Container(
                                                    width: getHorizontalSize(350),
                                                    color: ColorConstant.whiteA700,
                                                    child: CustomImageView(
                                                      url: controller.vehicleFormDataModel.data?.registrationImage ?? "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                controller.underTakingVehicalRegistrationImage = await controller.imagePicker();
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
                                              MyText(title: "Owner Image").paddingOnly(left: 10),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              GestureDetector(
                                                child: Padding(
                                                  padding: getPadding(left: 10, right: 10),
                                                  child: Container(
                                                    width: getHorizontalSize(350),
                                                    color: ColorConstant.whiteA700,
                                                    child: CustomImageView(
                                                      url: controller.vehicleFormDataModel.data?.ownerImage ?? "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                controller.underTakingOwnerImage != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
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
                                        if (args['status'] != "")
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyText(title: "Allotment Letter").paddingOnly(left: 10),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              GestureDetector(
                                                child: Padding(
                                                  padding: getPadding(left: 10, right: 10),
                                                  child: Container(
                                                    width: getHorizontalSize(350),
                                                    color: ColorConstant.whiteA700,
                                                    child: CustomImageView(
                                                      url: controller.vehicleFormDataModel.data?.allotmentLetterImage ?? "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        if (args['status'] == Constants.formStatusRejected || args['status'] == "")
                                          Padding(
                                            padding: getPadding(left: 10, right: 10),
                                            child: CustomButton(
                                              width: getHorizontalSize(350),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.whiteA700,
                                              label: "Attach allotment Letter Image".tr,
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
                                        if (args['status'] != "")
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyText(title: "Maintenance Bill").paddingOnly(left: 10),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              GestureDetector(
                                                child: Padding(
                                                  padding: getPadding(left: 10, right: 10),
                                                  child: Container(
                                                    width: getHorizontalSize(350),
                                                    color: ColorConstant.whiteA700,
                                                    child: CustomImageView(
                                                      url: controller.vehicleFormDataModel.data?.maintenanceBillImage ?? "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                        if (args['status'] != "")
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyText(title: "Old sticker").paddingOnly(left: 10),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              GestureDetector(
                                                child: Padding(
                                                  padding: getPadding(left: 10, right: 10),
                                                  child: Container(
                                                    width: getHorizontalSize(350),
                                                    color: ColorConstant.whiteA700,
                                                    child: CustomImageView(
                                                      url: controller.vehicleFormDataModel.data?.oldStickerImage ?? "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        if (args['status'] == Constants.formStatusRejected || args['status'] == "")
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
                                                controller.underTakingOldStickerImage != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
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
                                if (args['status'] == Constants.formStatusRejected || args['status'] == "")
                                  MyAnimatedButton(
                                    radius: 5.0,
                                    height: getVerticalSize(50),
                                    width: getHorizontalSize(400),
                                    fontSize: 16,
                                    bgColor: ColorConstant.anbtnBlue,
                                    controller:
                                        (args['status'] == Constants.formStatusRejected) ? controller.editbtnController : controller.btnController,
                                    title: "Submit".tr,
                                    onTap: () async {
                                      (args['status'] == Constants.formStatusRejected)
                                          ? controller.editSubmitVehicle(context, args['id'])
                                          : controller.SubmitVehicle(context);
                                    },
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
