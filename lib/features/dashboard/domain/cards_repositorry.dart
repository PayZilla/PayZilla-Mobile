import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';

abstract class CardsRepository {
  Future<Either<ApiFailure, List<MultiSelectItem<CardsModel>>>> getCards();
  Future<Either<ApiFailure, CardInitiateModel>> initializeCard();
  Future<Either<ApiFailure, bool>> finalizeAddCard(String refId);
  Future<Either<ApiFailure, bool>> deleteCard(int cardId);
  Future<Either<ApiFailure, bool>> chargeCard(int amount, int cardId);
}

class CardsRepositoryImpl extends CardsRepository {
  CardsRepositoryImpl({
    required this.remoteDataSource,
  });

  final ICardsRemoteDataSource remoteDataSource;

  @override
  Future<Either<ApiFailure, List<MultiSelectItem<CardsModel>>>>
      getCards() async {
    return remoteDataSource.getCards();
  }

  @override
  Future<Either<ApiFailure, CardInitiateModel>> initializeCard() async {
    return remoteDataSource.initializeCard();
  }

  @override
  Future<Either<ApiFailure, bool>> finalizeAddCard(String refId) async {
    return remoteDataSource.finalizeAddCard(refId);
  }

  @override
  Future<Either<ApiFailure, bool>> deleteCard(int cardId) async {
    return remoteDataSource.deleteCard(cardId);
  }

  @override
  Future<Either<ApiFailure, bool>> chargeCard(int amount, int cardId) async {
    return remoteDataSource.chargeCard(amount, cardId);
  }
}
