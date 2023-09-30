import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

abstract class ITransactionHistoryRemoteDataSource {
  Future<List<TransactionModel>> getTransactionHistory();
  Future<dynamic> getTransactionOverview();
}

class TransactionHistoryRemoteDataSource
    implements ITransactionHistoryRemoteDataSource {
  TransactionHistoryRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<List<TransactionModel>> getTransactionHistory() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(transactionsEndpoints.getTransactions),
      );
      if (response.isResultOk) {
        final data = response.data['transactions'] as List;
        return data
            .map((e) => TransactionModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
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
}
