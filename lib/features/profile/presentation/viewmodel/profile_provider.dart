import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider(this.profileRepository, this.authProvider);

  final ProfileRepository profileRepository;
  final AuthProvider authProvider;

  bool _profileLoader = false;
  bool get profileLoader => _profileLoader;
  set profileLoader(bool val) {
    _profileLoader = val;
    notifyListeners();
  }

  ApiResult<User> userProfileUpdate = ApiResult<User>.idle();

  // cloud upload file
  Future<void> uploadImage(String imgPath) async {
    _profileLoader = true;
    notifyListeners();
    final failureOrImageUrl =
        await CloudImageManager.instance.uploadFile(File(imgPath));
    await failureOrImageUrl.fold(
      (failure) {
        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) async {
        await payUploadImage(res);
        notifyListeners();
      },
    );
    _profileLoader = false;

    notifyListeners();
  }

  // pay zilla upload
  Future<void> payUploadImage(String imgPath) async {
    final failureOrImageUrl = await profileRepository.uploadImage(imgPath);
    await failureOrImageUrl.fold(
      (failure) {
        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) async {
        if (res) {
          await authProvider.getUser();
          notifyListeners();
        }
      },
    );
    notifyListeners();
  }

  // pay zilla profile update
  Future<void> profileUpdate(AuthParams params) async {
    userProfileUpdate = ApiResult<User>.idle();
    userProfileUpdate = ApiResult<User>.loading('Loading...');
    notifyListeners();
    final failureOrProfile = await profileRepository.updateProfile(params);
    await failureOrProfile.fold(
      (failure) {
        showErrorNotification(failure.message, durationInMills: 2000);
        userProfileUpdate = ApiResult<User>.error(failure.message);
        notifyListeners();
      },
      (res) async {
        await authProvider.getUser();
        showSuccessNotification('Profile updated successfully');
        userProfileUpdate = ApiResult<User>.success(res);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  //create the profile widget data
  final profileWidget = [
    ProfileWidgetData(
      title: 'Referral Code',
      asset: referralSvg,
      todo: (context) => AppNavigator.of(context).push(AppRoutes.referral),
    ),
    ProfileWidgetData(
      title: 'Account Info',
      asset: accountInfoSvg,
      todo: (context) => AppNavigator.of(context).push(AppRoutes.accountInfo),
    ),
    ProfileWidgetData(
      title: 'Contact List',
      asset: contactListSvg,
      todo: (context) => AppNavigator.of(context).push(AppRoutes.contact),
    ),
    ProfileWidgetData(
      title: 'Language',
      asset: languageSvg,
      todo: (context) {
        Log().debug('Language');
      },
    ),
    ProfileWidgetData(
      title: 'General Setting',
      asset: generalSvg,
      todo: (context) => AppNavigator.of(context).push(AppRoutes.general),
    ),
    ProfileWidgetData(
      title: 'Change Password',
      asset: passwordSvg,
      todo: (context) {
        Log().debug('Change Password');
      },
    ),
    ProfileWidgetData(
      title: 'FAQ',
      asset: passwordSvg,
      todo: (context) => AppNavigator.of(context).push(AppRoutes.faq),
    ),
  ];
}

class ProfileWidgetData {
  ProfileWidgetData({
    required this.title,
    required this.asset,
    required this.todo,
  });

  final String title;
  final String asset;
  final Function(BuildContext context)? todo;
}
