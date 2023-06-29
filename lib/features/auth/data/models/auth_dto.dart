import 'package:equatable/equatable.dart';

class AuthParams extends Equatable {
  const AuthParams({
    required this.email,
    required this.signUpEmail,
    required this.password,
    required this.countryCode,
    required this.applicationType,
  });

  factory AuthParams.empty() => const AuthParams(
        email: '',
        signUpEmail: '',
        password: '',
        countryCode: '',
        applicationType: 0,
      );
  final String email;
  final String signUpEmail;
  final String password;
  final String countryCode;
  final int applicationType;

  AuthParams copyWith({
    String? email,
    String? signUpEmail,
    String? password,
    String? countryCode,
    int? applicationType,
  }) {
    return AuthParams(
      email: email ?? this.email,
      signUpEmail: signUpEmail ?? this.signUpEmail,
      password: password ?? this.password,
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

    return map;
  }

  @override
  List<Object> get props => [
        email,
        password,
        countryCode,
        applicationType,
      ];
}
