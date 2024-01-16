import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/transaction/usecase/transaction_usecase.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TransactionHistoryProvider extends ChangeNotifier {
  TransactionHistoryProvider({
    required TransactionUseCase getTransactionUseCase,
    required GetTransactionUseCase getSingleTransactionUseCase,
  }) {
    _getTransactionUseCase = getTransactionUseCase;
    _getSingleTransactionUseCase = getSingleTransactionUseCase;
  }

  late TransactionUseCase _getTransactionUseCase;
  late GetTransactionUseCase _getSingleTransactionUseCase;

  DeBouncer deBouncer = DeBouncer(milliseconds: 200);
  int pageNumCount = 1;
  int totalHisCount = 0;

  ScrollController? controller;

  List<TransactionModel> _transactionsFetched = [];
  List<TransactionModel> get transactionsFetched => _transactionsFetched;
  set transactionsFetched(List<TransactionModel> value) {
    _transactionsFetched = value;
    notifyListeners();
  }

  ApiResult<List<TransactionModel>> getTransactionsResponse =
      ApiResult<List<TransactionModel>>.idle();

  ApiResult<SingleTransactionModel> getTransactionResponse =
      ApiResult<SingleTransactionModel>.idle();

  SingleTransactionModel _transactionModel = SingleTransactionModel.empty();
  SingleTransactionModel get transactionModel => _transactionModel;
  set transactionModel(SingleTransactionModel value) {
    _transactionModel = value;
    notifyListeners();
  }

  void init(BuildContext context) {
    controller = ScrollController();
    if (controller!.hasClients) {
      controller!.addListener(() {
        fetchMore(pageNumCount, context);
      });
    }
  }

  Future<void> getTransactionHistories({
    int pageNum = 1,
    required BuildContext context,
  }) async {
    getTransactionsResponse =
        ApiResult<List<TransactionModel>>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _getTransactionUseCase.call(pageNum);
    failureOrData.fold(
      (failure) {
        getTransactionsResponse =
            ApiResult<List<TransactionModel>>.error(failure.message);
        showErrorNotification(context, failure.message);
        notifyListeners();
      },
      (res) {
        getTransactionsResponse =
            ApiResult<List<TransactionModel>>.success(res.transactions);
        totalHisCount = res.totalCount;
        if (pageNum == 1) {
          transactionsFetched = [];
          transactionsFetched.addAll(res.transactions);
        } else {
          transactionsFetched.addAll(res.transactions);
        }
        notifyListeners();
      },
    );
  }

  void fetchMore(int pageNum, BuildContext context) {
    if (totalHisCount > transactionsFetched.length) {
      deBouncer.run(() async {
        await getTransactionHistories(pageNum: pageNum, context: context);
        pageNumCount++;
        notifyListeners();
      });
    }
  }

  bool isDetailedVisible = false;
  void isDetailedVisibleMethod({required bool val}) {
    isDetailedVisible = val;
    notifyListeners();
  }

  Future<void> getTransactionHistory(
    String reference,
    BuildContext context,
  ) async {
    getTransactionResponse =
        ApiResult<SingleTransactionModel>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _getSingleTransactionUseCase.call(reference);
    failureOrData.fold(
      (failure) {
        getTransactionResponse =
            ApiResult<SingleTransactionModel>.error(failure.message);
        showErrorNotification(context, failure.message);
        notifyListeners();
      },
      (res) {
        getTransactionResponse = ApiResult<SingleTransactionModel>.success(res);
        transactionModel = res;
        notifyListeners();
      },
    );
  }

  Future<void> onTransactionTapped(
    TransactionModel data,
    BuildContext context,
  ) async {
    transactionModel = SingleTransactionModel.empty();
    isDetailedVisibleMethod(val: true);
    await getTransactionHistory(data.reference, context);
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

  PhosphorIconData iconPicker(String transactionType) {
    switch (transactionType) {
      case 'airtime':
        return PhosphorIcons.globeBold;
      case 'deposit':
        return PhosphorIcons.currencyNgnBold;
      case 'bills_payment':
        return PhosphorIcons.moneyBold;
      case 'transfer':
        return PhosphorIcons.bankBold;
      default:
        return PhosphorIcons.globeBold;
    }
  }
}
