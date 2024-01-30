// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/di/dependency_injection_container.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/auth/usecase/auth_usecase.dart';
import 'package:pay_zilla/features/auth/usecase/user_usecase.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required this.loginUseCase,
    required this.userUserCase,
    required this.userUserKycCase,
    required this.signUpUseCase,
    required this.emailVerificationUseCase,
    required this.tokenVerificationUseCase,
    required this.pinSetupUseCase,
    required this.fetchReasonsUseCase,
    required this.initializeBvnUseCase,
    required this.updateBvnUseCase,
    required this.forgotPasswordUseCase,
    required this.forgotPasswordResetUseCase,
    required this.purposeUseCase,
  });

  LogInUseCase loginUseCase;
  GetUserUseCase userUserCase;
  GetUserKycUseCase userUserKycCase;
  SignUpUseCase signUpUseCase;
  EmailVerificationUseCase emailVerificationUseCase;
  TokenVerificationUseCase tokenVerificationUseCase;
  PinSetupUseCase pinSetupUseCase;
  FetchReasonsUseCase fetchReasonsUseCase;
  InitializeBvnUseCase initializeBvnUseCase;
  UpdateBvnUseCase updateBvnUseCase;
  ForgotPasswordUseCase forgotPasswordUseCase;
  ForgotPasswordResetUseCase forgotPasswordResetUseCase;
  PurposeUseCase purposeUseCase;

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
  ApiResult<UserAuthModel> signUpAuthResp = ApiResult<UserAuthModel>.idle();

  ApiResult<List<ReasonsModel>> reasonsResp =
      ApiResult<List<ReasonsModel>>.idle();

  ApiResult<String> onboardingResp = ApiResult<String>.idle();

  PasswordValidationState passValidState = PasswordValidationState.initial();

  Future<void> login(AuthParams requestDto, BuildContext context) async {
    genericAuthResp = ApiResult<UserAuthModel>.loading('Logging in....');
    notifyListeners();
    sl<IAuthLocalDataSource>().flushLocalStorage();

    final failureOrLogin = await loginUseCase.call(requestDto);
    await failureOrLogin.fold(
      (failure) {
        genericAuthResp = ApiResult<UserAuthModel>.error(failure.message);
        notifyListeners();

        showErrorNotification(
          context,
          failure.message,
          durationInMills: 2000,
        );
        notifyListeners();
      },
      (res) async {
        sl<IAuthLocalDataSource>()
          ..flushLocalStorage()
          ..saveAuthUserPref(res.user)
          ..saveUserEmail(res.user.email)
          ..saveToken(res.accessToken)
          ..saveUserPassword(requestDto.password);
        await getUser(context: context);
        AppNavigator.of(context).push(AppRoutes.home);

/*
        //1. Handle all conditions on login response first
        if (!res.user.hasVerifiedEmail) {
          final verificationMsg =
              'You have not verified either phone number (${res.user.phoneNumber}) or email (${res.user.email})';
          showInfoNotification(context, verificationMsg, durationInMills: 3500);
          genericAuthResp = ApiResult<UserAuthModel>.error(verificationMsg);
          notifyListeners();

          AppNavigator.of(context).push(
            AppRoutes.pin,
            args: GenericTokenVerificationArgs(
              email: res.user.email,
              path: AppRoutes.country,
              endpointPath: authEndpoints.emailVerificationVerify,
            ),
          );
          return;
        }
        if (!res.user.hasVerifiedPhoneNumber) {
          genericAuthResp = ApiResult<UserAuthModel>.error(
            'You have not verified phone number (${res.user.phoneNumber})',
          );
          showInfoNotification(
            context,
            genericAuthResp.message,
            durationInMills: 3500,
          );
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

        await getKyc(context);*/

        genericAuthResp = ApiResult<UserAuthModel>.success(res);
        notifyListeners();
      },
    );
  }

  Future<void> getKyc(BuildContext context) async {
    final failureOrKYC = await userUserKycCase.call(NoParams());

    await failureOrKYC.fold(
      (failure) {
        Log().debug('The KYC failed', failure.message);
      },
      (res) async {
        if (res.isEmpty) {
          AppNavigator.of(context).push(AppRoutes.countryToBvn);
        } else {
          await sl<IAuthLocalDataSource>().canUseBiometric
              ? AppNavigator.of(context).push(AppRoutes.biometric)
              : AppNavigator.of(context).push(AppRoutes.home);
        }
      },
    );
  }

  Future<User> getUser({
    bool useNetworkCall = true,
    required BuildContext context,
  }) async {
    _user = User.empty();
    final userLocal = await sl<IAuthLocalDataSource>().getAuthUserPref();
    if (userLocal != null) {
      _user = userLocal as User;
      notifyListeners();
    }
    if (!useNetworkCall) return _user;

    final failureOrUser = await userUserCase.call(NoParams());
    failureOrUser.fold(
      (failure) {
        showErrorNotification(context, failure.message, durationInMills: 2000);
        if (failure is SessionFailure) {
          AppNavigator.of(context).push(AppRoutes.homeToLogout);
        }
        notifyListeners();
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
    signUpAuthResp = ApiResult<UserAuthModel>.loading('Signing up....');
    notifyListeners();
    sl<IAuthLocalDataSource>().flushLocalStorage();

    final failureOrLogin = await signUpUseCase.call(requestDto);
    failureOrLogin.fold(
      (failure) {
        signUpAuthResp = ApiResult<UserAuthModel>.error(failure.message);
        notifyListeners();
        showErrorNotification(context, failure.message, durationInMills: 2000);
        notifyListeners();
      },
      (res) {
        sl<IAuthLocalDataSource>()
          ..saveAuthUserPref(res.user)
          ..saveUserEmail(res.user.email)
          ..saveToken(res.accessToken);
        AppNavigator.of(context).push(
          AppRoutes.pin,
          args: GenericTokenVerificationArgs(
            email: res.user.email,
            path: AppRoutes.home,
            endpointPath: authEndpoints.emailVerificationVerify,
          ),
        );
        signUpAuthResp = ApiResult<UserAuthModel>.success(res);

        notifyListeners();
      },
    );
  }

  // pinSetup
  Future<void> pinSetup(String pin, BuildContext context) async {
    onboardingResp = ApiResult<String>.loading('Loading...');
    notifyListeners();
    final failureOrLogin = await pinSetupUseCase.call(pin);
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);
        notifyListeners();
        showErrorNotification(context, failure.message, durationInMills: 2000);
        notifyListeners();
      },
      (res) {
        onboardingResp = ApiResult<String>.success('PIN created successfully.');
        AppNavigator.of(context).push(AppRoutes.home);
        notifyListeners();
      },
    );
  }

// Get reasons
  Future<void> fetchReasons(BuildContext context) async {
    reasonsResp = ApiResult<List<ReasonsModel>>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await fetchReasonsUseCase.call(NoParams());
    failureOrLogin.fold(
      (failure) {
        reasonsResp = ApiResult<List<ReasonsModel>>.error(failure.message);

        notifyListeners();

        showErrorNotification(context, failure.message, durationInMills: 2000);
        notifyListeners();
      },
      (res) {
        reasonsResp = ApiResult<List<ReasonsModel>>.success(res);

        notifyListeners();
      },
    );
  }

  Future<void> emailVerificationInitiate(BuildContext context) async {
    onboardingResp = ApiResult<String>.loading('Loading up....');

    notifyListeners();
    Log().debug('Request OTP');
    final failureOrLogin = await emailVerificationUseCase.call(NoParams());
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        showErrorNotification(context, failure.message, durationInMills: 2000);
        notifyListeners();
      },
      (res) {
        onboardingResp = ApiResult<String>.success(res);
        // Just so that the message from login can show and nothing spoils if this still comes from registration also :)
        Future.delayed(3500.milliseconds).then((value) {
          showSuccessNotification(
            context,
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

    final failureOrLogin = await tokenVerificationUseCase.call(params);
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        showErrorNotification(context, failure.message, durationInMills: 2000);
        notifyListeners();
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

  Future<void> initializeBvn(BuildContext context) async {
    onboardingResp = ApiResult<String>.idle();
    onboardingResp = ApiResult<String>.loading('Loading up....');
    notifyListeners();

    final failureOrLogin = await initializeBvnUseCase.call(NoParams());
    await failureOrLogin.fold(
      (failure) async {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        if (failure.message == 'Bvn name not match') {
          showInfoNotification(
            context,
            'BVN name not match PayZilla user name',
            durationInMills: 3500,
          );
          var requestDto = AuthParams.empty();
          await showBvnInfoUpdate(
            context: context,
            onTap: (p0) async {
              if (p0.isNotEmpty) {
                requestDto = requestDto.copyWith(
                  fullName: p0.first,
                  phoneNumber: p0.last,
                );
                notifyListeners();
              }
            },
          ).show(context);

          await updateBvn(requestDto, context);

          onboardingResp = ApiResult<String>.idle();
          notifyListeners();
        } else {
          showErrorNotification(
            context,
            failure.message,
            durationInMills: 3000,
          );
        }
      },
      (res) {
        onboardingResp = ApiResult<String>.success(res);
        notifyListeners();
      },
    );
  }

  Future<void> updateBvn(AuthParams params, BuildContext context) async {
    onboardingResp = ApiResult<String>.idle();
    onboardingResp = ApiResult<String>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await updateBvnUseCase.call(params);
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        showErrorNotification(context, failure.message, durationInMills: 2000);
        notifyListeners();
      },
      (res) {
        onboardingResp = ApiResult<String>.success(res.toString());
        showSuccessNotification(context, 'BVN info updated successfully');
        notifyListeners();
      },
    );
  }

  Future<void> purpose(List<String> purpose, BuildContext context) async {
    onboardingResp = ApiResult<String>.idle();
    onboardingResp = ApiResult<String>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await purposeUseCase.call(purpose);
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        showErrorNotification(context, failure.message, durationInMills: 2000);
        notifyListeners();
      },
      (res) {
        onboardingResp = ApiResult<String>.success(jsonEncode(res));
        AppNavigator.of(context).push(AppRoutes.reasonsToPin);

        notifyListeners();
      },
    );
  }

  Future<void> forgotPasswordInit(
    AuthParams params,
    BuildContext context,
  ) async {
    onboardingResp = ApiResult<String>.idle();
    onboardingResp = ApiResult<String>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await forgotPasswordUseCase.call(params);
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        showErrorNotification(context, failure.message, durationInMills: 2000);
        notifyListeners();
      },
      (res) {
        onboardingResp = ApiResult<String>.success(jsonEncode(res));

        notifyListeners();
      },
    );
  }

  Future<void> forgotPasswordReset(
    AuthParams params,
    BuildContext context,
  ) async {
    onboardingResp = ApiResult<String>.idle();
    onboardingResp = ApiResult<String>.loading('Loading up....');

    notifyListeners();

    final failureOrLogin = await forgotPasswordResetUseCase.call(params);
    failureOrLogin.fold(
      (failure) {
        onboardingResp = ApiResult<String>.error(failure.message);

        notifyListeners();

        showErrorNotification(context, failure.message, durationInMills: 2000);
        notifyListeners();
      },
      (res) {
        onboardingResp = ApiResult<String>.success(jsonEncode(res));
        showSuccessNotification(context, 'Password reset successfully');
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

  void sessionLogout(BuildContext context) {
    sl<IAuthLocalDataSource>().flushLocalStorage();
    AppNavigator.of(context).push(AppRoutes.onboarding);
    notifyListeners();
  }
}
