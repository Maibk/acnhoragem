import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import '../core/utils/utils.dart';
import '../routes/app_routes.dart';
import 'common_image_view.dart';
import 'custom_image_view.dart';
import 'custom_text.dart';

class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({this.onChanged});

  //HomeOneController controller = Get.put(HomeOneController());

  // RxInt selectedIndex = 0.obs;

  List<String> bottomMenuDefaultIcons = [
    ImageConstant.imgNavHomePrimary,
    ImageConstant.imgNavDiscoverPrimary,
    ImageConstant.imgNavMyCart,
    ImageConstant.imgNavMenu,
  ];

  List<String> bottomMenuSelectedIcons = [
    ImageConstant.imgNavHome,
    ImageConstant.imgNavDiscover,
    ImageConstant.imgNavMyCart,
    ImageConstant.imgNavMenu,

  ];

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavHome,
      title: "lbl_home".tr,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavDiscoverPrimary,
      title: "lbl_discover".tr,
      type: BottomBarEnum.Discover,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavMyCart,
      title: "lbl_my_cart".tr,
      type: BottomBarEnum.MyCart,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavMenu,
      title: "lbl_menu".tr,
      type: BottomBarEnum.Menu,
    ),
  ];

  Function(BottomBarEnum)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: Colors.transparent),
            child: ClipRect(
              child: BackdropFilter(
                // blendMode: BlendMode.luminosity,
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: BottomNavigationBar(
                  backgroundColor: ColorConstant.appbottombarrtrans.withOpacity(0.7),
                  fixedColor: Colors.transparent,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedFontSize: 0.0, // Adjust the font size for the selected item
                  unselectedFontSize: 0.0, // Adjust the font size for the unselected items
                 // currentIndex: controller.selectedIndex.value,
                  type: BottomNavigationBarType.fixed,
                  // useLegacyColorScheme: true,
                  items: List.generate(bottomMenuList.length, (index) {
                    return BottomNavigationBarItem(
                      // backgroundColor: ColorConstant.blackColor,
                      tooltip: "sss",
                      icon: Column(

                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 30,),
                          CustomImageView(
                            svgPath: bottomMenuList[index].icon,
                            height: getSize(
                              24.00,
                            ),
                            width: getSize(
                              24.00,
                            ),
                            color: ColorConstant.appTextGray,
                          ),
                          Padding(
                              padding: getPadding(
                                top: 2,
                              ),
                              child:
                              MyText(
                                title: bottomMenuList[index].title ?? "",
                                fontSize: 13,
                                customWeight: FontWeight.w400,
                                clr: ColorConstant.appTextGray,
                              )
                          ),
                        ],
                      ),
                      activeIcon: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 30,),
                          CustomImageView(

                            svgPath: bottomMenuSelectedIcons[index],
                            height: getSize(
                              24.00,
                            ),
                            width: getSize(
                              24.00,
                            ),
                            color: ColorConstant.apppinkColor,
                          ),
                          Padding(
                              padding: getPadding(
                                top: 3,
                              ),
                              child:
                              MyText(
                                title: bottomMenuList[index].title ?? "",
                                fontSize: 13,
                                customWeight: FontWeight.w500,
                                clr: ColorConstant.appBlack,
                              ),

                          ),
                        ],
                      ),
                      label: '',

                    );
                  }),
                  onTap: (index) {
                    print("OnTap $index");
                   // controller.selectedIndex.value = index;
                    onChanged!(bottomMenuList[index].type);
                    if(index == 3){
                      showRewardsBottomSheet(context,index);
                    }
                  },
                ),
              ),
            ),
          )
    );
  }

  updateBttomIcon() {
    resetIcons();
   // bottomMenuList[controller.selectedIndex.value].icon =
  //  bottomMenuSelectedIcons[controller.selectedIndex.value];
  }

  showRewardsBottomSheet(BuildContext context,int index) {
    Utils.showBottomSheet(
        context,
    bottomSheetHeight: MediaQuery.of(context!).size.height * 0.944,
    widget:  Container(
      padding: getPadding(top: 150),
      width: double.infinity,
      child: Column(
        children: [
          MyText(
            title: "Home",
            clr: ColorConstant.apppWhite,
            fontSize: 30,
          ),
          SizedBox(height: getVerticalSize(20),),
          MyText(
            title: "About",
            clr: ColorConstant.apppWhite,
            fontSize: 30,
          ),
          SizedBox(height: getVerticalSize(20),),
          MyText(
            title: "Discover",
            clr: ColorConstant.apppWhite,
            fontSize: 30,
          ),
          SizedBox(height: getVerticalSize(20),),
          MyText(
            title: "Cart",
            clr: ColorConstant.apppWhite,
            fontSize: 30,
          ),
          SizedBox(height: getVerticalSize(20),),
          MyText(
            title: "Checkout",
            clr: ColorConstant.apppWhite,
            fontSize: 30,
          ),
          SizedBox(height: getVerticalSize(20),),
          MyText(
            title: "Profile",
            clr: ColorConstant.apppWhite,
            fontSize: 30,
          ),
          SizedBox(height: getVerticalSize(20),),
          MyText(
            title: "Notifications",
            clr: ColorConstant.apppWhite,
            fontSize: 30,
          ),
          SizedBox(height: getVerticalSize(20),),
              GestureDetector(
                onTap: (){
                //  Get.toNamed(AppRoutes.privacyAndPolicyScreen);
                },
                child: MyText(
                  title: "Pivacy Policy",
                  clr: ColorConstant.apppWhite,
                  fontSize: 20,
                ),
              ),
             SizedBox(height: getVerticalSize(20),),

              GestureDetector(
              onTap: (){
              Get.back();
              print("OnTap $index");
             // controller.selectedIndex.value = 0;
              onChanged!(bottomMenuList[0].type);
              print("OnTap $index");
            },
            child: CommonImageView(
              svgPath: ImageConstant.imgClose,
            ),
          )
        ],
      ),
    ),

    );
  }


  resetIcons() {
    int count = 0;
    bottomMenuList.forEach((model) {
      model.icon = bottomMenuDefaultIcons[count];
      print(model);
      count++;
    });
  }
}

enum BottomBarEnum {
  Home,
  Discover,
  MyCart,
  Menu,
}

class BottomMenuModel {
  BottomMenuModel({required this.icon, this.title, required this.type});

  String icon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




















// import 'package:auto_app/core/app_export.dart';
// import 'package:flutter/material.dart';
//
// class CustomBottomBar extends StatelessWidget {
//   CustomBottomBar({
//     Key? key,
//     this.onChanged,
//   }) : super(
//           key: key,
//         );
//
//   RxInt selectedIndex = 0.obs;
//
//   List<BottomMenuModel> bottomMenuList = [
//     BottomMenuModel(
//       icon: ImageConstant.imgNavHome,
//       activeIcon: ImageConstant.imgNavHome,
//       title: "lbl_home".tr,
//       type: BottomBarEnum.Home,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavDiscoverPrimary,
//       activeIcon: ImageConstant.imgNavDiscoverPrimary,
//       title: "lbl_discover".tr,
//       type: BottomBarEnum.Discover,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavMyCart,
//       activeIcon: ImageConstant.imgNavMyCart,
//       title: "lbl_my_cart".tr,
//       type: BottomBarEnum.Mycart,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavMenu,
//       activeIcon: ImageConstant.imgNavMenu,
//       title: "lbl_menu".tr,
//       type: BottomBarEnum.Menu,
//     )
//   ];
//
//   Function(BottomBarEnum)? onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 112.v,
//       decoration: BoxDecoration(
//         color: theme.colorScheme.primaryContainer,
//         border: Border.all(
//           color: theme.colorScheme.primaryContainer.withOpacity(1),
//           width: 1.h,
//         ),
//       ),
//       child: Obx(
//         () => BottomNavigationBar(
//           backgroundColor: Colors.transparent,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           selectedFontSize: 0,
//           elevation: 0,
//           currentIndex: selectedIndex.value,
//           type: BottomNavigationBarType.fixed,
//           items: List.generate(bottomMenuList.length, (index) {
//             return BottomNavigationBarItem(
//               icon: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CustomImageView(
//                     imagePath: bottomMenuList[index].icon,
//                     height: 21.adaptSize,
//                     width: 21.adaptSize,
//                     color: theme.colorScheme.primary,
//                   ),
//                   Opacity(
//                     opacity: 0.4,
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 4.v),
//                       child: Text(
//                         bottomMenuList[index].title ?? "",
//                         style: CustomTextStyles.bodySmallBlack90001.copyWith(
//                           color: appTheme.black90001.withOpacity(0.49),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               activeIcon: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CustomImageView(
//                     imagePath: bottomMenuList[index].activeIcon,
//                     height: 17.v,
//                     width: 16.h,
//                     color: theme.colorScheme.primary,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 8.v),
//                     child: Text(
//                       bottomMenuList[index].title ?? "",
//                       style: CustomTextStyles.labelSmallBlack90001.copyWith(
//                         color: appTheme.black90001,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               label: '',
//             );
//           }),
//           onTap: (index) {
//             selectedIndex.value = index;
//             onChanged?.call(bottomMenuList[index].type);
//           },
//         ),
//       ),
//     );
//   }
// }
//
// enum BottomBarEnum {
//   Home,
//   Discover,
//   Mycart,
//   Menu,
// }
//
// class BottomMenuModel {
//   BottomMenuModel({
//     required this.icon,
//     required this.activeIcon,
//     this.title,
//     required this.type,
//   });
//
//   String icon;
//
//   String activeIcon;
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
