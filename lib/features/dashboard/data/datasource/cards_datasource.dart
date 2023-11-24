import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/functional_utils/log_util.dart';

abstract class ICardsRemoteDataSource {
  Future<Either<ApiFailure, List<MultiSelectItem<CardsModel>>>> getCards();
  Future<Either<ApiFailure, CardInitiateModel>> initializeCard();
  Future<Either<ApiFailure, bool>> finalizeAddCard(String refID);
  Future<Either<ApiFailure, bool>> deleteCard(int cardId);
  Future<Either<ApiFailure, bool>> chargeCard(int amount, int cardId);
}

class CardsRemoteDataSource implements ICardsRemoteDataSource {
  CardsRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<Either<ApiFailure, List<MultiSelectItem<CardsModel>>>>
      getCards() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.getCards),
      );
      return Right(
        (response.data as List)
            .map((e) => MultiSelectItem(CardsModel.fromJson(e)))
            .toList(),
      );
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, CardInitiateModel>> initializeCard() async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          accountEndpoints.initiateCard,
          {},
        ),
      );
      return Right(CardInitiateModel.fromJson(response.data));
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, bool>> finalizeAddCard(String refID) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          accountEndpoints.finalizeCard,
          {'referenceId': refID},
        ),
      );
      return Right(response.status);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, bool>> deleteCard(int cardId) async {
    Log().debug('The delete card ref ', cardId);
    try {
      final response = ResponseDto.fromMap(
        await http.delete(accountEndpoints.deleteCard(cardId)),
      );
      return Right(response.status);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, bool>> chargeCard(num amount, int cardId) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(accountEndpoints.chargeCard(cardId), {
          'amount': amount,
        }),
      );
      return Right(response.status);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }
}
