import 'dart:convert';

import 'package:equatable/equatable.dart';

class CountryData extends Equatable {
  const CountryData({
    required this.countryName,
    required this.countryId,
    required this.flag,
    required this.currencyCode,
    required this.slug,
    required this.applicationType,
    required this.countryPhoneCode,
    required this.maxLength,
  });

  factory CountryData.empty() => const CountryData(
        countryId: '',
        countryName: '',
        currencyCode: '',
        flag: '',
        slug: '',
        applicationType: 0,
        countryPhoneCode: '',
        maxLength: 0,
      );

  CountryData copyWith({
    String? countryName,
    String? countryId,
    String? flag,
    String? currencyCode,
    String? slug,
    int? applicationType,
    String? countryPhoneCode,
    int? maxLength,
  }) {
    return CountryData(
      applicationType: applicationType ?? this.applicationType,
      countryId: countryId ?? this.countryId,
      countryName: countryName ?? this.countryName,
      countryPhoneCode: countryPhoneCode ?? this.countryPhoneCode,
      currencyCode: currencyCode ?? this.currencyCode,
      flag: flag ?? this.flag,
      slug: slug ?? this.slug,
      maxLength: maxLength ?? this.maxLength,
    );
  }

  Map<String, dynamic> toJson() => {
        'countryName': countryName,
        'countryId': countryId,
        'currencyCode': currencyCode,
        'flag': flag,
        'slug': slug,
        'applicationType': applicationType,
        'mobileCountryCode': countryPhoneCode,
        'maxLength': maxLength,
      };
  String toMap() => json.encode(toJson());
  bool get isEmpty => this == CountryData.empty();

  final String countryName;
  final String countryId;
  final String flag;
  final String currencyCode;
  final String slug;
  final int applicationType;
  final String countryPhoneCode;
  final int maxLength;

  @override
  List<Object?> get props => [
        countryName,
        countryId,
        flag,
        currencyCode,
        slug,
        applicationType,
        countryPhoneCode,
      ];
}
