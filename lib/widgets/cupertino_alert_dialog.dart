import 'package:flutter/material.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/size_utils.dart';
import 'custom_text.dart';



class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final Widget? contentWidget;
  final Color color1;
  final Color color2;
  final String? firstButtonContent;
  final String secondButtonContent;
  final VoidCallback? first;
  final VoidCallback second;

  const CustomAlertDialog(
      {
        required this.content,
        required this.title,
        this.contentWidget,
        this.firstButtonContent,
        required this.secondButtonContent,
        this.first,
        required this.second,
        this.color1 = Colors.cyan,
        this.color2 = Colors.pink});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorConstant.apppWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: MyText(
                        title: title,
                        fontSize: 19,
                        clr: ColorConstant.appBlack,
                        customWeight: FontWeight.w600,
                       // fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: contentWidget ??
                          MyText(
                            title: content,
                            fontSize: 15,
                            clr: ColorConstant.appBlack,
                            customWeight: FontWeight.w500,

                          ),
                    ),
                  ],
                ),
              ),
            ),
            firstButtonContent != null
                ? Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: first,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                      child: Center(
                        child: MyText(
                            title: firstButtonContent!,
                            fontSize: 18,
                            clr: ColorConstant.black900,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: second,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: MyText(
                            title: secondButtonContent,
                            fontSize: 18,
                            clr: ColorConstant.black900,

                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
                : InkWell(
              onTap: second,
              child: Padding(
                padding: getPadding(all: 14),
                child: Center(
                  child: MyText(
                      title: secondButtonContent,
                      fontSize: 18,
                      clr: ColorConstant.apppinkColor,

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
