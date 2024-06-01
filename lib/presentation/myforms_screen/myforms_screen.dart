import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_expensiontile.dart';
import 'controller/myforms_controller.dart';

class MyFormsScreen extends StatelessWidget {
  final MyFormsController controller = Get.put(MyFormsController());
  // const DiscoverScreen({Key? key}) : super(key: key);

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
            title: "My Forms",
            clr: ColorConstant.whiteA700,
            fontSize: 20,
            customWeight: FontWeight.w500,
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.homePage);
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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: getPadding(all: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        //height: getVerticalSize(200),
                        color: ColorConstant.apppWhite,
                        padding: getPadding(left: 30, right: 30, top: 20, bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.entryFormsPage);
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.profileIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Entry Form",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.serventFormsPage);
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myFormsIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Servant Form",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.vechicleFormsPage);
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myFormsIcon1,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Vehicle Forms",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
            //           SizedBox(
            //             height: getVerticalSize(10),
            //           ),
            //           CustomExpansionTile(
            //             expand: false,               iconColor: Colors.transparent,
            //             leading: MyText(
            //               title: "Owner",
            //               clr: ColorConstant.black900,
            //               fontSize: 18,
            //             ),
            //             title: MyText(
            //               title: "",
            //               clr: ColorConstant.antextlightgray,
            //               fontSize: 10,
            //             ),
            //             // subtitle: Align(
            //             //   alignment: Alignment.topRight,
            //             //   child: CommonImageView(
            //             //     imagePath: ImageConstant.viewIcon,
            //             //   ),
            //             // ),
            //             children: <Widget>[
            //               Align(
            //                 alignment: Alignment.topLeft,
            //                 child: Padding(
            //                   padding: getPadding(left: 20, right: 5, bottom: 10),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       MyText(
            //                         title: "Full Name",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "David Hamza",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),

            //                       MyText(
            //                         title: "Father’s Name",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "Hamza David Warner",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),

            //                       // Wrap the Row widget in a SizedBox or Container with a specific width
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "NIC Number",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "xxxxx-xxxxxxx-x",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               // Divider(color: ColorConstant.antextGrayDark,height: 20,),
            //                             ],
            //                           ),
            //                           // SizedBox(width: 2,),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Mobile number",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "0000-0000000",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                       MyText(
            //                         title: "House/Plot No.",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "House No. 156, Street Block Residential Plot",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Road",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "9",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                           // SizedBox(width: 2,),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Streetr",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "21",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                       Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Row(
            //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               Expanded(
            //                                 child: Column(
            //                                   crossAxisAlignment: CrossAxisAlignment.start,
            //                                   children: [
            //                                     MyText(
            //                                       title: "Block",
            //                                       clr: ColorConstant.black900,
            //                                       fontSize: 14,
            //                                     ),
            //                                     SizedBox(height: getVerticalSize(5)),
            //                                     MyText(
            //                                       title: "A",
            //                                       clr: ColorConstant.antextlightgray,
            //                                       fontSize: 14,
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                               SizedBox(
            //                                 width: getHorizontalSize(2),
            //                               ),
            //                               Expanded(
            //                                 child: Column(
            //                                   crossAxisAlignment: CrossAxisAlignment.start,
            //                                   children: [
            //                                     MyText(
            //                                       title: "Colony/Residential Area Name",
            //                                       clr: ColorConstant.black900,
            //                                       fontSize: 14,
            //                                     ),
            //                                     SizedBox(height: getVerticalSize(5)),
            //                                     MyText(
            //                                       title: "Area Name",
            //                                       clr: ColorConstant.antextlightgray,
            //                                       fontSize: 14,
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           // SizedBox(height: getVerticalSize(8)),
            //                           // Container(
            //                           //   color: ColorConstant.antextlightgray,
            //                           //   height: 1,
            //                           // ),
            //                           // SizedBox(height: getVerticalSize(8)),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               )
            //             ],
            //           ),
            //           SizedBox(
            //             height: getVerticalSize(10),
            //           ),
            //           CustomExpansionTile(
            //             expand: false,               iconColor: Colors.transparent,
            //             leading: MyText(
            //               title: "Spouse",
            //               clr: ColorConstant.black900,
            //               fontSize: 18,
            //             ),
            //             title: MyText(
            // // title: 'Monday Mon-04-2024 04:52 PM',
            //               title: '',
            //               clr: ColorConstant.antextlightgray,
            //               fontSize: 10,
            //             ),
            //             // subtitle: Align(
            //             //   alignment: Alignment.topRight,
            //             //   child: CommonImageView(
            //             //     imagePath: ImageConstant.viewIcon,
            //             //   ),
            //             // ),
            //             children: <Widget>[
            //               Align(
            //                 alignment: Alignment.topLeft,
            //                 child: Padding(
            //                   padding: getPadding(left: 20, right: 5, bottom: 10),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       MyText(
            //                         title: "Full Name",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "David Hamza",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),

            //                       MyText(
            //                         title: "Father’s Name",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "Hamza David Warner",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),

            //                       // Wrap the Row widget in a SizedBox or Container with a specific width
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "NIC Number",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "xxxxx-xxxxxxx-x",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               // Divider(color: ColorConstant.antextGrayDark,height: 20,),
            //                             ],
            //                           ),
            //                           // SizedBox(width: 2,),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Mobile number",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "0000-0000000",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                       MyText(
            //                         title: "House/Plot No.",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "House No. 156, Street Block Residential Plot",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Road",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "9",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                           // SizedBox(width: 2,),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Streetr",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "21",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                       Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Row(
            //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               Expanded(
            //                                 child: Column(
            //                                   crossAxisAlignment: CrossAxisAlignment.start,
            //                                   children: [
            //                                     MyText(
            //                                       title: "Block",
            //                                       clr: ColorConstant.black900,
            //                                       fontSize: 14,
            //                                     ),
            //                                     SizedBox(height: getVerticalSize(5)),
            //                                     MyText(
            //                                       title: "A",
            //                                       clr: ColorConstant.antextlightgray,
            //                                       fontSize: 14,
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                               SizedBox(
            //                                 width: getHorizontalSize(2),
            //                               ),
            //                               Expanded(
            //                                 child: Column(
            //                                   crossAxisAlignment: CrossAxisAlignment.start,
            //                                   children: [
            //                                     MyText(
            //                                       title: "Colony/Residential Area Name",
            //                                       clr: ColorConstant.black900,
            //                                       fontSize: 14,
            //                                     ),
            //                                     SizedBox(height: getVerticalSize(5)),
            //                                     MyText(
            //                                       title: "Area Name",
            //                                       clr: ColorConstant.antextlightgray,
            //                                       fontSize: 14,
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           // SizedBox(height: getVerticalSize(8)),
            //                           // Container(
            //                           //   color: ColorConstant.antextlightgray,
            //                           //   height: 1,
            //                           // ),
            //                           // SizedBox(height: getVerticalSize(8)),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               )
            //             ],
            //           ),
            //           SizedBox(
            //             height: getVerticalSize(10),
            //           ),
            //           CustomExpansionTile(
            //             expand: false,               iconColor: Colors.transparent,
            //             leading: MyText(
            //               title: "Child",
            //               clr: ColorConstant.black900,
            //               fontSize: 18,
            //             ),
            //             title: MyText(
            //       // title: 'Monday Mon-04-2024 04:52 PM',
            //               title: '',
            //               clr: ColorConstant.antextlightgray,
            //               fontSize: 10,
            //             ),
            //             // subtitle: Align(
            //             //   alignment: Alignment.topRight,
            //             //   child: CommonImageView(
            //             //     imagePath: ImageConstant.viewIcon,
            //             //   ),
            //             // ),
            //             children: <Widget>[
            //               Align(
            //                 alignment: Alignment.topLeft,
            //                 child: Padding(
            //                   padding: getPadding(left: 20, right: 5, bottom: 10),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       MyText(
            //                         title: "Full Name",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "David Hamza",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),

            //                       MyText(
            //                         title: "Father’s Name",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "Hamza David Warner",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),

            //                       // Wrap the Row widget in a SizedBox or Container with a specific width
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "NIC Number",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "xxxxx-xxxxxxx-x",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               // Divider(color: ColorConstant.antextGrayDark,height: 20,),
            //                             ],
            //                           ),
            //                           // SizedBox(width: 2,),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Mobile number",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "0000-0000000",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                       MyText(
            //                         title: "House/Plot No.",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "House No. 156, Street Block Residential Plot",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Road",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "9",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                           // SizedBox(width: 2,),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Streetr",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "21",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                       Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Row(
            //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               Expanded(
            //                                 child: Column(
            //                                   crossAxisAlignment: CrossAxisAlignment.start,
            //                                   children: [
            //                                     MyText(
            //                                       title: "Block",
            //                                       clr: ColorConstant.black900,
            //                                       fontSize: 14,
            //                                     ),
            //                                     SizedBox(height: getVerticalSize(5)),
            //                                     MyText(
            //                                       title: "A",
            //                                       clr: ColorConstant.antextlightgray,
            //                                       fontSize: 14,
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                               SizedBox(
            //                                 width: getHorizontalSize(2),
            //                               ),
            //                               Expanded(
            //                                 child: Column(
            //                                   crossAxisAlignment: CrossAxisAlignment.start,
            //                                   children: [
            //                                     MyText(
            //                                       title: "Colony/Residential Area Name",
            //                                       clr: ColorConstant.black900,
            //                                       fontSize: 14,
            //                                     ),
            //                                     SizedBox(height: getVerticalSize(5)),
            //                                     MyText(
            //                                       title: "Area Name",
            //                                       clr: ColorConstant.antextlightgray,
            //                                       fontSize: 14,
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           // SizedBox(height: getVerticalSize(8)),
            //                           // Container(
            //                           //   color: ColorConstant.antextlightgray,
            //                           //   height: 1,
            //                           // ),
            //                           // SizedBox(height: getVerticalSize(8)),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               )
            //             ],
            //           ),
            //           SizedBox(
            //             height: getVerticalSize(10),
            //           ),
            //           CustomExpansionTile(
            //             expand: false,               iconColor: Colors.transparent,
            //             leading: MyText(
            //               title: "Servant ",
            //               clr: ColorConstant.black900,
            //               fontSize: 18,
            //             ),
            //             title: MyText(
            //        // title: 'Monday Mon-04-2024 04:52 PM',
            //               title: '',
            //               clr: ColorConstant.antextlightgray,
            //               fontSize: 10,
            //             ),
            //             // subtitle: Align(
            //             //   alignment: Alignment.topRight,
            //             //   child: CommonImageView(
            //             //     imagePath: ImageConstant.viewIcon,
            //             //   ),
            //             // ),
            //             children: <Widget>[
            //               Align(
            //                 alignment: Alignment.topLeft,
            //                 child: Padding(
            //                   padding: getPadding(left: 20, right: 5, bottom: 10),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       MyText(
            //                         title: "Full Name",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "David Hamza",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),

            //                       MyText(
            //                         title: "Father’s Name",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "Hamza David Warner",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),

            //                       // Wrap the Row widget in a SizedBox or Container with a specific width
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "NIC Number",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "xxxxx-xxxxxxx-x",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               // Divider(color: ColorConstant.antextGrayDark,height: 20,),
            //                             ],
            //                           ),
            //                           // SizedBox(width: 2,),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Mobile number",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "0000-0000000",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                       MyText(
            //                         title: "House/Plot No.",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "House No. 156, Street Block Residential Plot",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Road",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "9",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                           // SizedBox(width: 2,),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Streetr",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "21",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                       Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Row(
            //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               Expanded(
            //                                 child: Column(
            //                                   crossAxisAlignment: CrossAxisAlignment.start,
            //                                   children: [
            //                                     MyText(
            //                                       title: "Block",
            //                                       clr: ColorConstant.black900,
            //                                       fontSize: 14,
            //                                     ),
            //                                     SizedBox(height: getVerticalSize(5)),
            //                                     MyText(
            //                                       title: "A",
            //                                       clr: ColorConstant.antextlightgray,
            //                                       fontSize: 14,
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                               SizedBox(
            //                                 width: getHorizontalSize(2),
            //                               ),
            //                               Expanded(
            //                                 child: Column(
            //                                   crossAxisAlignment: CrossAxisAlignment.start,
            //                                   children: [
            //                                     MyText(
            //                                       title: "Colony/Residential Area Name",
            //                                       clr: ColorConstant.black900,
            //                                       fontSize: 14,
            //                                     ),
            //                                     SizedBox(height: getVerticalSize(5)),
            //                                     MyText(
            //                                       title: "Area Name",
            //                                       clr: ColorConstant.antextlightgray,
            //                                       fontSize: 14,
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           // SizedBox(height: getVerticalSize(8)),
            //                           // Container(
            //                           //   color: ColorConstant.antextlightgray,
            //                           //   height: 1,
            //                           // ),
            //                           // SizedBox(height: getVerticalSize(8)),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               )
            //             ],
            //           ),
            //           SizedBox(
            //             height: getVerticalSize(10),
            //           ),
            //           CustomExpansionTile(
            //             expand: false,
            //             iconColor: Colors.transparent,
            //             leading: MyText(

                        
            //               title: "Guest",
            //               clr: ColorConstant.black900,
            //               fontSize: 18,
            //             ),
            //             title: MyText(
            //               // title: 'Monday Mon-04-2024 04:52 PM',
            //               title: '',
            //               clr: ColorConstant.antextlightgray,
            //               fontSize: 10,
            //             ),
            //             // subtitle: Align(
            //             //   alignment: Alignment.topRight,
            //             //   child: CommonImageView(
            //             //     imagePath: ImageConstant.viewIcon,
            //             //   ),
            //             // ),
            //             children: <Widget>[
            //               Align(
            //                 alignment: Alignment.topLeft,
            //                 child: Padding(
            //                   padding: getPadding(left: 20, right: 5, bottom: 10),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       MyText(
            //                         title: "Full Name",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "David Hamza",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),

            //                       MyText(
            //                         title: "Father’s Name",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "Hamza David Warner",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),

            //                       // Wrap the Row widget in a SizedBox or Container with a specific width
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "NIC Number",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "xxxxx-xxxxxxx-x",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               // Divider(color: ColorConstant.antextGrayDark,height: 20,),
            //                             ],
            //                           ),
            //                           // SizedBox(width: 2,),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Mobile number",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "0000-0000000",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                       MyText(
            //                         title: "House/Plot No.",
            //                         clr: ColorConstant.black900,
            //                         fontSize: 14,
            //                       ),
            //                       SizedBox(height: getVerticalSize(5)),
            //                       MyText(
            //                         title: "House No. 156, Street Block Residential Plot",
            //                         clr: ColorConstant.antextlightgray,
            //                         fontSize: 14,
            //                       ),
            //                       Divider(color: ColorConstant.antextGrayDark),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Road",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "9",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                           // SizedBox(width: 2,),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               MyText(
            //                                 title: "Streetr",
            //                                 clr: ColorConstant.black900,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(height: getVerticalSize(5)),
            //                               MyText(
            //                                 title: "21",
            //                                 clr: ColorConstant.antextlightgray,
            //                                 fontSize: 14,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                               Container(
            //                                 color: ColorConstant.antextlightgray,
            //                                 height: 1,
            //                                 width: 150,
            //                               ),
            //                               SizedBox(
            //                                 height: getVerticalSize(8),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                       Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Row(
            //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               Expanded(
            //                                 child: Column(
            //                                   crossAxisAlignment: CrossAxisAlignment.start,
            //                                   children: [
            //                                     MyText(
            //                                       title: "Block",
            //                                       clr: ColorConstant.black900,
            //                                       fontSize: 14,
            //                                     ),
            //                                     SizedBox(height: getVerticalSize(5)),
            //                                     MyText(
            //                                       title: "A",
            //                                       clr: ColorConstant.antextlightgray,
            //                                       fontSize: 14,
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                               SizedBox(
            //                                 width: getHorizontalSize(2),
            //                               ),
            //                               Expanded(
            //                                 child: Column(
            //                                   crossAxisAlignment: CrossAxisAlignment.start,
            //                                   children: [
            //                                     MyText(
            //                                       title: "Colony/Residential Area Name",
            //                                       clr: ColorConstant.black900,
            //                                       fontSize: 14,
            //                                     ),
            //                                     SizedBox(height: getVerticalSize(5)),
            //                                     MyText(
            //                                       title: "Area Name",
            //                                       clr: ColorConstant.antextlightgray,
            //                                       fontSize: 14,
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           // SizedBox(height: getVerticalSize(8)),
            //                           // Container(
            //                           //   color: ColorConstant.antextlightgray,
            //                           //   height: 1,
            //                           // ),
            //                           // SizedBox(height: getVerticalSize(8)),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               )
            //             ],
            //           ),
                   
                   
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowLeft() {
    Get.back();
  }
}
