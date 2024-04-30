// import 'package:auto_app/core/app_export.dart';
// import 'package:auto_app/widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import '../core/utils/color_constant.dart';
// import '../presentation/home_screen/controller/myprofile_controller.dart';
// import 'common_image_view.dart';
//
// class featuredItem extends StatelessWidget {
//
//   featuredItem(this.index);
//   int index;
//   var controller = Get.find<HomeController>();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       child: Container(
//         decoration: BoxDecoration(
//             color: ColorConstant.apppWhite,
//           borderRadius: BorderRadius.circular(10)
//         ),
//         child:  Padding(
//           padding: getPadding(left: 8,right: 8,top: 10,bottom: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//
//             children: [
//               Expanded(
//                 child: CommonImageView(
//                   imagePath: ImageConstant.imgImage4,
//                 ),
//               ),
//               SizedBox(width: getHorizontalSize(8),),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     MyText(title: "Brake System",fontSize: 14,),
//                     SizedBox(height: getVerticalSize(2),),
//                     MyText(title: "1.2k production",fontSize: 11,clr: ColorConstant.appgreenColor,),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
