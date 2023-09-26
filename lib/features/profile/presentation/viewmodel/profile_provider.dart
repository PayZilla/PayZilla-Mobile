import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider(
    this.profileRepository,
    this.authProvider,
    this.accountRepository,
  );

  final ProfileRepository profileRepository;
  final AuthProvider authProvider;
  final AccountRepository accountRepository;

  bool _profileLoader = false;
  bool get profileLoader => _profileLoader;
  set profileLoader(bool val) {
    _profileLoader = val;
    notifyListeners();
  }

  ApiResult<User> userProfileUpdate = ApiResult<User>.idle();
  ApiResult<List<ContactsModel>> contactsResponse =
      ApiResult<List<ContactsModel>>.idle();

  ApiResult<List<FAQsModel>> faqResponse = ApiResult<List<FAQsModel>>.idle();

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

  Future<void> getContacts(List<String> contacts) async {
    contactsResponse = ApiResult<List<ContactsModel>>.loading('Loading...');
    notifyListeners();
    final failureOrCat = await accountRepository.getContacts(contacts);
    failureOrCat.fold(
      (failure) {
        contactsResponse =
            ApiResult<List<ContactsModel>>.error(failure.message);
        notifyListeners();
      },
      (res) {
        contactsResponse = ApiResult<List<ContactsModel>>.success(res);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> getFAQs() async {
    faqResponse = ApiResult<List<FAQsModel>>.loading('Loading...');
    notifyListeners();
    final failureOrCat = await profileRepository.getFAQs();
    failureOrCat.fold(
      (failure) {
        faqResponse = ApiResult<List<FAQsModel>>.error(failure.message);
        notifyListeners();
      },
      (res) {
        faqResponse = ApiResult<List<FAQsModel>>.success(res);
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
        showInfoNotification(
          'Only English is supported for now',
          durationInMills: 2000,
        );
      },
    ),
    ProfileWidgetData(
      title: 'General Setting',
      asset: generalSvg,
      todo: (context) => AppNavigator.of(context).push(AppRoutes.general),
    ),
    ProfileWidgetData(
      title: 'FAQ',
      asset: faqSvg,
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
