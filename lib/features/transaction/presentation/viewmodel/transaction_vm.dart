import 'package:flutter/foundation.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class TransactionProvider extends ChangeNotifier {
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

  bool isDetailedVisible = false;
  void isDetailedVisibleMethod({required bool val}) {
    isDetailedVisible = val;
    notifyListeners();
  }

  Future<void> onTransactionTapped(int index) async {
    Log().debug('The transaction tapped', index);
    isDetailedVisibleMethod(val: true);
    notifyListeners();
  }
}
