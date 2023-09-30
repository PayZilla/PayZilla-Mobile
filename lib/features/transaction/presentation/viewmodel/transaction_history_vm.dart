import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class TransactionHistoryProvider extends ChangeNotifier {
  TransactionHistoryProvider({
    required TransactionHistoryRepository historyRepository,
  }) {
    _historyRepository = historyRepository;
  }

  late TransactionHistoryRepository _historyRepository;

  ApiResult<List<TransactionModel>> getTransactionsResponse =
      ApiResult<List<TransactionModel>>.idle();

  TransactionModel _transactionModel = TransactionModel.empty();
  TransactionModel get transactionModel => _transactionModel;
  set transactionModel(TransactionModel value) {
    _transactionModel = value;
    notifyListeners();
  }

  Future<void> getTransactionHistory() async {
    getTransactionsResponse =
        ApiResult<List<TransactionModel>>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _historyRepository.getTransactionHistory();
    failureOrData.fold(
      (failure) {
        getTransactionsResponse =
            ApiResult<List<TransactionModel>>.error(failure.message);
        showErrorNotification(failure.message);
        notifyListeners();
      },
      (res) {
        getTransactionsResponse =
            ApiResult<List<TransactionModel>>.success(res);
        notifyListeners();
      },
    );
  }

  bool isDetailedVisible = false;
  void isDetailedVisibleMethod({required bool val}) {
    isDetailedVisible = val;
    notifyListeners();
  }

  Future<void> onTransactionTapped(TransactionModel data) async {
    isDetailedVisibleMethod(val: true);
    transactionModel = data;
    notifyListeners();
  }

  bool isBalanceVisible = false;
  void isVisibleMethod({required bool val}) {
    isBalanceVisible = val;
    notifyListeners();
  }

  bool isSearchVisible = false;
  void isSearchVisibleMethod({required bool val}) {
    isSearchVisible = val;
    notifyListeners();
  }
}
