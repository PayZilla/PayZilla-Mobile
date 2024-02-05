import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/dashboard/usecase/acount_usecases.dart';
import 'package:pay_zilla/features/dashboard/usecase/cards_usecase.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/transaction/usecase/transfer_usecase.dart';
import 'package:pay_zilla/features/ui_widgets/image.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:flutter_paystack_payment/flutter_paystack_payment.dart';

class TransactionProvider extends ChangeNotifier {
  TransactionProvider({
    required GetAccountsUseCase accountTranUseCases,
    required GetWalletsUseCase getWalletsUseCase,
    required GetCardsUseCase cardsUseCase,
    required TransferUseCase transferUseCase,
    required DeleteCardsUseCase deleteCardsUseCase,
    required InitCardsUseCase initCardsUseCase,
    required ChargeCardsUseCase chargeCardsUseCase,
    required FinalizeCardsUseCase finalizeCardsUseCase,
    required ValidateBankUseCase validateBankUseCase,
    required TransferWalletBankUseCase transferWalletBankUseCase,
  }) {
    _accountTranUseCases = accountTranUseCases;
    _getWalletsUseCase = getWalletsUseCase;
    _getCardsUseCase = cardsUseCase;
    _transferUseCase = transferUseCase;
    _deleteCardsUseCase = deleteCardsUseCase;
    _initCardsUseCase = initCardsUseCase;
    _chargeCardsUseCase = chargeCardsUseCase;
    _finalizeCardsUseCase = finalizeCardsUseCase;
    _validateBankUseCase = validateBankUseCase;
    _transferWalletBankUseCase = transferWalletBankUseCase;

    _plugin.initialize(publicKey: dotenv.env['PAY_STACK_PUBLIC_LIVE_KEY']!);
  }

  late GetAccountsUseCase _accountTranUseCases;
  late GetWalletsUseCase _getWalletsUseCase;
  late GetCardsUseCase _getCardsUseCase;
  late DeleteCardsUseCase _deleteCardsUseCase;
  late InitCardsUseCase _initCardsUseCase;
  late ChargeCardsUseCase _chargeCardsUseCase;
  late FinalizeCardsUseCase _finalizeCardsUseCase;
  late TransferUseCase _transferUseCase;
  late ValidateBankUseCase _validateBankUseCase;
  late TransferWalletBankUseCase _transferWalletBankUseCase;
  final _plugin = PaystackPayment();

  ApiResult<List<MultiSelectItem<CardsModel>>> cardsServiceResponse =
      ApiResult<List<MultiSelectItem<CardsModel>>>.idle();

  ApiResult<List<BanksModel>> banksServiceResponse =
      ApiResult<List<BanksModel>>.idle();

  ApiResult<WalletOrBankModel> valBanksOrWalletResponse =
      ApiResult<WalletOrBankModel>.idle();

  ApiResult<String> transBanksOrWalletResponse = ApiResult<String>.idle();

  ApiResult<AccountDetailsModel> accountDetailsRES =
      ApiResult<AccountDetailsModel>.idle();

  ApiResult<CardInitiateModel> initializeRefRES =
      ApiResult<CardInitiateModel>.idle();
  ApiResult<bool> finalizeAddCardRES = ApiResult<bool>.idle();
  ApiResult<bool> deleteCardRES = ApiResult<bool>.idle();
  ApiResult<bool> chargeCardRES = ApiResult<bool>.idle();

  Future<void> getAccounts(BuildContext context) async {
    accountDetailsRES = ApiResult<AccountDetailsModel>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _accountTranUseCases.call(NoParams());
    failureOrData.fold(
      (failure) {
        accountDetailsRES =
            ApiResult<AccountDetailsModel>.error(failure.message);
        notifyListeners();
      },
      (res) {
        accountDetailsRES = ApiResult<AccountDetailsModel>.success(res);
        if (!res.hasSetPin) {
          showInfoNotification(context, 'Set account transaction pin');
          AppNavigator.of(context).push(AppRoutes.fromHomeToPin);
        }
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> getCards(BuildContext context) async {
    cardsServiceResponse =
        ApiResult<List<MultiSelectItem<CardsModel>>>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _getCardsUseCase.call(NoParams());
    failureOrData.fold(
      (failure) {
        cardsServiceResponse =
            ApiResult<List<MultiSelectItem<CardsModel>>>.error(failure.message);
        showErrorNotification(context, failure.message);
        notifyListeners();
      },
      (res) {
        cardsServiceResponse =
            ApiResult<List<MultiSelectItem<CardsModel>>>.success(res);
        notifyListeners();
      },
    );
  }

  Future<void> deleteCard(int cardId, BuildContext context) async {
    deleteCardRES = ApiResult<bool>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _deleteCardsUseCase.call(cardId);
    await failureOrData.fold(
      (failure) {
        deleteCardRES = ApiResult<bool>.error(failure.message);
        showErrorNotification(context, failure.message);
        notifyListeners();
      },
      (res) async {
        deleteCardRES = ApiResult<bool>.success(res);
        await getCards(context);
        notifyListeners();
      },
    );
  }

  Future<void> initializeCard() async {
    initializeRefRES = ApiResult<CardInitiateModel>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _initCardsUseCase.call(NoParams());
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

  Future<void> chargeCard(int amount, int cardId, BuildContext context) async {
    chargeCardRES = ApiResult<bool>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _chargeCardsUseCase.call([amount, cardId]);
    await failureOrData.fold(
      (failure) {
        chargeCardRES = ApiResult<bool>.error(failure.message);
        showErrorNotification(
          context,
          failure.message.removeSpecialCharactersOnError(),
          durationInMills: 3500,
        );
        notifyListeners();
      },
      (res) async {
        showSuccessNotification(
          context,
          'Card charge successfully',
          durationInMills: 3000,
        );
        await _getWalletsUseCase.call(NoParams());
        chargeCardRES = ApiResult<bool>.success(res);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> finalizeAddCard(String refId, BuildContext context) async {
    finalizeAddCardRES = ApiResult<bool>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _finalizeCardsUseCase.call(refId);
    await failureOrData.fold(
      (failure) {
        finalizeAddCardRES = ApiResult<bool>.error(failure.message);
        showErrorNotification(context, failure.message);
        notifyListeners();
      },
      (res) async {
        await getCards(context).then((value) {
          finalizeAddCardRES = ApiResult<bool>.success(res);
          showSuccessNotification(
            context,
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

  Future<void> getBanks(BuildContext context) async {
    banksServiceResponse = ApiResult<List<BanksModel>>.loading('Loading...');
    valBanksOrWalletResponse = ApiResult<WalletOrBankModel>.idle();
    notifyListeners();
    final failureOrData = await _transferUseCase.call(NoParams());
    failureOrData.fold(
      (failure) {
        banksServiceResponse =
            ApiResult<List<BanksModel>>.error(failure.message);
        showErrorNotification(context, failure.message);
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

  Future<void> validateBanksOrWallet(
      ValidateBankOrWalletDto params, BuildContext context) async {
    valBanksOrWalletResponse =
        ApiResult<WalletOrBankModel>.loading('Loading...');
    notifyListeners();
    Log().debug('What is validated ', params.toJson());

    final failureOrData = await _validateBankUseCase.call(params);
    failureOrData.fold(
      (failure) {
        valBanksOrWalletResponse =
            ApiResult<WalletOrBankModel>.error(failure.message);
        showErrorNotification(context, failure.message, durationInMills: 3500);
        notifyListeners();
      },
      (res) {
        valBanksOrWalletResponse = ApiResult<WalletOrBankModel>.success(res);
        notifyListeners();
      },
    );
  }

  Future<void> transferBanksOrWallet(
      ValidateBankOrWalletDto params, BuildContext context) async {
    transBanksOrWalletResponse = ApiResult<String>.loading('Loading...');
    notifyListeners();
    final failureOrData = await _transferWalletBankUseCase.call(params);
    failureOrData.fold(
      (failure) {
        transBanksOrWalletResponse = ApiResult<String>.error(failure.message);
        showErrorNotification(
          context,
          failure.message.removeSpecialCharactersOnError(),
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
    String referenceId,
    String accessCode,
    String email,
    BuildContext context, {
    bool topUp = false,
    int amount = 0,
  }) async {
    final price = amount * 100;
    final charge = Charge()
      ..amount = price
      ..accessCode = accessCode
      ..email = email
      ..currency = 'NGN';

    await _plugin
        .checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
      logo: LocalImage(
        logoPng,
        width: 50,
        height: 50,
      ),
    )
        .then((value) async {
      if (value.status == true) {
        if (topUp) {
          // send transaction to PayZilla and handle success navigation
        } // if false
        {
          await finalizeAddCard(referenceId, context);
        }
      } else {
        AppNavigator.of(context).push(AppRoutes.myCard);
      }
    });
  }

  final sampleAmount = [
    '1000',
    '2000',
    '3000',
    '4000',
    '5000',
  ];

  Widget buildLogo(String logo) {
    if (logo.toLowerCase().contains('mastercard')) {
      return LocalImage(masterCardPng, width: 30, height: 30);
    } else if (logo.toLowerCase().contains('visa')) {
      return LocalImage(visaCardPng, width: 30, height: 30);
    } else if (logo.toLowerCase().contains('verve')) {
      return LocalSvgImage(verveCardSvg, width: 30, height: 30);
    } else {
      return LocalSvgImage(atmLogoSvg, width: 30, height: 30);
    }
  }
}
