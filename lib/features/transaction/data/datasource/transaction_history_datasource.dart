import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

abstract class ITransactionHistoryRemoteDataSource {
  Future<Either<ApiFailure, TransactionData>> getTransactionHistory(
    int pageNum,
  );
  Future<Either<ApiFailure, SingleTransactionModel>> getTransaction(String ref);
  Future<Either<ApiFailure, dynamic>> getTransactionOverview();
}

class TransactionHistoryRemoteDataSource
    implements ITransactionHistoryRemoteDataSource {
  TransactionHistoryRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<Either<ApiFailure, TransactionData>> getTransactionHistory(
    int pageNum,
  ) async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(transactionsEndpoints.getTransactions(pageNum)),
      );

      return Right(TransactionData.fromJson(response.data));
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, dynamic>> getTransactionOverview() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(transactionsEndpoints.getTransactionsOverview),
      );
      return Right(response.status);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, SingleTransactionModel>> getTransaction(
    String ref,
  ) async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(transactionsEndpoints.getTransaction(ref)),
      );

      return Right(SingleTransactionModel.fromJson(response.data));
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }
}
