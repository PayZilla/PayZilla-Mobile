import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserAuthModel extends Equatable {
  const UserAuthModel({required this.accessToken, required this.user});

  factory UserAuthModel.empty() => UserAuthModel(
        accessToken: '',
        user: User.empty(),
      );

  factory UserAuthModel.fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) return UserAuthModel.empty();

    return UserAuthModel(
      accessToken: json['access_token'] ?? '',
      user: User.fromMap(json['user']),
    );
  }

  final String accessToken;
  final User user;

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['user'] = user.toJson();
    return data;
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [accessToken, user];
}

class User extends Equatable {
  const User({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.phoneNumberVerifiedAt,
    required this.emailVerifiedAt,
    required this.countryCode,
    required this.dateOfBirth,
    required this.gender,
    required this.referralCode,
    required this.refereeId,
    required this.settings,
    required this.registrationPurpose,
    required this.occupation,
    required this.employer,
    required this.ngCitizen,
    required this.deactivatedAt,
    required this.createdAt,
    required this.hasSetPassword,
    required this.hasVerifiedEmail,
    required this.hasVerifiedPhoneNumber,
  });

  factory User.empty() => const User(
        uuid: '',
        firstName: '',
        lastName: '',
        email: '',
        phoneNumber: '',
        profileImage: '',
        phoneNumberVerifiedAt: '',
        emailVerifiedAt: '',
        countryCode: '',
        dateOfBirth: '',
        gender: '',
        referralCode: '',
        refereeId: '',
        settings: '',
        registrationPurpose: [],
        occupation: '',
        employer: '',
        ngCitizen: false,
        deactivatedAt: '',
        createdAt: '',
        hasSetPassword: false,
        hasVerifiedEmail: false,
        hasVerifiedPhoneNumber: false,
      );

  factory User.fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) return User.empty();

    return User(
      uuid: json['uuid'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      profileImage: json['profile_image'] ?? '',
      phoneNumberVerifiedAt: json['phone_number_verified_at'] ?? '',
      emailVerifiedAt: json['email_verified_at'] ?? '',
      countryCode: json['country_code'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      referralCode: json['referral_code'] ?? '',
      refereeId: json['referee_id'] ?? '',
      settings: json['settings'] ?? '',
      registrationPurpose: json['registration_purpose'] ?? <dynamic>[],
      occupation: json['occupation'] ?? '',
      employer: json['employer'] ?? '',
      ngCitizen: json['ng_citizen'] ?? false,
      deactivatedAt: json['deactivated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      hasSetPassword: json['has_set_password'] ?? false,
      hasVerifiedEmail: json['has_verified_email'] ?? false,
      hasVerifiedPhoneNumber: json['has_verified_phone_number'] ?? false,
    );
  }
  final String uuid;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final dynamic phoneNumberVerifiedAt;
  final String emailVerifiedAt;
  final String countryCode;
  final String dateOfBirth;
  final dynamic gender;
  final String referralCode;
  final dynamic refereeId;
  final dynamic settings;
  final List<dynamic> registrationPurpose;
  final String occupation;
  final String employer;
  final bool ngCitizen;
  final dynamic deactivatedAt;
  final String createdAt;
  final bool hasSetPassword;
  final bool hasVerifiedEmail;
  final bool hasVerifiedPhoneNumber;

//NOTE: this validates first profile completion data
  bool get getAbsoluteVerification =>
      hasVerifiedEmail && hasVerifiedPhoneNumber;

  String get fullName => '$firstName $lastName';

  bool get isEmpty => this == User.empty();

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['profile_image'] = profileImage;
    data['phone_number_verified_at'] = phoneNumberVerifiedAt;
    data['email_verified_at'] = emailVerifiedAt;
    data['country_code'] = countryCode;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['referral_code'] = referralCode;
    data['referee_id'] = refereeId;
    data['settings'] = settings;
    data['registration_purpose'] = registrationPurpose;
    data['occupation'] = occupation;
    data['employer'] = employer;
    data['ng_citizen'] = ngCitizen;
    data['deactivated_at'] = deactivatedAt;
    data['created_at'] = createdAt;
    data['has_set_password'] = hasSetPassword;
    data['has_verified_email'] = hasVerifiedEmail;
    data['has_verified_phone_number'] = hasVerifiedPhoneNumber;
    return data;
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [
        uuid,
        firstName,
        lastName,
        email,
        phoneNumber,
        profileImage,
        phoneNumberVerifiedAt,
        emailVerifiedAt,
        countryCode,
        dateOfBirth,
        gender,
        referralCode,
        refereeId,
        settings,
        registrationPurpose,
        occupation,
        employer,
        ngCitizen,
        deactivatedAt,
        createdAt,
        hasSetPassword,
        hasVerifiedEmail,
        hasVerifiedPhoneNumber,
      ];
}
