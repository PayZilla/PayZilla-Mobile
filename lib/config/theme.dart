import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';

class AppTheme {
  AppTheme._();

  static ThemeData _baseTheme(BuildContext context) => ThemeData(
        primaryColor: AppColors.btnPrimaryColor,
        indicatorColor: AppColors.btnPrimaryColor,
        scaffoldBackgroundColor: AppColors.scaffold,
        fontFamily: Fonts.gilroy,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              vertical: Insets.dim_8,
              horizontal: Insets.dim_12,
            ),
            shadowColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: Corners.mdBorder,
            ),
            backgroundColor: AppColors.btnPrimaryColor,
            foregroundColor: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.scaffold,
          selectedItemColor: AppColors.btnPrimaryColor,
          unselectedItemColor: AppColors.grey,
          type: BottomNavigationBarType.fixed,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.btnPrimaryColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Insets.dim_10),
              ),
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.btnPrimaryColor,
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontFamily: Fonts.gilroy,
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: AppColors.scaffold,
          elevation: 0,
          centerTitle: false,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.btnPrimaryColor,
          textTheme: ButtonTextTheme.accent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color(0xFFF9FAFB),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: Insets.dim_8,
            horizontal: Insets.dim_10,
          ),
          border: OutlineInputBorder(
            borderRadius: Corners.mdBorder,
            borderSide: BorderSide(color: AppColors.borderColor, width: 0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: Corners.mdBorder,
            borderSide: BorderSide(
              color: Color(0xFFF9FAFB),
              width: 0,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderErrorColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: Corners.mdBorder,
            borderSide: BorderSide(
              color: AppColors.grey,
            ),
          ),
          labelStyle: TextStyle(color: AppColors.borderColor),
          hintStyle: TextStyle(color: AppColors.borderColor),
        ),
      );

  static ThemeData defaultTheme(BuildContext context) =>
      _baseTheme(context).copyWith(brightness: Brightness.light);
}

class Fonts {
  static const gilroy = 'Gilroy';
}
