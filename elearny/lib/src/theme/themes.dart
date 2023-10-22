import 'package:elearny/data/globales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static const defaultElevation = 2.5;

  static const green = Color(0xff079561);
  static const hintColor = Color(0xFF555555);
  static const grey = Color(0xff8E8EA9);
  static const white = Color(0xffffffff);
  static const whiteGrey = Color(0xffFCFCFC);
  static const greyWhite = Color(0xffF7F7F7);
  static const black = Color(0xff000000);
  static const darkMode = Color(0xff1F222A);
  static const darkMode2 = Color(0xff1D1D1D);
  static const darkMode3 = Color(0xff1D1627);
  static const splashColorgreen = Color.fromARGB(75, 7, 149, 97);
  static const fillColorLight = Color(0xffF3F3F3);
  static const fillColorDark = Color(0xff1F222A);
  static const inActivegreenColor = Color.fromARGB(35, 0, 107, 142);
  static const inActiveYellowColor = Color.fromARGB(35, 255, 199, 44);

  //LightMode
  static final ThemeData light = ThemeData(
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: black,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 30
                : 26
            : 34,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
      //main textstyle
      bodyMedium: TextStyle(
        color: black,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        color: whiteGrey,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 16
                : 12
            : 20,
        fontFamily: 'Poppins',
      ),
      displayLarge: TextStyle(
        color: black,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      displayMedium: TextStyle(
        color: grey,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        color: black,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      titleSmall: TextStyle(
        color: whiteGrey,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      titleMedium: TextStyle(
        color: black,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      titleLarge: TextStyle(
        color: green,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      labelLarge: TextStyle(
        color: const Color(0xff32324D),
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      labelMedium: TextStyle(
        color: whiteGrey,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle(
        color: white,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      headlineLarge: TextStyle(
        color: inActivegreenColor,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
    ),

    //brightness
    //brightness: Brightness.light,
    brightness: Brightness.light,

    //bottomAppBarColor
    bottomAppBarTheme: const BottomAppBarTheme(
      color: whiteGrey,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: white,
        selectedIconTheme:
            IconThemeData(color: Color.fromARGB(255, 102, 102, 102)),
        unselectedItemColor: Color.fromARGB(255, 102, 102, 102)),

    //Splash Color for press
    splashColor: splashColorgreen,

    //floating Action Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: green,
    ),

    //AppBarTheme
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: green),
        titleTextStyle: TextStyle(color: black, fontWeight: FontWeight.bold)),

    //scaffoldBackgroundColor
    scaffoldBackgroundColor: whiteGrey,

    //listTileTheme
    listTileTheme: const ListTileThemeData(textColor: black),

    //iconTheme
    iconTheme: const IconThemeData(color: green),

    //checkboxTheme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(whiteGrey),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      checkColor: MaterialStateProperty.all(
        const Color(0xff8E8EA9),
      ),
      side: MaterialStateBorderSide.resolveWith(
        (states) => const BorderSide(
          width: 1.0,
          color: Color(0xff8E8EA9),
        ),
      ),
    ),

    //chipTheme
    chipTheme: const ChipThemeData(
        labelStyle: TextStyle(color: black),
        deleteIconColor: green,
        backgroundColor: white,
        side: BorderSide(width: 0.5, color: grey)),

    //radioTheme
    radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => green)),

    //OutlinedButtonThemeData
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: green,
            backgroundColor: white,
            side: const BorderSide(width: 1.4, color: green),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))))),

    //progressIndicatorTheme
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: green),

    //elevatedButtonTheme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // side: const BorderSide(width: 1, color: green),
      ),
    ),

    //dialogTheme
    dialogTheme: DialogTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: white),

    //cardTheme
    cardTheme: CardTheme(
      color: white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),

    //textButtonTheme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          //  textStyle: const TextStyle(fontSize: 16),
          foregroundColor: green),
    ),

    //bottmSheetTheme
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: white.withOpacity(0)),

    //snackBarTheme
    snackBarTheme: const SnackBarThemeData(
      elevation: defaultElevation,
      backgroundColor: green,
      contentTextStyle: TextStyle(
        //  fontSize: 20,
        color: white,
      ),
      behavior: SnackBarBehavior.floating,
    ),

    //border ,cursor theme
    textSelectionTheme: const TextSelectionThemeData(cursorColor: black),
    inputDecorationTheme: InputDecorationTheme(
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: grey,
            width: 0.25,
          ),
          borderRadius: BorderRadius.circular(15.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: grey,
            width: 0.25,
          ),
          borderRadius: BorderRadius.circular(15.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: grey,
            width: 0.25,
          ),
          borderRadius: BorderRadius.circular(15.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: grey,
            width: 0.25,
          ),
          borderRadius: BorderRadius.circular(15.0)),
      suffixIconColor: green,
      labelStyle: const TextStyle(
        color: green,
      ),
      filled: true,
      fillColor: white,
    ),
  );

//DarkMode

  static final ThemeData dark = ThemeData(
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: white,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 30
                : 26
            : 34,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        color: white,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        color: black,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      displayLarge: TextStyle(
        color: white,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      displayMedium: TextStyle(
        color: grey,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        color: white,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      titleSmall: TextStyle(
        color: darkMode,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      titleMedium: TextStyle(
        color: white,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      titleLarge: TextStyle(
        color: green,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
      labelLarge: TextStyle(
          color: white,
          fontFamily: 'Poppins',
          fontSize: deviceType != 1
              ? deviceType == 2
                  ? 20
                  : 16
              : 24),
      labelMedium: TextStyle(
          color: black,
          fontFamily: 'Poppins',
          fontSize: deviceType != 1
              ? deviceType == 2
                  ? 20
                  : 16
              : 24),
      labelSmall: TextStyle(
          color: darkMode,
          fontFamily: 'Poppins',
          fontSize: deviceType != 1
              ? deviceType == 2
                  ? 20
                  : 16
              : 24),
      headlineLarge: TextStyle(
        color: inActiveYellowColor,
        fontSize: deviceType != 1
            ? deviceType == 2
                ? 20
                : 16
            : 24,
        fontFamily: 'Poppins',
      ),
    ),

    //brightness
    brightness: Brightness.dark,

    //bottomAppBarColor
    bottomAppBarTheme: const BottomAppBarTheme(
      color: darkMode,
    ),

    //bottomNavigationBarTheme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: darkMode,
        selectedIconTheme: IconThemeData(color: grey),
        unselectedItemColor: grey),

    //Splash Color for press
    splashColor: splashColorgreen,

    //floating Action Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: green, foregroundColor: black),

    //AppBarTheme
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: green),
        titleTextStyle: TextStyle(
            color: white,
            // fontSize: 22,

            fontWeight: FontWeight.bold)),

    //scaffoldBackgroundColor
    scaffoldBackgroundColor: black,

    //iconTheme
    iconTheme: const IconThemeData(color: green),

    //listTileTheme
    listTileTheme: const ListTileThemeData(textColor: white),

    //hintColor
    hintColor: grey,
    //checkboxTheme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(black),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      checkColor: MaterialStateProperty.all(
        const Color(0xff8E8EA9),
      ),
      side: MaterialStateBorderSide.resolveWith(
        (states) => const BorderSide(
          width: 1.0,
          color: Color(0xff8E8EA9),
        ),
      ),
    ),

    //chipTheme
    chipTheme: const ChipThemeData(
        labelStyle: TextStyle(color: white),
        backgroundColor: black,
        deleteIconColor: green,
        side: BorderSide(width: 0.5, color: grey)),

    //radioTheme
    radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => green)),

    //OutlinedButtonThemeData
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: green,
            backgroundColor: black,
            side: const BorderSide(width: 1.4, color: green),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))))),

    // ProgressIndicatorTheme
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: green),

    //elevatedButtonTheme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: black,
        backgroundColor: green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // side: const BorderSide(width: 1, color: yellow),
      ),
    ),

    //dialogTheme
    dialogTheme: DialogTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: darkMode),

    //cardTheme
    cardTheme: CardTheme(
      color: darkMode,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),

    //textButtonTheme
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            //   textStyle: const TextStyle(fontSize: 16),
            foregroundColor: green)),

    //bottmSheetTheme
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: darkMode.withOpacity(0)),

    //snackBarTheme
    snackBarTheme: const SnackBarThemeData(
      elevation: defaultElevation,
      backgroundColor: green,
      contentTextStyle: TextStyle(
        //  fontSize: 20,
        color: black,
      ),
      behavior: SnackBarBehavior.floating,
    ),

    //border ,cursor theme
    textSelectionTheme: const TextSelectionThemeData(cursorColor: white),
    inputDecorationTheme: InputDecorationTheme(
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: grey,
            width: 0.25,
          ),
          borderRadius: BorderRadius.circular(15.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: grey,
            width: 0.25,
          ),
          borderRadius: BorderRadius.circular(15.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: grey,
            width: 0.25,
          ),
          borderRadius: BorderRadius.circular(15.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: grey,
            width: 0.25,
          ),
          borderRadius: BorderRadius.circular(15.0)),
      suffixIconColor: green,
      labelStyle: const TextStyle(
        color: green,
      ),
      filled: true,
      fillColor: darkMode,
    ),
  );
}
