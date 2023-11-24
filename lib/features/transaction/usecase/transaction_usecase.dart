// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:pay_zilla/core/error/failure.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

class TransactionUseCase extends UseCase<TransactionData, int> {
  TransactionHistoryRepository transactionHistoryRepository;
  TransactionUseCase({
    required this.transactionHistoryRepository,
  });
  @override
  Future<Either<ApiFailure, TransactionData>> call(int params) {
    return transactionHistoryRepository.getTransactionHistory(params);
  }
}

class TransactionOverviewUseCase extends UseCase<dynamic, NoParams> {
  TransactionHistoryRepository transactionHistoryRepository;
  TransactionOverviewUseCase({
    required this.transactionHistoryRepository,
  });
  @override
  Future<Either<ApiFailure, dynamic>> call(NoParams params) {
    return transactionHistoryRepository.getTransactionOverview();
  }
}

class GetTransactionUseCase extends UseCase<SingleTransactionModel, String> {
  TransactionHistoryRepository transactionHistoryRepository;
  GetTransactionUseCase({
    required this.transactionHistoryRepository,
  });
  @override
  Future<Either<ApiFailure, SingleTransactionModel>> call(String params) {
    return transactionHistoryRepository.getTransaction(params);
  }
}
