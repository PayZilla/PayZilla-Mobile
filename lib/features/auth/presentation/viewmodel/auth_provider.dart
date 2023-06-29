import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  final deBouncer = DeBouncer(milliseconds: 200);

  ApiResult<AuthResponseData> genericAuthResp =
      ApiResult<AuthResponseData>.idle();

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
      (res) {
        if (!res.getFirstProfileComplete) {
          AppNavigator.of(context).push(AppRoutes.profileInfo);
          return;
        }
        if (res.hasCompletedOnboardingQuestions == false) {
          AppNavigator.of(context).push(AppRoutes.questionnaire);
          return;
        }
        // This comment is needed for reference when work on questionnaire begins
        // if (!res.getQuestionnaireStatus) {
        //   AppNavigator.of(context).push(AppRoutes.questionnaire);
        //   return;
        // }
        AppNavigator.of(context).push(AppRoutes.home);
      },
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
