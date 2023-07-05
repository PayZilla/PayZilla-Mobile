import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/data/core_data.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  final deBouncer = DeBouncer(milliseconds: 200);

  ApiResult<AuthResponseData> genericAuthResp =
      ApiResult<AuthResponseData>.idle();

  ApiResult<List<ReasonsModel>> reasonsResp =
      ApiResult<List<ReasonsModel>>.idle();

  PasswordValidationState passValidState = PasswordValidationState.initial();

  Future<void> login(AuthParams requestDto, BuildContext context) async {
    genericAuthResp = ApiResult<AuthResponseData>.loading('Logging in....');
    notifyListeners();

    final failureOrLogin = await authRepository.login(requestDto);
    await failureOrLogin.fold(
      (failure) {
        genericAuthResp = ApiResult<AuthResponseData>.error(failure.message);
        notifyListeners();

        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) async {
        if (res.getNextProfileUpdate) {
          //  navigate accordingly
        } else {
          await getUser(context);
        }
        AppNavigator.of(context).push(AppRoutes.biometric);

        genericAuthResp = ApiResult<AuthResponseData>.success(res);
        notifyListeners();
      },
    );
  }

  Future<void> getUser(BuildContext context) async {
    final failureOrUser = await authRepository.getUser();
    failureOrUser.fold(
      (failure) {
        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) {},
    );
  }

  void onChanged(String input) {
    passValidState = passValidState.copyWith(
      has8CharactersMin: Validators.hasMinCharacters(input),
      hasUpperCase: Validators.hasUpperCase(input),
      hasSpecialCharacter: Validators.hasSpecialCharacter(input),
      hasNumber: Validators.hasNumber(input),
    );
    notifyListeners();
  }

// Sign up
  Future<void> signUp(AuthParams requestDto) async {
    genericAuthResp = ApiResult<AuthResponseData>.loading('Signing up....');
    notifyListeners();

    final failureOrLogin = await authRepository.signUp(requestDto);
    failureOrLogin.fold(
      (failure) {
        genericAuthResp = ApiResult<AuthResponseData>.error(failure.message);
        notifyListeners();

        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) {
        genericAuthResp = ApiResult<AuthResponseData>.success(res);

        notifyListeners();
      },
    );
  }

// Get reasons
  Future<void> fetchReasons() async {
    reasonsResp = ApiResult<List<ReasonsModel>>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await authRepository.fetchReasons();
    failureOrLogin.fold(
      (failure) {
        reasonsResp = ApiResult<List<ReasonsModel>>.error(failure.message);

        notifyListeners();

        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) {
        reasonsResp = ApiResult<List<ReasonsModel>>.success(res);

        notifyListeners();
      },
    );
  }

  final reasonsList = <ReasonsModel>[
    ReasonsModel(
      title: 'Spend or save daily',
      image: r1,
    ),
    ReasonsModel(
      title: 'Fast my transactions',
      image: r2,
    ),
    ReasonsModel(
      title: 'Payments to friends',
      image: r3,
    ),
    ReasonsModel(
      title: 'Online payments',
      image: r4,
    ),
    ReasonsModel(
      title: 'Spend while traveling',
      image: r5,
    ),
    ReasonsModel(
      title: 'Your financial assets',
      image: r6,
    ),
  ];

  // get started button
  final registeringCountries = [
    CountryData(
      countryId: 'NG',
      countryName: 'Nigeria',
      currencyCode: 'NGN',
      flag: nigeriaSvg,
      slug: 'Nigerian',
      applicationType: 4,
      countryPhoneCode: '+234',
      maxLength: 11,
    ),
    CountryData(
      countryId: 'SG',
      countryName: 'Singapore',
      currencyCode: 'USD',
      flag: singaporeSvg,
      slug: 'Singapore',
      applicationType: 4,
      countryPhoneCode: '+234',
      maxLength: 11,
    ),
    CountryData(
      countryId: 'USA',
      countryName: 'United States America',
      currencyCode: 'USD',
      flag: usaSvg,
      slug: 'Americans',
      applicationType: 2,
      countryPhoneCode: '+911',
      maxLength: 10,
    ),
    CountryData(
      countryId: 'CH',
      countryName: 'China',
      currencyCode: 'YENG',
      flag: chinaSvg,
      slug: 'Chinese',
      applicationType: 4,
      countryPhoneCode: '+01',
      maxLength: 11,
    ),
    CountryData(
      countryId: 'NL',
      countryName: 'Netherlands',
      currencyCode: 'USD',
      flag: netherlandsSvg,
      slug: 'Netherlands',
      applicationType: 4,
      countryPhoneCode: '+044',
      maxLength: 11,
    ),
    CountryData(
      countryId: 'ID',
      countryName: 'Indonesia',
      currencyCode: 'USD',
      flag: indonesiaSvg,
      slug: 'Indonesia',
      applicationType: 4,
      countryPhoneCode: '+044',
      maxLength: 11,
    ),
  ];

  FutureBottomSheet<CountryData> showCountry({
    bool dismissible = true,
    void Function(CountryData)? onTap,
    required BuildContext context,
  }) {
    return FutureBottomSheet<CountryData>(
      future: () => Future.value(registeringCountries),
      height: context.getHeight(0.6),
      isDismissible: dismissible,
      searchWidget: SearchTextInputField(
        title: 'Search ',
        onChanged: onChanged,
      ),
      itemBuilder: (context, item) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            item.countryName.capitalize(),
            style: const TextStyle(fontSize: 15),
          ),
          leading: LocalSvgImage(
            item.flag,
            height: Insets.dim_24.dy,
            width: Insets.dim_24.dx,
          ),
          onTap: () {
            if (onTap == null) {
              countrySelected(item, context);
            } else {
              onTap(item);
              AppNavigator.of(context).popDialog();
            }
          },
        );
      },
    );
  }

  void countrySelected(CountryData country, BuildContext context) {
    AppNavigator.of(context)
      ..push(
        AppRoutes.countryToReasons,
      )
      ..popDialog();
    notifyListeners();
  }

  void sessionTimeout(String reason) {
    showErrorNotification(reason);
    authRepository.localDataSource.flushLocalStorage();
    notifyListeners();
  }

  void logout() {
    authRepository.localDataSource.flushLocalStorage();
    notifyListeners();
  }
}
