import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class TransactionProvider extends ChangeNotifier {
  TransactionProvider({
    required AccountRepository accountTranRepository,
    required CardsRepository cardsRepository,
    required TransferRepository transferRepository,
  }) {
    _accountTranRepository = accountTranRepository;
    _cardsRepository = cardsRepository;
    _transferRepository = transferRepository;

    _plugin.initialize(publicKey: dotenv.env['PAY_STACK_PUBLIC_TEST_KEY']!);
  }

  late AccountRepository _accountTranRepository;
  late CardsRepository _cardsRepository;
  late TransferRepository _transferRepository;
  final _plugin = PaystackPlugin();

  ApiResult<List<CardsModel>> cardsServiceResponse =
      ApiResult<List<CardsModel>>.idle();

  ApiResult<List<BanksModel>> banksServiceResponse =
      ApiResult<List<BanksModel>>.idle();

  ApiResult<WalletOrBankModel> valBanksOrWalletResponse =
      ApiResult<WalletOrBankModel>.idle();

  ApiResult<String> transBanksOrWalletResponse = ApiResult<String>.idle();

  ApiResult<AccountDetailsModel> accountDetailsRES =
      ApiResult<AccountDetailsModel>.idle();

  ApiResult<CardInitiateModel> initializeRefRES =
      ApiResult<CardInitiateModel>.idle();
  ApiResult<String> finalizeAddCardRES = ApiResult<String>.idle();

  Future<void> getAccounts() async {
    accountDetailsRES = ApiResult<AccountDetailsModel>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _accountTranRepository.getAccounts();
    failureOrData.fold(
      (failure) {
        accountDetailsRES =
            ApiResult<AccountDetailsModel>.error(failure.message);
        notifyListeners();
      },
      (res) {
        accountDetailsRES = ApiResult<AccountDetailsModel>.success(res);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> getCards() async {
    cardsServiceResponse = ApiResult<List<CardsModel>>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _cardsRepository.getCards();
    failureOrData.fold(
      (failure) {
        cardsServiceResponse =
            ApiResult<List<CardsModel>>.error(failure.message);
        showErrorNotification(failure.message);
        notifyListeners();
      },
      (res) {
        cardsServiceResponse = ApiResult<List<CardsModel>>.success(res);
        notifyListeners();
      },
    );
  }

  Future<void> initializeCard() async {
    initializeRefRES = ApiResult<CardInitiateModel>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _cardsRepository.initializeCard();
    failureOrData.fold(
      (failure) {
        initializeRefRES = ApiResult<CardInitiateModel>.error(failure.message);
        notifyListeners();
      },
      (res) {
        initializeRefRES = ApiResult<CardInitiateModel>.success(res);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> finalizeAddCard(String refId, BuildContext context) async {
    finalizeAddCardRES = ApiResult<String>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _cardsRepository.finalizeAddCard(refId);
    await failureOrData.fold(
      (failure) {
        finalizeAddCardRES = ApiResult<String>.error(failure.message);
        showErrorNotification(failure.message);
        notifyListeners();
      },
      (res) async {
        await getCards().then((value) {
          finalizeAddCardRES = ApiResult<String>.success(res);
          showSuccessNotification(
            'Card added successfully',
            durationInMills: 3000,
          );
          AppNavigator.of(context).push(AppRoutes.myCard);
        });
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> getBanks() async {
    banksServiceResponse = ApiResult<List<BanksModel>>.loading('Loading...');
    valBanksOrWalletResponse = ApiResult<WalletOrBankModel>.idle();
    notifyListeners();
    final failureOrData = await _transferRepository.getBanks();
    failureOrData.fold(
      (failure) {
        banksServiceResponse =
            ApiResult<List<BanksModel>>.error(failure.message);
        showErrorNotification(failure.message);
        notifyListeners();
      },
      (res) {
        final sortedList = res;
        // ignore: cascade_invocations
        sortedList.sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
        banksServiceResponse = ApiResult<List<BanksModel>>.success(sortedList);
        notifyListeners();
      },
    );
  }

  Future<void> validateBanksOrWallet(ValidateBankOrWalletDto params) async {
    valBanksOrWalletResponse =
        ApiResult<WalletOrBankModel>.loading('Loading...');
    notifyListeners();
    Log().debug('What is validated ', params.toJson());

    final failureOrData =
        await _transferRepository.validateBanksOrWallet(params);
    failureOrData.fold(
      (failure) {
        valBanksOrWalletResponse =
            ApiResult<WalletOrBankModel>.error(failure.message);
        showErrorNotification(failure.message, durationInMills: 3500);
        notifyListeners();
      },
      (res) {
        valBanksOrWalletResponse = ApiResult<WalletOrBankModel>.success(res);
        notifyListeners();
      },
    );
  }

  Future<void> transferBanksOrWallet(ValidateBankOrWalletDto params) async {
    transBanksOrWalletResponse = ApiResult<String>.loading('Loading...');
    notifyListeners();
    Log().debug('What is sent ', params.toJson());
    final failureOrData =
        await _transferRepository.transferBanksOrWallet(params);
    failureOrData.fold(
      (failure) {
        transBanksOrWalletResponse = ApiResult<String>.error(failure.message);
        showErrorNotification(
          failure.message.split(':').last.replaceAll(RegExp(r'[^\w\s]+'), ''),
          durationInMills: 3500,
        );
        notifyListeners();
      },
      (res) {
        transBanksOrWalletResponse = ApiResult<String>.success(res);
        notifyListeners();
      },
    );
  }

  Future<void> initializePayStack(
    String accessCode,
    String email,
    BuildContext context, {
    bool topUp = false,
    int amount = 1000,
  }) async {
    final price = amount * 100;
    final charge = Charge()
      ..amount = price
      ..reference = accessCode
      ..email = email
      ..currency = 'NGN';

    await _plugin
        .checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    )
        .then((value) async {
      if (value.status == true) {
        if (topUp) {
          // send transaction to PayZilla and handle success navigation
        } // if false
        {
          await finalizeAddCard(accessCode, context);
        }
      } else {
        Log().debug('The Paystack error is: $accessCode', value.message);
        AppNavigator.of(context).push(AppRoutes.myCard);
      }
    });
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

  final sampleAmount = [
    '1000',
    '2000',
    '3000',
    '4000',
    '5000',
  ];
}

class CustomWidget extends StatefulWidget {
  const CustomWidget({
    super.key,
    required this.amount,
    required this.isSelected,
    required this.onSelect,
  });
  final String amount;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.dim_16,
          vertical: Insets.dim_8,
        ),
        decoration: BoxDecoration(
          borderRadius: Corners.rsBorder,
          color: widget.isSelected ? AppColors.appGreen : AppColors.borderColor,
        ),
        child: Text(
          widget.amount,
          style: context.textTheme.bodyMedium!.copyWith(
            color:
                widget.isSelected ? AppColors.white : AppColors.textHeaderColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.30,
          ),
        ),
      ),
    );
  }
}
