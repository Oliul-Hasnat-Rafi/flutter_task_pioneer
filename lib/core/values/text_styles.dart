import 'package:flutter/material.dart';
import '../app_context.dart';
import 'app_colors.dart';

const primaryColorSubtitleStyle = TextStyle(
  fontSize:
      14,
  fontWeight:
      FontWeight.w400,
  color:  Color(
    0xFF1F2937,
  ),
  height:
      1.45,
);

const whiteText16 = TextStyle(
  fontSize:
      16,
  fontWeight:
      FontWeight.w400,
  color:
      Colors.white,
);

const whiteText12 = TextStyle(
  fontSize:
      13,
  fontWeight:
      FontWeight.w400,
);
const whiteText18 = TextStyle(
  fontSize:
      18,
  fontWeight:
      FontWeight.w400,
  color:
      Colors.white,
);

const whiteText32 = TextStyle(
  fontSize:
      32,
  fontWeight:
      FontWeight.w400,
  color:
      Colors.white,
);

const labelStyle = TextStyle(
  fontSize:
      18,
  fontWeight:
      FontWeight.w400,
  height:
      1.8,
);

final labelStyleAppPrimaryColor = labelStyle.copyWith(
  color:
      AppColors.colorPrimary,
  height:
      1,
);

final labelStyleGrey = labelStyle.copyWith(
  fontWeight:
      FontWeight.w600,
  fontSize:
      15,
  color: const Color(
    0xFF323232,
  ).withAlpha(
    128, // 0.5 opacity = 128/255
  ),
);

const labelStyleWhite = TextStyle(
  fontSize:
      18,
  fontWeight:
      FontWeight.w400,
  height:
      1.8,
  color:
      Colors.white,
);

const cardTitleCyanStyle = TextStyle(
  fontSize:
      20,
  fontWeight:
      FontWeight.w500,
  color:
      AppColors.colorPrimary,
);

const titleStyle = TextStyle(
  fontSize:
      18,
  fontWeight:
      FontWeight.w500,
  height:
      1.34,
);

const settingsItemStyle = TextStyle(
  fontSize:
      16,
  fontWeight:
      FontWeight.w400,
);

const appBarActionTextStyle = TextStyle(
  fontSize:
      16,
  fontWeight:
      FontWeight.w600,
  color:
      AppColors.colorPrimary,
);

const extraBigTitleStyle = TextStyle(
  fontSize:
      40,
  fontWeight:
      FontWeight.w600,
  height:
      1.12,
);

const bigTitleStyle = TextStyle(
  fontWeight:
      FontWeight.w500,
  height:
      1.15,
  color:
      Colors.black,
);

const mediumTitleStyle = TextStyle(
  fontSize:
      24,
  fontWeight:
      FontWeight.w500,
  height:
      1.15,
  color: Color(
    0xFF9CA3AF,
  ),
);

const descriptionTextStyle = TextStyle(
  fontSize:
      16,
);

const bigTitleWhiteStyle = TextStyle(
  fontSize:
      28,
  fontWeight:
      FontWeight.w700,
  height:
      1.15,
  color:
      Colors.white,
);

const boldTitleStyle = TextStyle(
  fontSize:
      18,
  fontWeight:
      FontWeight.w700,
  height:
      1.34,
);

const boldTitleWhiteStyle = TextStyle(
  fontSize:
      18,
  fontWeight:
      FontWeight.w700,
  height:
      1.34,
  color:
      Colors.white,
);
const errorTextStyle = TextStyle(
  fontSize:
      12,
  color:
      Colors.red,
);

final boldTitlePrimaryColorStyle = boldTitleStyle.copyWith(
  color:
      Theme.of(
        AppContext.context,
      ).canvasColor,
);
