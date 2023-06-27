// ignore_for_file: avoid_dynamic_calls
// NOTE (Taiwo) : I can call dynamic values in this file because it is coming from a more stable platform ---Google
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PlacesSuggestionDto extends Equatable {
  const PlacesSuggestionDto({required this.predictions, required this.status});

  factory PlacesSuggestionDto.fromJson(Map<String, dynamic> json) {
    return PlacesSuggestionDto(
      status: json['status'],
      predictions: List<Predictions>.from(
        json['predictions'].map(
          Predictions.fromJson,
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['predictions'] = predictions.map((v) => v.toJson()).toList();
    data['status'] = status;
    return data;
  }

  final List<Predictions> predictions;
  final String status;

// for status checks
  bool get isResultOk => status.contains('OK');
  bool get resultNotOk =>
      status.contains('INVALID_REQUEST') || status.contains('ZERO_RESULTS');

  @override
  List<Object?> get props => [predictions, status];
}

class Predictions extends Equatable {
  const Predictions({
    required this.description,
    required this.placeId,
    required this.reference,
  });

  factory Predictions.fromJson(Map<String, dynamic> json) {
    return Predictions(
      description: json['description'] ?? '',
      placeId: json['place_id'] ?? '',
      reference: json['reference'] ?? '',
    );
  }
  final String description;
  final String placeId;
  final String reference;

  Map<String, dynamic> toJson() => {
        'description': description,
        'place_id': placeId,
        'reference': reference,
      };

  @override
  List<Object?> get props => [description, placeId, reference];
}

class PlaceDetailedDto {
  PlaceDetailedDto({this.result, this.status});

  PlaceDetailedDto.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    status = json['status'];
  }
  Result? result;
  String? status;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['status'] = status;
    return data;
  }

  bool get isResultOk => status!.contains('OK');
}

class Result {
  Result({this.addressComponents});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <AddressComponents>[];
      json['address_components'].forEach((v) {
        addressComponents!.add(AddressComponents.fromJson(v));
      });
    }
  }
  List<AddressComponents>? addressComponents;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (addressComponents != null) {
      data['address_components'] =
          addressComponents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressComponents {
  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }
  String? longName;
  String? shortName;
  List<String>? types;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['long_name'] = longName;
    data['short_name'] = shortName;
    data['types'] = types;
    return data;
  }
}

class PlaceModel extends Equatable {
  const PlaceModel({
    required this.streetNumber,
    required this.streetName,
    required this.city,
    required this.postalCode,
    required this.province,
  });

  factory PlaceModel.empty() => const PlaceModel(
        streetNumber: '',
        streetName: '',
        city: '',
        postalCode: '',
        province: '',
      );

  PlaceModel copyWith({
    String? streetNumber,
    String? streetName,
    String? city,
    String? postalCode,
    String? province,
  }) {
    return PlaceModel(
      streetNumber: streetNumber ?? this.streetNumber,
      streetName: streetName ?? this.streetName,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      province: province ?? this.province,
    );
  }

  final String streetNumber;
  final String streetName;
  final String city;
  final String postalCode;
  final String province;

  @override
  List<Object?> get props =>
      [streetName, streetNumber, city, postalCode, province];
}
