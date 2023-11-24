import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

abstract class TransactionHistoryRepository {
  Future<Either<ApiFailure, TransactionData>> getTransactionHistory(
    int pageNum,
  );
  Future<Either<ApiFailure, dynamic>> getTransactionOverview();
  Future<Either<ApiFailure, SingleTransactionModel>> getTransaction(String ref);
}

class TransactionHistoryRepositoryImpl extends TransactionHistoryRepository {
  TransactionHistoryRepositoryImpl({
    required this.remoteDataSource,
  });

  final ITransactionHistoryRemoteDataSource remoteDataSource;

  @override
  Future<Either<ApiFailure, TransactionData>> getTransactionHistory(
    int pageNum,
  ) async {
    return remoteDataSource.getTransactionHistory(pageNum);
  }

  @override
  Future<Either<ApiFailure, dynamic>> getTransactionOverview() async {
    return remoteDataSource.getTransactionOverview();
  }

  @override
  Future<Either<ApiFailure, SingleTransactionModel>> getTransaction(
      String ref) async {
    return remoteDataSource.getTransaction(ref);
  }
}
