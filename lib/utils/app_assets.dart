import 'package:hanouty/settings/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  static const String logo = 'assets/icons/logo.svg';
  // static const String logor = 'assets/icons/logo_r.svg';
  // static const String logoc = 'assets/icons/logo_c.svg';
  // static const String splashLeft = 'assets/svgs/splash1.svg';
  static const String splashLeftPng = 'assets/svgs/splash.png';
  static final Widget logoTm = SvgPicture.asset(
    logo,
    color: MThemeData.primaryColor,
    semanticsLabel: 'Corp Logo',
  );
  static const String assetName = 'assets/images/logo.svg';
  static const String google = 'assets/images/google.svg';
  static const String pinkCircle = 'assets/images/pinkball.png';
  static const String purpleCircle = 'assets/images/purpleball.png';
  static const String blueCircle = 'assets/images/blueball.png';
  ////////////////////////////////////////////////////////////////////////////////
  static final Widget svgIcon = SvgPicture.asset(assetName,
      semanticsLabel: 'app logo', width: 100, height: 100);
  static final Widget googleSvgIcon = SvgPicture.asset(google,
      semanticsLabel: 'google icon', width: 24, height: 24);

  static final Widget pinkCircleWidget = Image.asset(pinkCircle,
      semanticLabel: 'A circle', width: 100, height: 100);

  static final Widget purpleCircleWidget = Image.asset(purpleCircle,
      semanticLabel: 'A cirle', width: 100, height: 100);

  static final Widget blueCircleWidget = Image.asset(blueCircle,
      semanticLabel: 'A circle', width: 100, height: 100);
  // static final Widget logoC = SvgPicture.asset(logoc,
  //     semanticsLabel: 'Corp Logo', cacheColorFilter: true);
  // static final Widget svgCircle = SvgPicture.asset(splashLeft,
  //     semanticsLabel: 'Corp Logo',
  //     width: 160,
  //     height: 160,
  //     cacheColorFilter: true);
}
