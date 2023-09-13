import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthPreferenceModel extends Equatable {
  const AuthPreferenceModel({
    required this.hasCompletedOnboarding,
    required this.isBiometricEnabled,
    required this.hasRequestedBiometricOnce,
  });

  factory AuthPreferenceModel.fromJson(String source) =>
      AuthPreferenceModel.fromMap(json.decode(source));

  factory AuthPreferenceModel.fromMap(Map<String, dynamic> map) {
    return AuthPreferenceModel(
      hasCompletedOnboarding: map['hasCompletedOnboarding'] ?? false,
      isBiometricEnabled: map['isBiometricEnabled'] ?? false,
      hasRequestedBiometricOnce: map['hasRequestedBiometricOnce'] ?? false,
    );
  }
  final bool hasCompletedOnboarding;
  final bool isBiometricEnabled;
  final bool hasRequestedBiometricOnce;

  bool get hasNotRequestedBiometricOnce => !hasRequestedBiometricOnce;

  AuthPreferenceModel copyWith({
    bool? hasCompletedOnboarding,
    bool? isBiometricEnabled,
    bool? hasRequestedBiometricOnce,
  }) {
    return AuthPreferenceModel(
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      hasRequestedBiometricOnce:
          hasRequestedBiometricOnce ?? this.hasRequestedBiometricOnce,
    );
  }

  Map<String, dynamic> toMap() => {
        'hasCompletedOnboarding': hasCompletedOnboarding,
        'isBiometricEnabled': isBiometricEnabled,
        'hasRequestedBiometricOnce': hasRequestedBiometricOnce,
      };

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props =>
      [hasCompletedOnboarding, hasRequestedBiometricOnce, isBiometricEnabled];
}
