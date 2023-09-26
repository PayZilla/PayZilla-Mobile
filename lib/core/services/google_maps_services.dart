import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

abstract class IMapsRemoteServices {
  Future<List<Predictions>> fetchSuggestions(
    String query, {
    String country = 'ca',
  });
  Future<PlaceModel> getPlaceDetailFromId(String placeId);
}

class MapsServiceImpl implements IMapsRemoteServices {
  MapsServiceImpl(this.http, this.sessionToken);

  final HttpManager http;
  final String sessionToken;

  @override
  Future<List<Predictions>> fetchSuggestions(
    String query, {
    String country = 'ca',
  }) async {
    try {
      final response = PlacesSuggestionDto.fromJson(
        await http.get(
          '', // mapsEndpoints.suggestion(query, country, sessionToken),
        ),
      );

      if (response.isResultOk) {
        return response.predictions;
      } else if (response.resultNotOk) {
        showInfoNotification(
          'No result found for $query address',
          durationInMills: 2000,
        );
        return [];
      }

      throw AppServerException(response.status);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<PlaceModel> getPlaceDetailFromId(String placeId) async {
    try {
      final response = PlaceDetailedDto.fromJson(
        await http.get(
          '', //mapsEndpoints.completePlaceId(placeId, sessionToken),
        ),
      );
      if (response.isResultOk) {
        var placeModel = PlaceModel.empty();
        for (final c in response.result!.addressComponents!) {
          final List type = c.types!;
          if (type.contains('street_number')) {
            placeModel =
                placeModel.copyWith(streetNumber: c.longName.toString());
          }
          if (type.contains('route')) {
            placeModel = placeModel.copyWith(streetName: c.longName.toString());
          }
          if (type.contains('administrative_area_level_2')) {
            placeModel = placeModel.copyWith(city: c.longName.toString());
          }
          if (type.contains('locality')) {
            placeModel = placeModel.copyWith(city: c.longName.toString());
          }
          if (type.contains('administrative_area_level_1')) {
            placeModel = placeModel.copyWith(province: c.longName.toString());
          }
          if (type.contains('postal_code')) {
            placeModel = placeModel.copyWith(postalCode: c.longName.toString());
          }
        }
        return placeModel;
      }
      throw AppServerException('response.message');
    } catch (_) {
      rethrow;
    }
  }
}
