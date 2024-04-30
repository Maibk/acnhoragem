import 'package:anchorageislamabad/core/utils/size_utils.dart';
import 'package:anchorageislamabad/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLarge18 => theme.textTheme.bodyLarge!.copyWith(
        fontSize: 18.fSize,
      );
  static get bodyLargeInter => theme.textTheme.bodyLarge!.inter;
  static get bodyLargeInterPrimary => theme.textTheme.bodyLarge!.inter.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodyLargePrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
      );
  static get bodyLargePrimaryContainer18 => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 18.fSize,
      );
  static get bodyLargePrimaryContainer_1 => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
      );
  static get bodyLarge_1 => theme.textTheme.bodyLarge!;
  static get bodyMedium15 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 15.fSize,
      );
  static get bodyMediumJUSTSans => theme.textTheme.bodyMedium!.jUSTSans;
  static get bodyMediumOnError => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onError,
        fontSize: 15.fSize,
      );
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 15.fSize,
      );
  static get bodyMediumPrimaryContainer => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 13.fSize,
      );
  static get bodyMediumPrimaryContainer13 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 13.fSize,
      );
  static get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmall12 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 12.fSize,
      );
  static get bodySmall12_1 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 12.fSize,
      );
  static get bodySmallBlack90001 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black90001.withOpacity(0.49),
        fontSize: 9.fSize,
      );
  static get bodySmallGray50002 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray50002,
        fontSize: 10.fSize,
      );
  static get bodySmallJUSTSans => theme.textTheme.bodySmall!.jUSTSans.copyWith(
        fontSize: 12.fSize,
      );
  static get bodySmallJUSTSansGray50001 =>
      theme.textTheme.bodySmall!.jUSTSans.copyWith(
        color: appTheme.gray50001,
        fontSize: 12.fSize,
      );
  static get bodySmallJUSTSansPrimaryContainer =>
      theme.textTheme.bodySmall!.jUSTSans.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 12.fSize,
      );
  static get bodySmallOnError => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onError,
        fontSize: 12.fSize,
      );
  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 10.fSize,
      );
  static get bodySmallPrimary12 => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 12.fSize,
      );
  // Display text style
  static get displaySmallPrimaryContainer =>
      theme.textTheme.displaySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 35.fSize,
      );
  // Headline text style
  static get headlineMediumInterBlack90001 =>
      theme.textTheme.headlineMedium!.inter.copyWith(
        color: appTheme.black90001,
        fontWeight: FontWeight.w700,
      );
  static get headlineMediumInterBlack90001Bold =>
      theme.textTheme.headlineMedium!.inter.copyWith(
        color: appTheme.black90001,
        fontSize: 28.fSize,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallInterBlack90001 =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: appTheme.black90001,
      );
  static get headlineSmallInterPrimary =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );
  // Inter text style
  static get interGreenA700 => TextStyle(
        color: appTheme.greenA700,
        fontSize: 7.fSize,
        fontWeight: FontWeight.w600,
      ).inter;
  // J text style
  static get jUSTSansPrimaryContainer => TextStyle(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 7.fSize,
        fontWeight: FontWeight.w400,
      ).jUSTSans;
  // Label text style
  static get labelLargePrimaryContainer => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 13.fSize,
      );
  static get labelMediumBlack90001 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.black90001,
        fontWeight: FontWeight.w700,
      );
  static get labelMediumPrimaryContainer =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontWeight: FontWeight.w700,
      );
  static get labelSmallBlack90001 => theme.textTheme.labelSmall!.copyWith(
        color: appTheme.black90001,
        fontSize: 9.fSize,
      );
  static get labelSmallGreenA700 => theme.textTheme.labelSmall!.copyWith(
        color: appTheme.greenA700,
      );
  // Title text style
  static get titleLargeExtraBold => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w800,
      );
  static get titleLargeInterBlack90001 =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: appTheme.black90001,
        fontSize: 20.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleLargeInterBlack90001Bold =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: appTheme.black90001,
        fontSize: 23.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static get titleMediumGray50003 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray50003,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleMediumPrimarySemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallBlack90001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black90001,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallBlack90001Bold => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black90001,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallGray500 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray500,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get jUSTSans {
    return copyWith(
      fontFamily: 'JUST Sans',
    );
  }
}
