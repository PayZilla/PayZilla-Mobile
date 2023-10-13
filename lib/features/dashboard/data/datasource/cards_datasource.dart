import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/functional_utils/log_util.dart';

abstract class ICardsRemoteDataSource {
  Future<List<MultiSelectItem<CardsModel>>> getCards();
  Future<bool> deleteCard(int cardId);
  Future<CardInitiateModel> initializeCard();
  Future<bool> finalizeAddCard(String refID);
  Future<bool> chargeCard(int amount, int cardId);
}

class CardsRemoteDataSource implements ICardsRemoteDataSource {
  CardsRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<List<MultiSelectItem<CardsModel>>> getCards() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.getCards),
      );
      if (response.isResultOk) {
        final data = response.data as List;
        // return data.map((e) => CardsModel.fromJson(e)).toList();
        return data
            .map((e) => MultiSelectItem(CardsModel.fromJson(e)))
            .toList();
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
  Future<bool> finalizeAddCard(String refID) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          accountEndpoints.finalizeCard,
          {'referenceId': refID},
        ),
      );
      if (response.isResultOk) {
        return response.status;
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteCard(int cardId) async {
    Log().debug('The delete card ref ', cardId);
    try {
      final response = ResponseDto.fromMap(
        await http.delete(accountEndpoints.deleteCard(cardId)),
      );
      if (response.isResultOk) {
        // ignore: avoid_dynamic_calls
        return response.status;
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> chargeCard(num amount, int cardId) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(accountEndpoints.chargeCard(cardId), {
          'amount': amount,
        }),
      );
      if (response.isResultOk) {
        return response.status;
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }
}
