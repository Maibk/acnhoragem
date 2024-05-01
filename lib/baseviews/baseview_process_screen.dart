
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import '../core/utils/color_constant.dart';
// import '../core/utils/helper_functions.dart';
// import '../core/utils/image_constant.dart';
// import '../core/utils/responsive.dart';
// import '../core/utils/size_utils.dart';
// import '../theme/app_decoration.dart';
// import '../widgets/app_bar/appbar_searchview.dart';
// import '../widgets/app_bar/appbar_subtitle.dart';
// import '../widgets/app_bar/custom_app_bars.dart';
// import '../widgets/app_status_bar.dart';
// import '../widgets/common_image_view.dart';
// import '../widgets/custom_back_button.dart';
// import '../widgets/custom_bottom_bar.dart';
// import '../widgets/custom_image_view.dart';
// import '../widgets/custom_text.dart';

// class BaseviewScreen extends StatelessWidget {
//   BaseviewScreen(
//       {this.showBottomBar,
//       this.sidePadding,
//         this.mainTopHeight,
//       this.child,
//       this.screenName,
//       this.basicAppBar,
//         this.showBackBtn,
//       this.backgroundColor,
//       this.hideAppBar,
//       this.searchHint,
//       this.isSearchTappable = true,
//       this.bottomWidget,
//       this.basicAppTrailingIcon,
//       this.searchController,
//       this.onBackTap,
//       this.onSearchSubmitted,
//       this.onSearchChanged,
//       this.basicAppTrailingIconOnTap,
//         this.appBarType,
//         this.image,
//         this.imageShown,
//       this.searchField});

//   bool? showBottomBar;

//   bool? basicAppBar;
//   bool? sidePadding;
//   bool? showBackBtn;
//   double? mainTopHeight;
//   String? screenName;
//   Color? backgroundColor;
//   bool? hideAppBar;
//   Widget? child;
//   Widget? basicAppTrailingIcon;
//   Function()? onBackTap;
//   Function(String)? onSearchSubmitted;
//   Function(String)? onSearchChanged;
//   String? searchHint;
//   bool isSearchTappable;
//   Function? basicAppTrailingIconOnTap;
//   Widget? searchField;
//   Widget? bottomWidget;
//   AppBarType? appBarType=AppBarType.basicAppBar;
//   bool? image;
//   String? imageShown;
//   TextEditingController? searchController;

//   Responsive responsive = Responsive();
//   TextEditingController textEditingController = TextEditingController();

//   // ColorConfig colors = ColorConfig();
//  // DashboardController controller = Get.put(DashboardController());

//   @override
//   Widget build(BuildContext context) {
//    //  AppStatusBar.getDefaultStatusBar();
//     responsive.setContext(context);

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: backgroundColor ?? ColorConstant.appBackgroundgrayColor,
//       bottomNavigationBar: showBottomBar != false ? CustomBottomBar() : bottomWidget != null? bottomWidget : null,
//       body:
//       AnnotatedRegion<SystemUiOverlayStyle>(
//         value: AppStatusBar.getDefaultStatusBar(),
//         child:
//        SafeArea(
//          child: GestureDetector(
//            onTap: () {
//              FocusScope.of(context).requestFocus(new FocusNode());
//            },
//            child: Container(
//                height: responsive.setHeight(HelperFunction.FULL_SCREEN_SIZE),
//                width: responsive.setWidth(HelperFunction.FULL_SCREEN_SIZE),
//                color: backgroundColor ?? ColorConstant.appBackgroundgrayColor,
//                child: Padding(
//                  padding: EdgeInsets.symmetric(
//                      horizontal: sidePadding == false
//                          ? 0
//                          : HelperFunction.SCREENS_SIDE_PADDING),
//                  child: Column(
//                    children: [
//                      getAppBar(appBarType??AppBarType.basicAppBar),
//                      Expanded(
//                        child: Container(
//                          width: responsive.setWidth(100),
//                          decoration: AppDecoration.fillBlack,
//                          child: Column(
//                            children: [Expanded(child: child ?? Container())],
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                )),
//          ),
//        )
//       ),

//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }


//   getSearchAppBar()
//   {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding:EdgeInsets.symmetric(horizontal: 3),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,

//             children: [
//               Icon(Icons.arrow_back_ios_new_rounded,),
//               Flexible(
//                 child: Container(
//                   margin: EdgeInsets.only(left: 10,right: 20,top: 10,bottom: 3),
//                   child: AppbarSearchview(
//                     controller: searchController,
//                     onSubmitted: onSearchSubmitted,
//                     onChanged: onSearchChanged,
//                     isTappable: isSearchTappable,
//                     hintText: searchHint ?? "lbl_search".tr,
//                   ),
//                 ),
//               ),

//             ],
//           ),
//         ),
//         Divider()
//       ],
//     );

//   }

//   getSearchCountryAppBar()
//   {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding:EdgeInsets.symmetric(horizontal: 3),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,

//             children: [
//               Flexible(
//                 child: Container(
//                   margin: EdgeInsets.only(left: 10,right: 20,top: 10,bottom: 3),
//                   child: AppbarSearchview(
//                     hintText: "Dubai".tr,
//                     // controller: controller.searchFieldController,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: AppbarSubtitle(
//                   text: "lbl_cancel".tr,
//                   onTap: (){
//                     print("abcd");
//                     Get.back();
//                   },
//                   // margin:EdgeInsets.symmetric(horizontal: 20,vertical: 5),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Divider()
//       ],
//     );

//   }

//   getBasicAppBar()
//   {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//           ),

//           child: Padding(
//             padding: const EdgeInsets.only(
//                 top: 18.0,
//                 bottom: 14.0,
//                 left: HelperFunction.FORM_PADDING,
//                 right: HelperFunction.FORM_PADDING),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if(showBackBtn != false)
//                       CustomBackButton(onTap: onBackTap),
//                     if(showBackBtn == false)
//                       Container(
//                         width: responsive.setWidth(6.7),
//                       ),
//                     SizedBox( width: responsive.setWidth(6.7),),
//                     MyText(
//                       title:
//                       '${screenName ?? ''}',
//                       weight: 'Semi Bold',
//                       fontSize: responsive.setTextScale(18),
//                     ),Spacer(),
//                     if (basicAppTrailingIcon == null)
//                       Container(
//                         width: responsive.setWidth(5),
//                       ),
//                     if (basicAppTrailingIcon != null)
//                       GestureDetector(
//                           onTap: () {
//                             basicAppTrailingIconOnTap!();
//                           },
//                           child: basicAppTrailingIcon?? Icon(Icons.home,size: 25,))
//                   ],
//                 ),
//                 if (searchField != null)
//                   SizedBox(
//                     height: responsive.setHeight(1.5),
//                   ),
//                 searchField ?? Container(),
//                 SizedBox(
//                   height: responsive.setHeight(0),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         bindDivider()
//       ],
//     );

//   }

// }
// bindDivider() {
//   return CommonImageView(
//     svgPath: ImageConstant.imgArrowLeft,
//     height: 1,
//   );
// }
// enum AppBarType {
//   homeAppBar,
//   basicAppBar,
//   searchAppBar,
//   searchCoutryAppBar,
//   searchAppBarLocation,
// }
