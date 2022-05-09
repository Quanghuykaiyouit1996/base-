import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: const Color(0xFF16154E),
  primaryColorDark: const Color(0xFFD78E00),
  primaryColorLight: const Color(0xFF454388),
  disabledColor: const Color(0xFFAAB1C5),
  hintColor: const Color(0xFF797C8D),
  backgroundColor: const Color(0xFFF5F8FD),
  // fontFamily: 'Lato',

  primaryTextTheme: const TextTheme(
    headline2: TextStyle(fontSize: 17, color: Color(0xFF16154E)),
    headline3: TextStyle(color: Color(0xFF16154E)),
    headline4: TextStyle(color: Color(0xFF16154E)),
    headline1: TextStyle(color: Color(0xFF16154E)),
    headline5: TextStyle(fontSize: 12.0, color: Color(0xFF16154E)),
    headline6: TextStyle(fontSize: 12, color: Color(0xFF16154E)),
    subtitle1: TextStyle(
        fontSize: 14.0, letterSpacing: -0.0041, color: Color(0xFF16154E)),
    subtitle2: TextStyle(
        fontSize: 12.0, letterSpacing: -0.0041, color: Color(0xFF16154E)),
    bodyText1: TextStyle(fontSize: 12.0, color: Color(0xFF16154E)),
    bodyText2: TextStyle(fontSize: 10.0, color: Color(0xFF16154E)),
  ),
  textTheme: const TextTheme(
    headline2: TextStyle(fontSize: 20.0, color: Color(0xFF16154E)),
    headline3: TextStyle(fontSize: 22.0, color: Color(0xFF16154E)),
    headline4: TextStyle(fontSize: 14.0, color: Color(0xFF16154E)),
    headline1: TextStyle(fontSize: 38.0, color: Color(0xFF16154E)),
    headline5: TextStyle(fontSize: 12.0, color: Color(0xFF16154E)),
    headline6: TextStyle(fontSize: 10.0, color: Color(0xFF16154E)),
    subtitle1: TextStyle(fontSize: 12.0, letterSpacing: -0.0041),
    bodyText1: TextStyle(fontSize: 17.0, color: Color(0xFF16154E)),
    bodyText2: TextStyle(fontSize: 12.0, color: Color(0xFF16154E)),
  ),
  iconTheme: const IconThemeData(color: Color(0xFF9D9BC9)),
  appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(color: Color(0xFF9D9BC9)),
    iconTheme: IconThemeData(color: Color(0xFF9D9BC9)),
    titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w600,
        fontSize: 17,
        height: 26 / 17,
        fontFamily:
            'Lato'), // backwardsCompatibility = true (auto) -> * widget.textTheme?.headline6 -> appBarTheme.textTheme?.headline6 -> theme.primaryTextTheme.headline6
    backgroundColor: Color(0xFF16154E),
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      statusBarColor: Color(0xFF9D9BC9),
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ), // dùng set brightness khi backwardsCompatibility = false
    // dùng set brightness khi backwardsCompatibility = true
  ),
  applyElevationOverlayColor: false,
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF9F2029),
    minWidth: 0,
  ),
);
