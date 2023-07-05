import 'package:equatable/equatable.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';

class AuthParams extends Equatable {
  const AuthParams({
    required this.email,
    required this.signUpEmail,
    required this.password,
    required this.countryCode,
    required this.phoneNumber,
    required this.applicationType,
  });

  factory AuthParams.empty() => AuthParams(
        email: '',
        signUpEmail: '',
        password: '',
        countryCode: '',
        phoneNumber: PhoneNumber.empty(),
        applicationType: 0,
      );
  final String email;
  final String signUpEmail;
  final String password;
  final PhoneNumber phoneNumber;
  final String countryCode;
  final int applicationType;

  AuthParams copyWith({
    String? email,
    String? signUpEmail,
    String? password,
    PhoneNumber? phoneNumber,
    String? countryCode,
    int? applicationType,
  }) {
    return AuthParams(
      email: email ?? this.email,
      signUpEmail: signUpEmail ?? this.signUpEmail,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      applicationType: applicationType ?? this.applicationType,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['password'] = password.trim();

    if (email.isNotEmpty) {
      map['email'] = email.trim();
    }

    if (signUpEmail.isNotEmpty) {
      map['emailAddress'] = signUpEmail.trim();
    }

    if (applicationType > 0) {
      map['applicationType'] = applicationType;
    }
    if (countryCode.isNotEmpty) {
      map['countryCode'] = countryCode.trim();
    }

    if (phoneNumber.isNotEmpty) {
      map['phoneNumber'] = phoneNumber.number.trim();
    }

    return map;
  }

  @override
  List<Object> get props => [
        email,
        password,
        countryCode,
        applicationType,
        phoneNumber,
      ];
}
