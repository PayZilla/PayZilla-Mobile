import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';

class GetCardsUseCase
    implements UseCase<List<MultiSelectItem<CardsModel>>, NoParams> {
  GetCardsUseCase({required this.cardsRepository});
  CardsRepository cardsRepository;

  @override
  Future<Either<ApiFailure, List<MultiSelectItem<CardsModel>>>> call(
    NoParams params,
  ) {
    return cardsRepository.getCards();
  }
}

class InitCardsUseCase implements UseCase<CardInitiateModel, NoParams> {
  InitCardsUseCase({required this.cardsRepository});
  CardsRepository cardsRepository;

  @override
  Future<Either<ApiFailure, CardInitiateModel>> call(
    NoParams params,
  ) {
    return cardsRepository.initializeCard();
  }
}

class FinalizeCardsUseCase implements UseCase<bool, String> {
  FinalizeCardsUseCase({required this.cardsRepository});
  CardsRepository cardsRepository;

  @override
  Future<Either<ApiFailure, bool>> call(
    String params,
  ) {
    return cardsRepository.finalizeAddCard(params);
  }
}

class DeleteCardsUseCase implements UseCase<bool, int> {
  DeleteCardsUseCase({required this.cardsRepository});
  CardsRepository cardsRepository;

  @override
  Future<Either<ApiFailure, bool>> call(
    int params,
  ) {
    return cardsRepository.deleteCard(params);
  }
}

class ChargeCardsUseCase implements UseCase<bool, List<int>> {
  ChargeCardsUseCase({required this.cardsRepository});
  CardsRepository cardsRepository;

  @override
  Future<Either<ApiFailure, bool>> call(
    List<int> params,
  ) {
    return cardsRepository.chargeCard(params[0], params[1]);
  }
}
