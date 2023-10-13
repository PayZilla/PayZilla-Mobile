import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';

class CardsRepository extends Repository {
  CardsRepository({
    required this.remoteDataSource,
  });

  final ICardsRemoteDataSource remoteDataSource;

  Future<Either<Failure, List<MultiSelectItem<CardsModel>>>> getCards() async {
    return runGuard(() async {
      final response = await remoteDataSource.getCards();

      return response;
    });
  }

  Future<Either<Failure, CardInitiateModel>> initializeCard() async {
    return runGuard(() async {
      final response = await remoteDataSource.initializeCard();

      return response;
    });
  }

  Future<Either<Failure, bool>> finalizeAddCard(String refId) async {
    return runGuard(() async {
      final response = await remoteDataSource.finalizeAddCard(refId);

      return response;
    });
  }

  Future<Either<Failure, bool>> deleteCard(int cardId) async {
    return runGuard(() async {
      final response = await remoteDataSource.deleteCard(cardId);

      return response;
    });
  }

  Future<Either<Failure, bool>> chargeCard(int amount, int cardId) async {
    return runGuard(() async {
      final response = await remoteDataSource.chargeCard(amount, cardId);

      return response;
    });
  }
}
