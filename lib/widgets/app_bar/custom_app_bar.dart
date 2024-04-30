import 'package:flutter/material.dart';
import 'package:anchorageislamabad/core/utils/size_utils.dart';
import '../../theme/theme_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.trailing,
    this.centerTitle,
    this.actions,
  }) : super(key: key);

  final double? height;
  final Style? styleType;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final bool? centerTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? 71.v,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: <Widget>[
        if (trailing != null) trailing!,
        if (actions != null) ...actions!,
      ],
    );
  }

  @override
  Size get preferredSize => Size(
    SizeUtils.width,
    height ?? 71.v,
  );

  Widget? _getStyle() {
    switch (styleType) {
      case Style.bgOutline:
        return Container(
          height: 48.v,
          width: 290.h,
          margin: EdgeInsets.only(
            left: 15.5.h,
            right: 69.5.h,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withOpacity(1),
            borderRadius: BorderRadius.circular(10.h),
            border: Border.all(
              color: appTheme.gray20001,
              width: 1.h,
            ),
          ),
        );
      case Style.bgFill:
        return Container(
          height: 71.v,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withOpacity(1),
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgOutline,
  bgFill,
}