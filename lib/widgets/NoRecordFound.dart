import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/utils/responsive.dart';
import 'custom_text.dart';

class NoRecordFound extends StatelessWidget {
  final String msg;
  final String? image;
  IconData? icon;

  Responsive responsive = Responsive();

  NoRecordFound(this.msg, this.image, {this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image != null? SvgPicture.asset(
              image!,
              width: 240.0,
              height: 100.0,
              matchTextDirection: true,
            ) : Container(),
            icon != null? Icon(
              icon,
              size: 40.0,
            ) : Container(),
            SizedBox(
              height: 20,
            ),
            MyText(
              title:
              msg.isEmpty? "No Record Found!":msg,
              weight: 'Semi Bold',
              fontSize: responsive.setTextScale(18),
            )
          ],
        ),
      ),
    );
  }
}
