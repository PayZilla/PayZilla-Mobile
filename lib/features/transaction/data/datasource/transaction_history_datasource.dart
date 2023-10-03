import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

abstract class ITransactionHistoryRemoteDataSource {
  Future<TransactionData> getTransactionHistory(int pageNum);
  Future<SingleTransactionModel> getTransaction(String ref);
  Future<dynamic> getTransactionOverview();
}

class TransactionHistoryRemoteDataSource
    implements ITransactionHistoryRemoteDataSource {
  TransactionHistoryRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<TransactionData> getTransactionHistory(int pageNum) async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(transactionsEndpoints.getTransactions(pageNum)),
      );
      if (response.isResultOk) {
        return TransactionData.fromJson(response.data);
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future getTransactionOverview() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(transactionsEndpoints.getTransactionsOverview),
      );
      if (response.isResultOk) {
        return response.data;
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<SingleTransactionModel> getTransaction(String ref) async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(transactionsEndpoints.getTransaction(ref)),
      );
      if (response.isResultOk) {
        return SingleTransactionModel.fromJson(response.data);
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }
}
