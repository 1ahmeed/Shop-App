

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
      backgroundColor:  HexColor('333739'),
      titleSpacing: 20.0,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: HexColor('333739'),
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333739'),
    ),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,

        )
    ), colorScheme: ColorScheme.fromSwatch(primarySwatch: defaultColor).copyWith(background: HexColor('333739'))
);

ThemeData lightTheme= ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor:Colors.white,
    appBarTheme: const AppBarTheme(
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        )
    )
);