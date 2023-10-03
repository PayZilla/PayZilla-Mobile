import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

class TransactionHistoryRepository extends Repository {
  TransactionHistoryRepository({
    required this.remoteDataSource,
  });

  final ITransactionHistoryRemoteDataSource remoteDataSource;

  Future<Either<Failure, TransactionData>> getTransactionHistory(
    int pageNum,
  ) async {
    return runGuard(() async {
      final response = await remoteDataSource.getTransactionHistory(pageNum);

      return response;
    });
  }

  Future<Either<Failure, dynamic>> getTransactionOverview() async {
    return runGuard(() async {
      final response = await remoteDataSource.getTransactionOverview();

      return response;
    });
  }

  Future<Either<Failure, SingleTransactionModel>> getTransaction(
      String ref) async {
    return runGuard(() async {
      final response = await remoteDataSource.getTransaction(ref);

      return response;
    });
  }
}
