import 'package:anchorageislamabad/core/utils/color_constant.dart';
import 'package:anchorageislamabad/core/utils/image_constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../core/utils/size_utils.dart';
import 'custom_button.dart';


class CustomText extends StatelessWidget {
  final String text;
  final Color fontColor;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final bool underlined, lineThrough;
  final String? fontFamily;
  final double fontSize;
  final double? lineSpacing;
  final int? maxLines;
  final double textScaleFactor;
  final bool isSp, italic;

  //final double minfontsize,scalefactor,fontsize;

  const CustomText({super.key,
    required this.text,
    this.fontColor = Colors.black,
    this.fontSize = 14,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.underlined = false,
    this.italic = false,
    this.lineSpacing,
    this.isSp = true,
    this.maxLines, //double line_spacing=1.2,
   // this.fontFamily = FontFamily.urbanist,
    this.lineThrough = false,
    this.textScaleFactor = 1.0, this.fontFamily,
    // this.minfontsize=10,//this.scalefactor,
  });

  @override
  Widget build(BuildContext context) {
    //  double text_scale_factor=(media.size.width*media.size.height)/328190;
    //print("new text scale factor: ${text_scale_factor}");
    return Text(
      text, //textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
      textAlign: textAlign,
      style: TextStyle(
        color: fontColor,
        fontWeight: fontWeight,
        height: lineSpacing,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        fontSize: isSp ? getFontSize(fontSize) : fontSize,
        fontFamily: fontFamily,
        decorationThickness: 2.0,
        decoration: underlined
            ? TextDecoration.underline
            : (lineThrough ? TextDecoration.lineThrough : TextDecoration.none),
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  //final String text1,text2;
  final double fontSize;
  final TextAlign textAlign;
  final List<TextSpan> spans;
  final double linespacing;
  final String? fontFamily;
  final bool isSp;
  final Color color;
  final int? maxlines;

  const CustomRichText({
    Key? key,
    required this.spans,this.maxlines,
    this.fontSize = 15,
    this.linespacing = 1.2,
    this.textAlign = TextAlign.start,
    this.color = Colors.black,
   // this.fontFamily = FontFamily.PRIMARY,
    this.isSp = true, this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: textAlign,maxLines: maxlines,
        softWrap: true,
        text: TextSpan(
          style: TextStyle(
              color: color,
              height: linespacing,
              fontFamily: fontFamily,
              fontSize: isSp ? getFontSize(fontSize) : fontSize),
          children: spans,
        ));
  }
}

class CustomSpan extends TextSpan {
  CustomSpan(
      {String text = "",
        Color fontColor = Colors.black,
        FontWeight fontWeight = FontWeight.normal,
        double fontSize = 12,
        void Function()? onTap})
      : super(
      text: text,
      style: TextStyle(
          color: fontColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
       // fontFamily: FontFamily.urbanist
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap);
}

class ShadowContainer extends StatelessWidget {
  final double elevation;
  final Widget child;
  final double radius;
  final bool enabledPadding;

  const ShadowContainer({
    Key? key,
    this.elevation = 5,
    required this.child,
    this.enabledPadding = false,
    this.radius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(enabledPadding ? elevation : 0),
      child: Material(
        elevation: elevation,
        shadowColor: ColorConstant.appDescriptionTextColor,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}

class ButtonBack extends AppBarButton {
  ButtonBack({
    required void Function() onTap,
    Color color = Colors.black,
  }) : super(
    onTap: onTap,
    icon: ImageConstant.complaintAddIcon,
    color: color,
  );
}

class CrossButton extends AppBarButton {
  CrossButton({
    required void Function() onTap,
    Color color = Colors.black,
  }) : super(
    onTap: onTap,
    icon: ImageConstant.complaintAddIcon,
    color: color,
  );
}


