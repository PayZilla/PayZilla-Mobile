import 'package:equatable/equatable.dart';

class AuthResponseData extends Equatable {
  const AuthResponseData({
    required this.email,
    required this.accessToken,
    required this.refreshToken,
    required this.expires,
    required this.userType,
    required this.nextProfileUpdate,
  });

  factory AuthResponseData.fromJson(Map<String, dynamic> json) {
    return AuthResponseData(
      email: json['email'] ?? '',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      expires: json['expires'] ?? '',
      userType: json['userType'] ?? 0,
      nextProfileUpdate: json['nextProfileUpdate'] ?? false,
    );
  }
//NOTE: this validates first profile completion data
  bool get getNextProfileUpdate => nextProfileUpdate;

  final String email;
  final String accessToken;
  final String refreshToken;
  final String expires;
  final int userType;
  final bool nextProfileUpdate;

  @override
  List<Object> get props => [
        email,
        accessToken,
        refreshToken,
        expires,
        userType,
        nextProfileUpdate,
      ];
}
