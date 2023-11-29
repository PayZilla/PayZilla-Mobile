import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/di/dependency_injection_container.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/auth/usecase/user_usecase.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/dashboard/usecase/acount_usecases.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/profile/usecase/profile_usecase.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider(
    this.uploadImageUseCase,
    this.updateProfileUseCase,
    this.getFaqsUseCase,
    this.getUserUseCase,
    this.getContactsUseCase,
  );

  final UploadImageUseCase uploadImageUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final GetFaqsUseCase getFaqsUseCase;
  final GetUserUseCase getUserUseCase;
  final GetContactsUseCase getContactsUseCase;

  bool _profileLoader = false;
  bool get profileLoader => _profileLoader;
  set profileLoader(bool val) {
    _profileLoader = val;
    notifyListeners();
  }

  List<Contact>? _fetchedContacts;
  List<Contact>? get fetchedContacts => _fetchedContacts;
  set fetchedContacts(List<Contact>? val) {
    _fetchedContacts = val;
    notifyListeners();
  }

  List<Contact>? _searchedContacts;
  List<Contact>? get searchedContacts => _searchedContacts;
  set searchedContacts(List<Contact>? val) {
    _searchedContacts = val;
    notifyListeners();
  }

  bool _permissionDenied = false;
  bool get permissionDenied => _permissionDenied;
  set permissionDenied(bool val) {
    _permissionDenied = val;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool val) {
    _loading = val;
    notifyListeners();
  }

  ApiResult<User> userProfileUpdate = ApiResult<User>.idle();
  ApiResult<List<ContactsModel>> contactsResponse =
      ApiResult<List<ContactsModel>>.idle();

  ApiResult<List<FAQsModel>> faqResponse = ApiResult<List<FAQsModel>>.idle();

  // cloud upload file
  Future<void> uploadImage(String imgPath, BuildContext context) async {
    _profileLoader = true;
    notifyListeners();
    final failureOrImageUrl =
        await CloudImageManager.instance.uploadFile(File(imgPath));
    await failureOrImageUrl.fold(
      (failure) {
        showErrorNotification(context, failure.message, durationInMills: 2000);
        notifyListeners();
      },
      (res) async {
        await payUploadImage(res, context);
        notifyListeners();
      },
    );
    _profileLoader = false;

    notifyListeners();
  }

  // pay zilla upload
  Future<void> payUploadImage(String imgPath, BuildContext context) async {
    final failureOrImageUrl = await uploadImageUseCase.call(imgPath);
    await failureOrImageUrl.fold(
      (failure) {
        showErrorNotification(context, failure.message, durationInMills: 2000);
        notifyListeners();
      },
      (res) async {
        if (res) {
          await getUserUseCase.call(NoParams());
          notifyListeners();
        }
      },
    );
    notifyListeners();
  }

  // pay zilla profile update
  Future<void> profileUpdate(AuthParams params, BuildContext context) async {
    userProfileUpdate = ApiResult<User>.idle();
    userProfileUpdate = ApiResult<User>.loading('Loading...');
    notifyListeners();
    final failureOrProfile = await updateProfileUseCase.call(params);
    await failureOrProfile.fold(
      (failure) {
        showErrorNotification(context, failure.message, durationInMills: 2000);
        userProfileUpdate = ApiResult<User>.error(failure.message);
        notifyListeners();
      },
      (res) async {
        showSuccessNotification(
          context,
          'Profile updated successfully',
        );
        sl<IAuthLocalDataSource>().saveAuthUserPref(res);

        userProfileUpdate = ApiResult<User>.success(res);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> getContacts(List<String> contacts) async {
    contactsResponse = ApiResult<List<ContactsModel>>.loading('Loading...');
    notifyListeners();
    final failureOrCat = await getContactsUseCase.call(contacts);
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
    final failureOrCat = await getFaqsUseCase.call(NoParams());
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

  // get contacts

  Future fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      permissionDenied = true;
      notifyListeners();
    } else {
      loading = true;
      notifyListeners();

      final contacts = await FlutterContacts.getContacts(withProperties: true);
      fetchedContacts = contacts;
      _searchedContacts = fetchedContacts;
      loading = false;
      notifyListeners();
    }
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
          context,
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

  Future<void> logOut(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Insets.dim_16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: SizedBox(
          height: context.getHeight(0.2),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.dim_32,
              vertical: Insets.dim_32,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Are you sure ?',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 0.30,
                  ),
                ),
                const YBox(Insets.dim_26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'No',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: AppColors.textHeaderColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ),
                    ),
                    const XBox(Insets.dim_32),
                    Expanded(
                      child: AppSolidButton(
                        textTitle: 'Continue',
                        showLoading: loading,
                        backgroundColor: AppColors.borderErrorColor,
                        action: () {
                          Navigator.pop(context, true);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ).then((value) async {
      if (value != null && value) {}
    });
  }
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
