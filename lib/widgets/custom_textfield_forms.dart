import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/utils/app_fonts.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/responsive.dart';
import '../theme/app_style.dart';


class CustomTextFieldForms extends StatefulWidget {
  String? fieldText;
  String? hintText;
  bool? isFinal;
  bool? enabled;
  List<TextInputFormatter>? inputFormatters;
  FormFieldValidator<String>? validator;
  int? limit;
  int? maxLines;
  String? icon;
  Widget? postPixText;
  IconData? iconData;
  Function? sufixIconOnTap;
  Function? onTap;
  final Function(String)? onChanged;
  bool? isPassword;
  bool? isCaps;
  double? nameWidth;
  TextEditingController? controller;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  FocusNode? nextFocusNode;
  ValueChanged<String>? onFieldSubmitted;
  VoidCallback? onEditingComplete;
  Color? lableColor;
  double? lableFontSize;
  double? iconSize;
  double? iconHeight;
  double? sidePadding;
  Widget? prefixWidget;

  CustomTextFieldForms({
    Key? key,
    this.fieldText,
    this.hintText,
    this.isFinal,
    this.validator,
    this.enabled = true,
    this.isCaps = false,
    this.inputFormatters,
    this.onChanged,
    this.icon,
    this.postPixText,
    this.iconData,
    this.sufixIconOnTap,
    this.onTap,
    this.isPassword = false,
    this.limit,
    this.maxLines,
    this.nameWidth,
    this.focusNode,
    this.nextFocusNode,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.lableColor,
    this.lableFontSize,
    this.iconHeight,
    this.sidePadding,
    this.iconSize,
    this.prefixWidget,
  }) : super(key: key);

  @override
  _CustomTextFieldFormsState createState() => _CustomTextFieldFormsState();
}

class _CustomTextFieldFormsState extends State<CustomTextFieldForms> {

  Responsive responsive = Responsive();

  String text = "";

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return GestureDetector(
      onTap: () {
        widget.onTap!();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 3.0,
        ),
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(00.0)),
        child: Column(
          children: [
            Stack(
              children: [
                TextFormField(
                  textCapitalization: widget.isCaps!
                      ? TextCapitalization.sentences
                      : TextCapitalization.none,
                  obscureText: widget.isPassword!,
                  focusNode: widget.focusNode,

                  validator: widget.validator,
                  enabled: widget.enabled ?? false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: ColorConstant.hintTextColor,
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                //  textInputAction: TextInputAction.newline,
                  maxLines: widget.maxLines ?? 1,
                //  textInputAction: TextInputAction.newline,
                  onChanged: (String newVal) {
                    if(newVal.startsWith(' ')){
                      widget.controller!.text = '';
                    }
                    else if (newVal.length <= widget.limit!) {
                      text = newVal;
                    } else {
                      widget.controller!.value = TextEditingValue(
                          text: text,
                          selection: TextSelection(
                              baseOffset: widget.limit!,
                              extentOffset: widget.limit!,
                              affinity: TextAffinity.downstream,
                              isDirectional: false),
                          composing: TextRange(start: 0, end: widget.limit!));
                    }
                    if(widget.onChanged != null){
                      widget.onChanged!(newVal);
                    }
                  },
                  inputFormatters: widget.inputFormatters,
                  onFieldSubmitted: (_) {
                    widget.isFinal!
                        ? FocusScope.of(context).unfocus()
                        : FocusScope.of(context)
                            .requestFocus(widget.nextFocusNode!);
                  },
                  onEditingComplete: () {
                    widget.isFinal!
                        ? FocusScope.of(context).unfocus()
                        : FocusScope.of(context)
                            .requestFocus(widget.nextFocusNode!);
                  },
                  textInputAction: widget.isFinal!
                      ? TextInputAction.done // For final fields, show "Done"
                      : widget.maxLines == 1
                      ? TextInputAction.next // For non-final single-line fields, show "Next"
                      : TextInputAction.newline,
                  //   style: _setFontStyle,
                //  decoration: AppStyles.decoration2(widget.fieldText!),
                  style:AppStyle.txtAgeoSemiBold16WhiteA700.copyWith(
                      fontSize: widget.lableFontSize ?? 16,
                      color: widget.lableColor ?? ColorConstant.blackColor,
                      fontWeight: FontWeight.normal),
                  
                  decoration: InputDecoration(
                    prefixIconConstraints: BoxConstraints(minWidth: 15,minHeight: 38),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 5.0,bottom: 5,right: 10),
                      child: widget.prefixWidget ?? null,
                    ),
                    filled: true,
                    fillColor: ColorConstant.apppWhite,
                    labelText: widget.fieldText,
                    hintText: widget.hintText,
                    hintStyle:   _setHintStyle(),
                    alignLabelWithHint: true,
                    errorStyle: TextStyle(
                      color: Theme.of(context).errorColor, // or any other color
                    ),
                    labelStyle: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                        fontSize: widget.lableFontSize ?? 15,
                        color: widget.lableColor ?? ColorConstant.gray600,
                        fontWeight: FontWeight.w400),
                   contentPadding: EdgeInsets.only(left: 1,right: 10,bottom: 15),
                    errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                            width: 1.0, color: Theme.of(context).errorColor)),
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                            width: 1.0, color: ColorConstant.appBorderGray)
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                            width: 1.0, color: ColorConstant.appBorderGray)),
                    disabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                            width: 1.0, color: ColorConstant.appBorderGray)),
                    focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                            BorderSide(width: 1.0, color: ColorConstant.appBorderGray)),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    widget.sufixIconOnTap!();
                    print('aerssss');
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top:10),
                    child: Align(alignment:Alignment.bottomRight,child: GestureDetector(
                      onTap: () {
                        widget.sufixIconOnTap!();
                      },
                      child: Container(
                        width: widget.iconSize ??40.0,
                        height: 35.0,
                        margin: EdgeInsets.only(
                            left: 10, right: 5),
                        padding: EdgeInsets.only(
                          right: 12.0,
                          bottom: 5,top: 2/* top:15.0*/
                        ),
                        child: widget.postPixText != null ? Align(alignment:Alignment.centerRight,child: widget.postPixText) :widget.icon == null
                            ? widget.iconData == null
                            ? Container()
                            : Icon(widget.iconData,color: ColorConstant.hintTextColor,)
                            : SvgPicture.asset(
                          widget.icon!,
                          matchTextDirection: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  _setFontStyle() {
    return TextStyle(
      fontSize: widget.lableFontSize ?? 14,
      color: ColorConstant.blackColor.withOpacity(0.5)?? ColorConstant.blackColor,
      fontFamily: widget.isPassword==true?'':AppFonts.lucidaBright,
      fontWeight: FontWeight.w400,
    );

  }

  _setHintStyle() {
    return TextStyle(
      fontSize: widget.lableFontSize ?? 14,
      color: ColorConstant.blackColor.withOpacity(0.5)?? ColorConstant.blackColor,
      fontFamily: widget.isPassword==false?'':AppFonts.lucidaBright,
      fontWeight: FontWeight.w400,
    );

  }
}
