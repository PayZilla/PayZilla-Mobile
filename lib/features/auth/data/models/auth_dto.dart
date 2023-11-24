import 'package:equatable/equatable.dart';

class AuthParams extends Equatable {
  const AuthParams({
    required this.email,
    required this.password,
    required this.countryCode,
    required this.phoneNumber,
    required this.applicationType,
    required this.fullName,
    required this.token,
    required this.dob,
    required this.bvn,
    required this.pin,
    required this.occupation,
    required this.employer,
    required this.tokenRoute,
  });

  factory AuthParams.empty() => const AuthParams(
        email: '',
        password: '',
        countryCode: '',
        fullName: '',
        phoneNumber: '',
        applicationType: 0,
        token: '',
        dob: '',
        bvn: '',
        pin: '',
        occupation: '',
        employer: '',
        tokenRoute: '',
      );
  final String email;
  final String password;
  final String phoneNumber;
  final String countryCode;
  final int applicationType;
  final String fullName;
  final String token;
  final String dob;
  final String bvn;
  final String pin;
  final String occupation;
  final String employer;
  final String tokenRoute;

  AuthParams copyWith({
    String? email,
    String? signUpEmail,
    String? password,
    String? phoneNumber,
    String? countryCode,
    int? applicationType,
    String? fullName,
    String? token,
    String? dob,
    String? bvn,
    String? pin,
    String? occupation,
    String? employer,
    String? tokenRoute,
  }) {
    return AuthParams(
      email: email ?? this.email,
      token: token ?? this.token,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      applicationType: applicationType ?? this.applicationType,
      dob: dob ?? this.dob,
      bvn: bvn ?? this.bvn,
      pin: pin ?? this.pin,
      occupation: occupation ?? this.occupation,
      employer: employer ?? this.employer,
      tokenRoute: tokenRoute ?? this.tokenRoute,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    const Pattern fullNameSplitPattern = r'\s+';
    final regex = RegExp(fullNameSplitPattern.toString());

    if (password.isNotEmpty) {
      map['password'] = password.trim();
    }

    if (email.isNotEmpty) {
      map['email'] = email.trim();
    }

    if (fullName.isNotEmpty && regex.hasMatch(fullName.trim())) {
      map['first_name'] = fullName.split(' ').first;
      map['last_name'] = fullName.split(' ').last;
    }

    if (applicationType > 0) {
      map['applicationType'] = applicationType;
    }
    if (countryCode.isNotEmpty) {
      map['countryCode'] = countryCode.trim();
    }

    if (phoneNumber.isNotEmpty) {
      map['phone_number'] = '+234${phoneNumber.trim()}';
    }

    if (token.isNotEmpty) {
      map['token'] = token.trim();
    }
    if (dob.isNotEmpty) {
      map['date_of_birth'] = dob.trim();
    }
    if (bvn.isNotEmpty) {
      map['bvn'] = bvn.trim();
    }
    if (pin.isNotEmpty) {
      map['pin'] = pin.trim();
    }

    if (occupation.isNotEmpty) {
      map['occupation'] = occupation;
    }
    if (employer.isNotEmpty) {
      map['employer'] = employer;
      map['ng_citizen'] = true;
    }

    return map;
  }

  @override
  List<Object> get props => [
        email,
        password,
        countryCode,
        applicationType,
        fullName,
        phoneNumber,
        token,
        dob,
        bvn,
        pin,
        occupation,
        employer,
        tokenRoute,
      ];
}
