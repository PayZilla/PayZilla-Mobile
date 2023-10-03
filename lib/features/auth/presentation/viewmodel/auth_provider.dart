import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  final deBouncer = DeBouncer(milliseconds: 200);

  bool _showNavBar = false;
  bool get showNavBar => _showNavBar;
  set showNavBar(bool val) {
    _showNavBar = val;
    notifyListeners();
  }

  User _user = User.empty();
  User get user => _user;
  set user(User val) {
    _user = val;
    notifyListeners();
  }

  ApiResult<UserAuthModel> genericAuthResp = ApiResult<UserAuthModel>.idle();

  ApiResult<List<ReasonsModel>> reasonsResp =
      ApiResult<List<ReasonsModel>>.idle();

  ApiResult<String> onboardingResp = ApiResult<String>.idle();

  PasswordValidationState passValidState = PasswordValidationState.initial();

  Future<void> login(AuthParams requestDto, BuildContext context) async {
    genericAuthResp = ApiResult<UserAuthModel>.loading('Logging in....');
    notifyListeners();

    final failureOrLogin = await authRepository.login(requestDto);
    await failureOrLogin.fold(
      (failure) {
        genericAuthResp = ApiResult<UserAuthModel>.error(failure.message);
        notifyListeners();

        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) async {
        //1. Handle all conditions on login response first
        if (!res.user.hasVerifiedEmail) {
          final verificationMsg =
              'You have not verified either phone number (${res.user.phoneNumber}) or email (${res.user.email})';
          showInfoNotification(verificationMsg, durationInMills: 3500);
          genericAuthResp = ApiResult<UserAuthModel>.error(verificationMsg);
          notifyListeners();
          AppNavigator.of(context).push(
            AppRoutes.pin,
            args: GenericTokenVerificationArgs(
              res.user.email,
              AppRoutes.country,
              authEndpoints.emailVerificationVerify,
            ),
          );
          return;
        }
        if (!res.user.hasVerifiedPhoneNumber) {
          genericAuthResp = ApiResult<UserAuthModel>.error(
            'You have not verified phone number (${res.user.phoneNumber})',
          );
          showInfoNotification(genericAuthResp.message, durationInMills: 3500);
          notifyListeners();
          // ignore: use_build_context_synchronously
          AppNavigator.of(context).push(AppRoutes.country);
          return;
        }

        if (res.user.registrationPurpose.isEmpty) {
          genericAuthResp = ApiResult<UserAuthModel>.success(res);
          AppNavigator.of(context).push(AppRoutes.bvnToReasons);
          notifyListeners();
          return;
        }
        //2. Now handle user journey on kyc status

        await getKyc(context);

        genericAuthResp = ApiResult<UserAuthModel>.success(res);
        notifyListeners();
      },
    );
  }

  Future<void> getKyc(BuildContext context) async {
    final failureOrKYC = await authRepository.getKyc();

    await failureOrKYC.fold(
      (failure) {
        Log().debug('The KYC failed', failure.message);
      },
      (res) async {
        if (res.isEmpty) {
          AppNavigator.of(context).push(AppRoutes.countryToBvn);
        } else {
          await authRepository.canUseBiometric().then(
                (value) => {
                  if (value)
                    {AppNavigator.of(context).push(AppRoutes.biometric)}
                  else
                    {AppNavigator.of(context).push(AppRoutes.home)}
                },
              );
        }
      },
    );
  }

  Future<User> getUser() async {
    _user = User.empty();
    final failureOrUser = await authRepository.getUser();
    failureOrUser.fold(
      (failure) {
        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) {
        _user = res;
        notifyListeners();
      },
    );
    return user;
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
  Future<void> signUp(AuthParams requestDto, BuildContext context) async {
    genericAuthResp = ApiResult<UserAuthModel>.loading('Signing up....');
    notifyListeners();

    final failureOrLogin = await authRepository.signUp(requestDto);
    failureOrLogin.fold(
      (failure) {
        genericAuthResp = ApiResult<UserAuthModel>.error(failure.message);
        notifyListeners();

        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) {
        AppNavigator.of(context).push(
          AppRoutes.pin,
          args: GenericTokenVerificationArgs(
            res.user.email,
            AppRoutes.country,
            authEndpoints.emailVerificationVerify,
          ),
        );
        genericAuthResp = ApiResult<UserAuthModel>.success(res);

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

  Future<void> emailVerificationInitiate() async {
    onboardingResp = ApiResult<String>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await authRepository.emailVerificationInitiate();
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) {
        onboardingResp = ApiResult<String>.success(res);
        // Just so that the message from login can show and nothing spoils if this still comes from registration also :)
        Future.delayed(3500.milliseconds).then((value) {
          showSuccessNotification(
            onboardingResp.data ?? '',
            durationInMills: 2500,
          );
        });

        notifyListeners();
      },
    );
  }

  Future<void> tokenVerification(
    AuthParams params,
    BuildContext context,
    String routerPath, {
    required String endpointPath,
  }) async {
    onboardingResp = ApiResult<String>.idle();
    onboardingResp = ApiResult<String>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await authRepository.tokenVerification(
      params,
      path: endpointPath,
    );
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) {
        onboardingResp = ApiResult<String>.success(res);
        // attach the params to the router for reset password screen
        AppNavigator.of(context).push(
          routerPath,
          args: endpointPath.contains('forgot-password')
              ? NewPasswordArgs(params)
              : null,
        );
        notifyListeners();
      },
    );
  }

  Future<void> initializeBvn(AuthParams params, BuildContext context) async {
    onboardingResp = ApiResult<String>.idle();
    onboardingResp = ApiResult<String>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await authRepository.initializeBvn(params);
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        if (failure.message == 'Bvn name not match') {
          showInfoNotification(failure.message, durationInMills: 2500);
          showBvnInfoUpdate(
            context: context,
            onTap: (p0) {
              if (p0.isNotEmpty) {
                var requestDto = AuthParams.empty();
                requestDto = requestDto.copyWith(
                  fullName: p0.first,
                  phoneNumber: p0.last,
                );
                updateBvn(requestDto);
              }
            },
          ).show(context);
        } else {
          showErrorNotification(failure.message, durationInMills: 3000);
        }
      },
      (res) {
        onboardingResp = ApiResult<String>.success(res.toString());

        notifyListeners();
      },
    );
  }

  Future<void> updateBvn(AuthParams params) async {
    onboardingResp = ApiResult<String>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await authRepository.updateBvn(params);
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) {
        onboardingResp = ApiResult<String>.success(res.toString());

        notifyListeners();
      },
    );
  }

  Future<void> purpose(List<String> purpose, BuildContext context) async {
    onboardingResp = ApiResult<String>.idle();
    onboardingResp = ApiResult<String>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await authRepository.purpose(purpose);
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) {
        onboardingResp = ApiResult<String>.success(jsonEncode(res));
        AppNavigator.of(context).push(AppRoutes.reasonsToPin);

        notifyListeners();
      },
    );
  }

  Future<void> forgotPasswordInit(AuthParams params) async {
    onboardingResp = ApiResult<String>.idle();
    onboardingResp = ApiResult<String>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await authRepository.forgotPasswordInit(params);
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) {
        onboardingResp = ApiResult<String>.success(jsonEncode(res));

        notifyListeners();
      },
    );
  }

  Future<void> forgotPasswordReset(AuthParams params) async {
    onboardingResp = ApiResult<String>.idle();
    onboardingResp = ApiResult<String>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await authRepository.forgotPasswordReset(params);
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) {
        onboardingResp = ApiResult<String>.success(jsonEncode(res));
        showSuccessNotification('Password reset successfully');
        notifyListeners();
      },
    );
  }

  void countrySelected(CountryData country, BuildContext context) {
    AppNavigator.of(context)
      ..push(AppRoutes.countryToBvn)
      ..popDialog();
    notifyListeners();
  }

  void sessionTimeout(String reason, BuildContext? context) {
    showErrorNotification(reason);
    authRepository.localDataSource.flushLocalStorage();
    if (context != null) {
      AppNavigator.of(context).push(AppRoutes.onboardingAuth);
    } else {
      AppNavigator.of(context!).push(AppRoutes.onboardingAuth);
    }
    notifyListeners();
  }

  void logout(BuildContext? context) {
    authRepository.localDataSource.flushLocalStorage();
    if (context != null) {
      AppNavigator.of(context).push(AppRoutes.onboardingAuth);
    } else {
      AppNavigator.of(context!).push(AppRoutes.onboardingAuth);
    }

    notifyListeners();
  }
}
