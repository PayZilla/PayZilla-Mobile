import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';

abstract class ICardsRemoteDataSource {
  Future<List<CardsModel>> getCards();
  Future<CardInitiateModel> initializeCard();
  Future<String> finalizeAddCard(String refID);
}

class CardsRemoteDataSource implements ICardsRemoteDataSource {
  CardsRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<List<CardsModel>> getCards() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.getCards),
      );
      if (response.isResultOk) {
        final data = response.data as List;
        return data.map((e) => CardsModel.fromJson(e)).toList();
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<CardInitiateModel> initializeCard() async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          accountEndpoints.initiateCard,
          {},
        ),
      );
      if (response.isResultOk) {
        return CardInitiateModel.fromJson(response.data);
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> finalizeAddCard(String refID) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          accountEndpoints.finalizeCard,
          {'referenceId': refID},
        ),
      );
      if (response.isResultOk) {
        // ignore: avoid_dynamic_calls
        return response.data['id'] as String;
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }
}
