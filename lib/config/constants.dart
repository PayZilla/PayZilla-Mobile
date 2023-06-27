import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';

const kAmpInstanceName = 'PayZilla';
const androidId = 'com.payzilla.PayZilla';
const iOSId = 'com.payzilla.PayZilla';
const kFontFamily = 'Roboto';
const kAnimationDuration = Duration(milliseconds: 200);
const String kLanguage = 'en';
const String kRegionLocation = 'NG';

class CacheKeys {
  static const user = 'user';
  static const token = 'accessToken';
  static const email = 'user_email';
  static const password = 'user_password';
  static const phoneNumber = 'user_phone_number';
  static const biometric = 'biometric';

  static const biometricMode = 'biometric_mode';

  static const showVerificationBanner = 'show_verification_banner';
}

class AppColors {
  static const scaffold = Color(0xffFBFBFE);
  static const payZillaPurple = Color(0xFF7165E3);
  static const btnSecondaryColor = Color(0xff9EA6BE);
  static const iconColor = Color(0xFF1A1A1A);
  static const textHeaderColor = Color(0xFF333D47);
  static const textBodyColor = Color(0xFF6C7884);
  static const deeperDark = Color(0xFF111418);
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFF676D7E);
  static const borderErrorColor = Color(0xFFDC3030);
  static Color borderColor = const Color(0xFF9DA2A0).withOpacity(0.5);
  static const orangeColor = Color(0xffF97066);
}

class Corners {
  static const Radius rsRadius = Radius.circular(Insets.dim_4); //really small
  static const BorderRadius rsBorder =
      BorderRadius.all(rsRadius); //really small

  static const Radius xsRadius = Radius.circular(Insets.dim_8);
  static const BorderRadius xsBorder = BorderRadius.all(xsRadius);

  static const Radius smRadius = Radius.circular(Insets.dim_12);
  static const BorderRadius smBorder = BorderRadius.all(smRadius);

  static const Radius mdRadius = Radius.circular(Insets.dim_16);
  static const BorderRadius mdBorder = BorderRadius.all(mdRadius);

  static const Radius lgRadius = Radius.circular(Insets.dim_32);
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);

  static const Radius xlRadius = Radius.circular(50);
  static const BorderRadius xlBorder = BorderRadius.all(xlRadius);
}

class Dims {
  const Dims._();
  // the app was designed on an iphone frame with w:h = 428:926
  static Size designSize = const Size(428, 926);
  // the device [running the application] size
  static late Size deviceSize;

  // used to set the deviceSize during the application startup process
  static void setSize(MediaQueryData media) {
    deviceSize = Size(
      // media.size.width - (media.padding.left + media.padding.right),
      // media.size.height - (media.padding.top + media.padding.bottom),
      media.size.width,
      media.size.height,
    );
  }

  // naive implementation
  static double quotient(double dim1, double dim2) {
    return dim1 > dim2 ? dim1 / dim2 : dim2 / dim1;
  }

  @Deprecated(
    'use [this.dx] || [this.dxPercent], [this.dy] || [this.dyPercent] or [this.sp]',
  )
  // naive implementation, use [this.dx], [this.dy] or [this.sp] instead
  static double space(double x) {
    final deviceRatio = quotient(deviceSize.height, deviceSize.width);
    final designRatio = quotient(designSize.height, designSize.width);
    final ratio = deviceRatio / designRatio;

    return ratio * x;
  }

  // horizontal[width] quotient
  static double dxQuotient() {
    final quotient = deviceSize.width / designSize.width;

    return quotient;
  }

  // vertical[height] quotient
  static double dyQuotient() {
    final quotient = deviceSize.height / designSize.height;

    return quotient;
  }

  // give horizontal[width] spacing in percentages in respect to device width
  static double dxPercent(num extent) {
    return deviceSize.width * extent;
  }

  // give vertical[height] spacing in percentages in respect to device height
  static double dyPercent(num extent) {
    return deviceSize.height * extent;
  }

  // give responsive horizontal spacing [value is calculated based on device size and design size]
  static double dx(num x) {
    final quotient = dxQuotient();

    return quotient * x;
  }

  // give responsive vertical spacing [value is calculated based on device size and design size]
  static double dy(num x) {
    final quotient = dyQuotient();

    return quotient * x;
  }

  // give responsive font sizes [based on device size and design size]
  static double sp(num x) {
    final dxQ = dxQuotient();
    final dyQ = dyQuotient();
    final ratio = min(dxQ, dyQ);

    return ratio * x;
  }
}

extension DimsExtension on num {
  // horizontal spacing
  double get dx => Dims.dx(this);
  // vertical spacing
  double get dy => Dims.dy(this);
  // vertical spacing [in percentage]
  double get dyPercent => Dims.dyPercent(this);
  // horizontal spacing [in percentage]
  double get dxPercent => Dims.dxPercent(this);
  // font size
  double get sp => Dims.sp(this);
}

class XBox extends StatelessWidget {
  const XBox(this._width, {Key? key}) : super(key: key);

  final double _width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width.dx,
    );
  }
}

class YBox extends StatelessWidget {
  const YBox(this._height, {Key? key}) : super(key: key);

  final double _height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height.dy,
    );
  }
}
