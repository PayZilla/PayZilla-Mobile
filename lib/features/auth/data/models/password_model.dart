import 'package:equatable/equatable.dart';

class PasswordValidationState extends Equatable {
  const PasswordValidationState({
    required this.has8CharactersMin,
    required this.hasSpecialCharacter,
    required this.hasUpperCase,
    required this.hasNumber,
  });

  factory PasswordValidationState.initial() {
    return const PasswordValidationState(
      has8CharactersMin: false,
      hasSpecialCharacter: false,
      hasUpperCase: false,
      hasNumber: false,
    );
  }
  final bool has8CharactersMin;
  final bool hasSpecialCharacter;
  final bool hasUpperCase;
  final bool hasNumber;

  bool get isInputValid =>
      has8CharactersMin && hasSpecialCharacter && hasUpperCase && hasNumber;

  PasswordValidationState copyWith({
    bool? has8CharactersMin,
    bool? hasSpecialCharacter,
    bool? hasUpperCase,
    bool? hasNumber,
  }) {
    return PasswordValidationState(
      has8CharactersMin: has8CharactersMin ?? this.has8CharactersMin,
      hasSpecialCharacter: hasSpecialCharacter ?? this.hasSpecialCharacter,
      hasUpperCase: hasUpperCase ?? this.hasUpperCase,
      hasNumber: hasNumber ?? this.hasNumber,
    );
  }

  @override
  List<Object> get props =>
      [has8CharactersMin, hasSpecialCharacter, hasUpperCase, hasNumber];
}
