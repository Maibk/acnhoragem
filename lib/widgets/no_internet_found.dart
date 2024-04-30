import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/responsive.dart';
import 'custom_text.dart';


class NoInternetFound extends StatelessWidget {

  Function()? onPressed;
  BuildContext context;
  bool showAnimation;
  bool showButton;

  NoInternetFound(this. context, this.onPressed, {this.showAnimation = true, this.showButton = true});

  Responsive responsive=new Responsive();
  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          showAnimation? Container(
              height: responsive.setHeight(20),
              width: responsive.setWidth(100),
              child: Lottie.asset('assets/lotties/no_internet_connection.json')) : Container(),
          // SvgPicture.asset(
          //   no_internet,
          //   width: 100.0,
          //   height: 100.0,
          //   matchTextDirection: true,
          // ),

          // Image.asset(AppImages.NO_INTERNET_IMAGE, scale: 2.5,),

          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText(
              title: "No Internet Connectivity! \nPlease check your internet connection and Try Again.",
              center: true,
              fontSize: 14,
              clr: ColorConstant.primaryTextColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          showButton? GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 150.0,
              height: 40.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black
              ),
              child:  Center(
                child: MyText(
                    clr: ColorConstant.whiteA700,
                    title: "Try Again"
                ),
              ),),
          ) : Container()
        ],
      ),
    );
  }
}
