import 'package:flutter/material.dart';
import '../core/utils/color_constant.dart';
import '../theme/app_style.dart';

class SearchTextField extends StatefulWidget {
  final String? title;
  final double? height;
  final double? width;
  final double? horizontalPadding;
  final TextEditingController? controller;
  final String Function(String)? validator;
  final Function(String)? onFieldSubmit;
  final Function(String)? onChanged;
  final String? hintText;
  final Function? onTapSuffixIcon;
  final Function? onTap;
  final Function? onTapPrefixIcon;
  int? limit;
  // ignore: prefer_typing_uninitialized_variables
  final suffixIconData;
  final bool? multiIcon;
  final IconData? prefixIconData;
  final FocusNode? focusNode;
  final Color? backgroundColor;
  final Color? hintTextColor;
  final Color? cursorColor;
  final Color? textColor;
  final Color? prefixIconColor;
  final Color? sufixIconColor;
  final Color? sufixcolor;
  final Color? borderColor;
  final Widget? prefixWidget;
  final TextInputType? inputType;
  final bool? obscureText;
  final InputDecoration? inputDecoration;
  final Widget? suffixIcons;
  final bool? fullBorder;
  final bool? validate;
  final bool? showChat;
  final bool? autoFocus;
  final bool? showLabel;
  final bool? readOnly;
  final int? maxLength;
  final String? initialvalue;
  final int? maxLines;
  final double? iconSize;
  final double? keyboardtypephone;

  static const Color _textFieldThemeColor =  Color(0xffffffff);

  // ignore: use_key_in_widget_constructors
   SearchTextField({
    this.onChanged,
    this.maxLength,
    this.horizontalPadding,
    this.width,
    this.validate,
    this.showLabel,
    this.height,
    this.fullBorder,
    this.showChat,
    this.borderColor,
    this.inputDecoration,
    this.multiIcon,
    this.title,
    this.onTap,
     this.sufixcolor,
    this.limit,
    this.controller,
    this.autoFocus = false,
    this.validator,
    this.onFieldSubmit,
    this.initialvalue,
    this.hintText,
    this.onTapSuffixIcon,
    this.suffixIconData,
    this.prefixIconData,
    this.onTapPrefixIcon,
    this.focusNode,
    this.backgroundColor = Colors.transparent,
    this.hintTextColor = _textFieldThemeColor,
    this.cursorColor = _textFieldThemeColor,
    this.textColor = _textFieldThemeColor,
    this.prefixIconColor = _textFieldThemeColor,
    this.sufixIconColor = _textFieldThemeColor,
    this.prefixWidget,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcons,
    this.readOnly,
    this.maxLines,
    this.iconSize,
    this.keyboardtypephone,
  });

  @override
  TextFieldState createState() => TextFieldState();
}

class TextFieldState extends State<SearchTextField> {

  String text = "";


  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Center(
        child: TextFormField(
          maxLines: widget.maxLines ?? 1,

          initialValue: widget.initialvalue,
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          readOnly: widget.readOnly ?? false,
          obscureText: widget.obscureText!,
          obscuringCharacter: "*",
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          keyboardType: widget.inputType,

          textCapitalization: TextCapitalization.sentences,
          focusNode: widget.focusNode,
          validator: (val) {
            if (widget.validate == true) {
              return "${widget.title} can not be empty";
            }
            widget.validator!(val!);
            return null;

          },
          cursorWidth: 1,
          cursorColor: widget.cursorColor,
          autofocus: widget.autoFocus!,
          controller: widget.controller,
          style: AppStyle.hintTextStyle.copyWith(
              decoration: TextDecoration.none, color: widget.textColor??ColorConstant.appBlack,fontSize: 16),
          onFieldSubmitted: widget.onFieldSubmit,
          decoration: widget.inputDecoration ??
              InputDecoration(
                hoverColor: Colors.white,
                labelText: widget.showLabel == true ? widget.title : null,
                labelStyle: AppStyle.hintTextStyle.copyWith(color: widget.hintTextColor),
                hintText: widget.hintText,
                hintStyle: AppStyle.hintTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: widget.hintTextColor ?? ColorConstant.appdarktext,
                    fontSize: 17),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: widget.fullBorder == false
                        ? widget.horizontalPadding ?? 0
                        : 20,
                    vertical: widget.fullBorder == false ? 10 : 2),
                suffixIcon: widget.suffixIconData == null
                    ? null
                    : widget.multiIcon == null
                    ?
                    widget.showChat == true
                        ? GestureDetector(
                      onTap: () {
                        widget.onTapSuffixIcon!();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: widget.sufixcolor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          widget.suffixIconData,
                          color: widget.sufixIconColor,
                          size: widget.iconSize ?? 15,
                        ),
                      ),
                    )
                        :
                GestureDetector(
                  onTap: () {
                    widget.onTapSuffixIcon!();
                  },
                  child: Icon(
                    widget.suffixIconData,
                    color: widget.sufixIconColor,
                    size: widget.iconSize ?? 15,
                  ),
                )
                    : widget.suffixIconData,
                prefixIcon: widget.prefixWidget ?? (widget.prefixIconData == null
                    ? null
                    : GestureDetector(
                  onTap: () {
                    widget.onTapPrefixIcon!();
                  },
                  child: Icon(
                    widget.prefixIconData,
                    color: widget.prefixIconColor,
                  ),
                )),
                focusedBorder:
                (widget.fullBorder == true || widget.fullBorder == null)
                    ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: widget.borderColor != null
                          ? widget.borderColor!
                          : widget.textColor!,
                      width: 1),
                )
                    : UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor != null
                          ? widget.borderColor!
                          : widget.textColor!,
                      width: 1),
                ),
                suffix: widget.suffixIcons,
                enabledBorder:
                (widget.fullBorder == true || widget.fullBorder == null)
                    ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: widget.borderColor != null
                          ? widget.borderColor!
                          : ColorConstant.appdarktext,
                      width: 1),
                )
                    : UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor != null
                          ? widget.borderColor!
                          :  ColorConstant.appdarktext,
                      width: 1.5),
                ),
                disabledBorder:
                (widget.fullBorder == true || widget.fullBorder == null)
                    ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: widget.borderColor != null
                          ? widget.borderColor!
                          :  ColorConstant.appdarktext,
                      width: 1),
                )
                    : UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor != null
                          ? widget.borderColor!
                          :  ColorConstant.appdarktext,
                      width: 1),
                ),
                border: (widget.fullBorder == true || widget.fullBorder == null)
                    ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: widget.borderColor != null
                          ? widget.borderColor!
                          :  ColorConstant.appdarktext,
                      width: 1),
                )
                    : UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor != null
                          ? widget.borderColor!
                          :  ColorConstant.appdarktext,
                      width: 1),
                ),
              ),
        ),
      ),
    );
  }
}