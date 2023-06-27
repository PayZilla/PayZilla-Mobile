import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';

class AppTheme {
  AppTheme._();

  static ThemeData _baseTheme(BuildContext context) => ThemeData(
        primaryColor: AppColors.payZillaPurple,
        indicatorColor: AppColors.payZillaPurple,
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
              borderRadius: Corners.xsBorder,
            ),
            backgroundColor: AppColors.payZillaPurple,
            foregroundColor: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.scaffold,
          selectedItemColor: AppColors.payZillaPurple,
          unselectedItemColor: AppColors.grey,
          type: BottomNavigationBarType.fixed,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.payZillaPurple,
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
          backgroundColor: AppColors.payZillaPurple,
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
          buttonColor: AppColors.payZillaPurple,
          textTheme: ButtonTextTheme.accent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: Insets.dim_8,
            horizontal: Insets.dim_10,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Insets.dim_6),
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderErrorColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Insets.dim_6),
            borderSide: const BorderSide(
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
