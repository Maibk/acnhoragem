//
//
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:auto_app/core/app_export.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../core/utils/color_constant.dart';
// import '../core/utils/image_constant.dart';
// import '../presentation/home_one_screen/controller/home_one_controller.dart';
// import 'common_image_view.dart';
//
// class CustomBottomBar extends StatelessWidget {
//   CustomBottomBar({this.onChanged});
//
//  // HomeOneController controller = Get.put(HomeOneController());
//
//   final _pageController = PageController(initialPage: 0);
//
//   /// Controller to handle bottom nav bar and also handles initial page
//  // final _controller = NotchBottomBarController(index: 0);
//
//   int maxCount = 5;
//
//   // RxInt selectedIndex = 0.obs;
//
//   List<String> bottomMenuDefaultIcons = [
//     ImageConstant.imgNavHome,
//     ImageConstant.imgNavDiscoverPrimary,
//     ImageConstant.imgNavMyCart,
//     ImageConstant.imgNavMenu,
//   ];
//
//   List<String> bottomMenuSelectedIcons = [
//     ImageConstant.imgClose,
//     ImageConstant.imgClose,
//     ImageConstant.imgClose,
//     ImageConstant.imgClose,
//
//   ];
//
//   List<BottomMenuModel> bottomMenuList = [
//     BottomMenuModel(
//       icon: ImageConstant.imgNavHome,
//       title: "lbl_home".tr,
//       type: BottomBarEnum.Home,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavDiscoverPrimary,
//       title: "lbl_discover".tr,
//       type: BottomBarEnum.Map,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavMyCart,
//       title: "lbl_my_cart".tr,
//       type: BottomBarEnum.Newpost,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavMenu,
//       title: "lbl_menu".tr,
//       type: BottomBarEnum.Rewards,
//     ),
//   ];
//
//   Function(BottomBarEnum)? onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: ColorConstant.blackColor,
//       child: AnimatedNotchBottomBar(
//         notchBottomBarController: _controller,
//         color: Colors.white,
//         showLabel: true,
//         itemLabelStyle: TextStyle(
//             color: Colors.black,
//             fontSize: 10.0
//         ),
//         shadowElevation: 10,
//         kBottomRadius: 28.0,
//         notchColor: ColorConstant.apppinkColor,
//         durationInMilliSeconds: 300,
//         bottomBarItems: [
//           BottomBarItem(
//             inActiveItem: CommonImageView(
//               svgPath: ImageConstant.imgNavHome,
//
//             ),
//             activeItem: CommonImageView(
//               svgPath: ImageConstant.imgNavHome,
//               color: ColorConstant.apppWhite,
//             ),
//             itemLabel: 'Home',
//           ),
//           BottomBarItem(
//             inActiveItem: CommonImageView(
//               svgPath: ImageConstant.imgNavDiscoverPrimary,
//             ),
//             activeItem: CommonImageView(
//               svgPath: ImageConstant.imgNavDiscoverPrimary,
//               color: ColorConstant.apppWhite,
//             ),
//             itemLabel: 'Discover',
//           ),
//
//           BottomBarItem(
//             inActiveItem: CommonImageView(
//               svgPath: ImageConstant.imgNavMyCart,
//             ),
//             activeItem: CommonImageView(
//               svgPath: ImageConstant.imgNavMyCart,
//               color: ColorConstant.apppWhite,
//             ),
//             itemLabel: 'My Cart',
//           ),
//           BottomBarItem(
//             inActiveItem: CommonImageView(
//               svgPath: ImageConstant.imgNavMyCart,
//             ),
//             activeItem: CommonImageView(
//               svgPath: ImageConstant.imgNavMyCart,
//               color: ColorConstant.apppWhite,
//             ),
//             itemLabel: 'Menu',
//           ),
//
//         ],
//         onTap: (index) {
//           controller.selectedIndex.value = index;
//           onChanged!(bottomMenuList[index].type);
//         },
//         kIconSize: 24.0,
//       ),
//     );
//   }
//
//   updateBttomIcon() {
//     resetIcons();
//     bottomMenuList[controller.selectedIndex.value].icon =
//     bottomMenuSelectedIcons[controller.selectedIndex.value];
//   }
//
//   resetIcons() {
//     int count = 0;
//     bottomMenuList.forEach((model) {
//       model.icon = bottomMenuDefaultIcons[count];
//       print(model);
//       count++;
//     });
//   }
// }
//
// enum BottomBarEnum {
//   Home,
//   Map,
//   Newpost,
//   Rewards,
//   More,
// }
//
// class BottomMenuModel {
//   BottomMenuModel({required this.icon, this.title, required this.type});
//
//   String icon;
//
//   String? title;
//
//   BottomBarEnum type;
// }
//
// class DefaultWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.all(10),
//       child: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Please replace the respective Widget here',
//               style: TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:auto_app/core/app_export.dart';
// // import 'package:flutter/material.dart';
// //
// // class CustomBottomBar extends StatelessWidget {
// //   CustomBottomBar({
// //     Key? key,
// //     this.onChanged,
// //   }) : super(
// //           key: key,
// //         );
// //
// //   RxInt selectedIndex = 0.obs;
// //
// //   List<BottomMenuModel> bottomMenuList = [
// //     BottomMenuModel(
// //       icon: ImageConstant.imgNavHome,
// //       activeIcon: ImageConstant.imgNavHome,
// //       title: "lbl_home".tr,
// //       type: BottomBarEnum.Home,
// //     ),
// //     BottomMenuModel(
// //       icon: ImageConstant.imgNavDiscoverPrimary,
// //       activeIcon: ImageConstant.imgNavDiscoverPrimary,
// //       title: "lbl_discover".tr,
// //       type: BottomBarEnum.Discover,
// //     ),
// //     BottomMenuModel(
// //       icon: ImageConstant.imgNavMyCart,
// //       activeIcon: ImageConstant.imgNavMyCart,
// //       title: "lbl_my_cart".tr,
// //       type: BottomBarEnum.Mycart,
// //     ),
// //     BottomMenuModel(
// //       icon: ImageConstant.imgNavMenu,
// //       activeIcon: ImageConstant.imgNavMenu,
// //       title: "lbl_menu".tr,
// //       type: BottomBarEnum.Menu,
// //     )
// //   ];
// //
// //   Function(BottomBarEnum)? onChanged;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 112.v,
// //       decoration: BoxDecoration(
// //         color: theme.colorScheme.primaryContainer,
// //         border: Border.all(
// //           color: theme.colorScheme.primaryContainer.withOpacity(1),
// //           width: 1.h,
// //         ),
// //       ),
// //       child: Obx(
// //         () => BottomNavigationBar(
// //           backgroundColor: Colors.transparent,
// //           showSelectedLabels: false,
// //           showUnselectedLabels: false,
// //           selectedFontSize: 0,
// //           elevation: 0,
// //           currentIndex: selectedIndex.value,
// //           type: BottomNavigationBarType.fixed,
// //           items: List.generate(bottomMenuList.length, (index) {
// //             return BottomNavigationBarItem(
// //               icon: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   CustomImageView(
// //                     imagePath: bottomMenuList[index].icon,
// //                     height: 21.adaptSize,
// //                     width: 21.adaptSize,
// //                     color: theme.colorScheme.primary,
// //                   ),
// //                   Opacity(
// //                     opacity: 0.4,
// //                     child: Padding(
// //                       padding: EdgeInsets.only(top: 4.v),
// //                       child: Text(
// //                         bottomMenuList[index].title ?? "",
// //                         style: CustomTextStyles.bodySmallBlack90001.copyWith(
// //                           color: appTheme.black90001.withOpacity(0.49),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               activeIcon: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   CustomImageView(
// //                     imagePath: bottomMenuList[index].activeIcon,
// //                     height: 17.v,
// //                     width: 16.h,
// //                     color: theme.colorScheme.primary,
// //                   ),
// //                   Padding(
// //                     padding: EdgeInsets.only(top: 8.v),
// //                     child: Text(
// //                       bottomMenuList[index].title ?? "",
// //                       style: CustomTextStyles.labelSmallBlack90001.copyWith(
// //                         color: appTheme.black90001,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               label: '',
// //             );
// //           }),
// //           onTap: (index) {
// //             selectedIndex.value = index;
// //             onChanged?.call(bottomMenuList[index].type);
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // enum BottomBarEnum {
// //   Home,
// //   Discover,
// //   Mycart,
// //   Menu,
// // }
// //
// // class BottomMenuModel {
// //   BottomMenuModel({
// //     required this.icon,
// //     required this.activeIcon,
// //     this.title,
// //     required this.type,
// //   });
// //
// //   String icon;
// //
// //   String activeIcon;
// //
// //   String? title;
// //
// //   BottomBarEnum type;
// // }
// //
// // class DefaultWidget extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       color: Colors.white,
// //       padding: EdgeInsets.all(10),
// //       child: Center(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               'Please replace the respective Widget here',
// //               style: TextStyle(
// //                 fontSize: 18,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
