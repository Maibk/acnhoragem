// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import '../core/utils/file_upload_helper.dart';
//
// class HomeSliderItemTile extends StatelessWidget {
//   final HomeController controller;
//   final int? index;
//   final Color? color;
//   final bool showDots;
//   final bool fromProfile;
//   final bool fromBookDetail;
//  // final String role;
//
//   const HomeSliderItemTile(
//       {Key? key,
//         required this.controller,
//         this.index,
//         this.color,
//         this.fromProfile = false,
//         this.fromBookDetail = false,
//         required this.showDots,
//        // required this.role,
//       })
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: ColorConstant.black900,
//       ),
//
//       child:  Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Stack(
//
//                   children: [
//                     controller.arrOfPosts[index!].postImage!.length > 1
//                         ? CarouselSlider.builder(
//                       options: CarouselOptions(
//                           viewportFraction: 1,
//                           initialPage: 0,
//                           reverse: false,
//                           onPageChanged: (index, reason) {
//                             controller.currentSliderIndex.value =
//                                 index;
//                           }),
//                       itemCount: controller
//                           .arrOfPosts[index!].postImage?.length,
//                       itemBuilder: (BuildContext context,
//                           int newIndex, int realIndex) {
//                         return GestureDetector(
//                             behavior: HitTestBehavior.opaque,
//                             child: controller.arrOfPosts[index!]
//                                 .postImage![newIndex]
//                                 .contains("mp4")
//                                 ? SocialVideoPlayer(
//                                 url: controller.arrOfPosts[index!]
//                                     .postImage![newIndex],
//                                 isUrl: true)
//                                 : CustomImageView(
//                                 fit: BoxFit.fill,
//                               imagePath: controller
//                                   .arrOfPosts[index!]
//                                   .postImage![newIndex],
//                             ));
//                       },
//                     )
//                         : FileManager().checkExtension(controller
//                         .arrOfPosts[index!].postImage!.first)
//                         ? SocialVideoPlayer(
//                         url: controller
//                             .arrOfPosts[index!].postImage!.first,
//                         isUrl: true)
//                         : CustomImageView(
//                         imagePath: controller
//                             .arrOfPosts[index!].postImage!.first),
//                     controller.arrOfPosts[index!].postImage!.length > 1
//                         ? Positioned(
//                       bottom: 10,
//                       left: 0,
//                       right: 10,
//                       child: Obx(() => Padding(
//                         padding: getPadding(left: 10,right: 10,top: 10,bottom: 10),
//                         child: AnimatedSmoothIndicator(
//                           activeIndex: controller
//                               .currentSliderIndex.value,
//                           count: controller
//                               .arrOfPosts[index!]
//                               .postImage!
//                               .length,
//                           effect:  ExpandingDotsEffect(
//                               spacing: 6,
//                               dotWidth: 10.0,
//                               dotHeight: 10.0,
//                               dotColor: Colors.grey,
//                               activeDotColor: ColorConstant.apppinkColor),
//                         ),
//                       )),
//                     )
//                         : const SizedBox.shrink(),
//                   ],
//                 ),
//               ],
//             )
//
//
//         ],
//       ),
//     );
//   }
//
// }
