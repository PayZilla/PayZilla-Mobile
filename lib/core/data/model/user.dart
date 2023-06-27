import 'dart:convert';

import 'package:equatable/equatable.dart';

class PZillaichangeUserData extends Equatable {
  const PZillaichangeUserData({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.referralCode,
    required this.profilePictureUrl,
    required this.address,
    required this.isDeactivated,
    required this.isPinEnabled,
    required this.pin,
    required this.dateDeactivated,
    required this.deactivationReason,
    required this.userType,
    required this.isKycVerified,
    required this.verficationId,
    required this.kycResponseString,
    required this.userHandle,
    required this.appType,
    required this.city,
    required this.occupation,
    required this.residenceCountry,
    required this.verificationStage,
    required this.firstProfileUpdateCompleted,
    required this.promoCode,
    required this.interactEmail,
    required this.secretQuestion,
    required this.secretAnswer,
    required this.applicationType,
    required this.socialSecurityNumber,
    required this.userPrivateKey,
    required this.kycStatus,
    required this.kycReferenceId,
    required this.kycTrials,
    required this.state,
    required this.postalCode,
    required this.walletAddress,
    required this.id,
    required this.bvn,
    required this.userName,
    required this.email,
    required this.emailConfirmed,
    required this.phoneNumber,
    required this.phoneNumberConfirmed,
    required this.twoFactorEnabled,
    required this.hasCompletedOnboardingQuestions,
  });

  factory PZillaichangeUserData.fromJson(String source) =>
      PZillaichangeUserData.fromMap(json.decode(source));

  factory PZillaichangeUserData.fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) return PZillaichangeUserData.empty();

    return PZillaichangeUserData(
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      referralCode: json['referralCode'] ?? '',
      profilePictureUrl: json['profilePictureUrl'] ?? '',
      address: json['address'] ?? '',
      isDeactivated: json['isDeactivated'] ?? false,
      isPinEnabled: json['isPinEnabled'] ?? false,
      hasCompletedOnboardingQuestions:
          json['hasCompletedOnboardingQuestions'] ?? false,
      pin: json['pin']?.toString() ?? '',
      dateDeactivated: json['dateDeactivated'] ?? '',
      deactivationReason: json['deactivationReason'] ?? '',
      isKycVerified: json['isKYCVerified'] ?? false,
      verficationId: json['verficationId'] ?? '',
      kycResponseString: json['kycResponseString'] ?? '',
      userHandle: json['userHandle'] ?? '',
      appType: json['appType']?.toString() ?? '',
      city: json['city'] ?? '',
      occupation: json['occupation'] ?? '',
      residenceCountry: json['residenceCountry'] ?? '',
      bvn: json['bvn'] ?? '',
      firstProfileUpdateCompleted: json['firstProfileUpdateCompleted'] ?? false,
      promoCode: json['promoCode'] ?? '',
      interactEmail: json['interactEmail'] ?? '',
      secretQuestion: json['secretQuestion'] ?? '',
      secretAnswer: json['secretAnswer'] ?? '',
      socialSecurityNumber: json['socialSecurityNumber'] ?? '',
      userPrivateKey: json['userPrivateKey'] ?? '',
      kycReferenceId: json['kycReferenceId'] ?? '',
      kycTrials: json['kycTrials'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      walletAddress: json['walletAddress'] ?? '',
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      emailConfirmed: json['emailConfirmed'] ?? false,
      phoneNumber: json['phoneNumber'] ?? '',
      phoneNumberConfirmed: json['phoneNumberConfirmed'] ?? false,
      twoFactorEnabled: json['twoFactorEnabled'] ?? false,
      verificationStage: json['verificationStage'] ?? 0,
      gender: json['gender'] ?? 0,
      userType: json['userType'] ?? 0,
      kycStatus: json['kycStatus'] ?? 0,
      // data type that are not sure but works with this
      applicationType: json['applicationType']?.toString() ?? '',
    );
  }

  factory PZillaichangeUserData.empty() => const PZillaichangeUserData(
        kycStatus: 0,
        verificationStage: 0,
        firstName: '',
        middleName: '',
        lastName: '',
        dateOfBirth: '',
        referralCode: '',
        isDeactivated: false,
        isPinEnabled: false,
        dateDeactivated: '',
        isKycVerified: false,
        firstProfileUpdateCompleted: false,
        secretQuestion: '',
        secretAnswer: '',
        bvn: '',
        phoneNumber: '',
        hasCompletedOnboardingQuestions: false,
        socialSecurityNumber: '',
        userPrivateKey: '',
        userHandle: '',
        appType: '',
        city: '',
        occupation: '',
        residenceCountry: '',
        promoCode: '',
        interactEmail: '',
        applicationType: '',
        kycReferenceId: '',
        kycTrials: '',
        state: '',
        postalCode: '',
        walletAddress: '',
        gender: 0,
        profilePictureUrl: '',
        address: '',
        pin: '',
        deactivationReason: '',
        userType: 0,
        verficationId: '',
        kycResponseString: '',
        id: '',
        userName: '',
        email: '',
        emailConfirmed: false,
        phoneNumberConfirmed: false,
        twoFactorEnabled: false,
      );

  final String firstName;
  final String middleName;
  final String lastName;
  final String dateOfBirth;
  final int gender;
  final String referralCode;
  final String profilePictureUrl;
  final String address;
  final bool isDeactivated;
  final bool isPinEnabled;
  final String pin;
  final String dateDeactivated;
  final String deactivationReason;
  final int userType;
  final bool isKycVerified;
  final String verficationId;
  final String kycResponseString;
  final String userHandle;
  final String appType;
  final String city;
  final String occupation;
  final String residenceCountry;
  final int verificationStage;
  final bool firstProfileUpdateCompleted;
  final String promoCode;
  final String interactEmail;
  final String secretQuestion;
  final String secretAnswer;
  final String applicationType;
  final String socialSecurityNumber;
  final String userPrivateKey;
  final int kycStatus;
  final String kycReferenceId;
  final String kycTrials;
  final String state;
  final String postalCode;
  final String walletAddress;
  final String id;
  final String userName;
  final String bvn;
  final String email;
  final bool emailConfirmed;
  final String phoneNumber;
  final bool phoneNumberConfirmed;
  final bool twoFactorEnabled;
  final bool hasCompletedOnboardingQuestions;

//NOTE: this validates first profile completion data
  bool get getFirstProfileComplete => firstProfileUpdateCompleted;

//NOTE: this validates first profile completion data and KYC validation
  bool get getAbsoluteVerification => isKycVerified && getFirstProfileComplete;

//NOTE: this validates if user has done questionnaire
  bool get getQuestionnaireStatus => hasCompletedOnboardingQuestions;

  String get fullName => '$firstName $lastName';

  bool get isEmpty => this == PZillaichangeUserData.empty();

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'referralCode': referralCode,
      'profilePictureUrl': profilePictureUrl,
      'address': address,
      'isDeactivated': isDeactivated,
      'isPinEnabled': isPinEnabled,
      'pin': pin,
      'dateDeactivated': dateDeactivated,
      'deactivationReason': deactivationReason,
      'userType': userType,
      'isKYCVerified': isKycVerified,
      'verficationId': verficationId,
      'kycResponseString': kycResponseString,
      'bvn': bvn,
      'userHandle': userHandle,
      'appType': appType,
      'city': city,
      'occupation': occupation,
      'residenceCountry': residenceCountry,
      'verificationStage': verificationStage,
      'firstProfileUpdateCompleted': firstProfileUpdateCompleted,
      'promoCode': promoCode,
      'interactEmail': interactEmail,
      'secretQuestion': secretQuestion,
      'secretAnswer': secretAnswer,
      'applicationType': applicationType,
      'socialSecurityNumber': socialSecurityNumber,
      'userPrivateKey': userPrivateKey,
      'kycStatus': kycStatus,
      'kycReferenceId': kycReferenceId,
      'kycTrials': kycTrials,
      'state': state,
      'postalCode': postalCode,
      'walletAddress': walletAddress,
      'id': id,
      'userName': userName,
      'email': email,
      'emailConfirmed': emailConfirmed,
      'phoneNumber': phoneNumber,
      'phoneNumberConfirmed': phoneNumberConfirmed,
      'twoFactorEnabled': twoFactorEnabled,
      'hasCompletedOnboardingQuestions': hasCompletedOnboardingQuestions
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      firstName,
      lastName,
      dateOfBirth,
      referralCode,
      isDeactivated,
      isPinEnabled,
      dateDeactivated,
      isKycVerified,
      firstProfileUpdateCompleted,
      secretQuestion,
      secretAnswer,
      bvn,
      phoneNumber,
      hasCompletedOnboardingQuestions,
      socialSecurityNumber,
      userPrivateKey,
      userHandle,
      appType,
      city,
      occupation,
      residenceCountry,
      verificationStage,
      promoCode,
      interactEmail,
      applicationType,
      kycStatus,
      kycReferenceId,
      kycTrials,
      state,
      postalCode,
      walletAddress,
      gender,
      profilePictureUrl,
      address,
      pin,
      deactivationReason,
      userType,
      verficationId,
      kycResponseString,
      id,
      userName,
      email,
      emailConfirmed,
      phoneNumberConfirmed,
      twoFactorEnabled,
    ];
  }
}
