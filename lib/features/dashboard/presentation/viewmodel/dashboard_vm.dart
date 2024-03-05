import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/dashboard/usecase/acount_usecases.dart';
import 'package:pay_zilla/features/dashboard/usecase/bills_usecase.dart';
import 'package:pay_zilla/features/dashboard/usecase/cards_usecase.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider({
    required this.getWalletsUseCase,
    required this.getContactsUseCase,
    required this.getAccountsUseCase,
    required this.getCatsUseCase,
    required this.getCatsIDUseCase,
    required this.getServiceIdUseCase,
    required this.purchaseUseCase,
    required this.verifyUseCase,
    required this.payBillUseCase,
    required this.getCardsUseCase,
    required this.initCardsUseCase,
    required this.finalizeCardsUseCase,
    required this.deleteCardsUseCase,
    required this.chargeCardsUseCase,
    required this.localDataSource,
  });

// account
  GetWalletsUseCase getWalletsUseCase;
  GetContactsUseCase getContactsUseCase;
  GetAccountsUseCase getAccountsUseCase;
// bills
  GetCatsUseCase getCatsUseCase;
  GetCatsIDUseCase getCatsIDUseCase;
  GetServiceIdUseCase getServiceIdUseCase;
  PurchaseUseCase purchaseUseCase;
  VerifyUseCase verifyUseCase;
  PayBillUseCase payBillUseCase;
// cards
  GetCardsUseCase getCardsUseCase;
  InitCardsUseCase initCardsUseCase;
  FinalizeCardsUseCase finalizeCardsUseCase;
  DeleteCardsUseCase deleteCardsUseCase;
  ChargeCardsUseCase chargeCardsUseCase;

  // local
  final IAuthLocalDataSource localDataSource;

  // Airtime bills TEC
  final amountController = TextEditingController();
  final phoneController = TextEditingController();
  final pinController = TextEditingController();

  bool _showBalance = true;
  bool get showBalance => _showBalance;
  set showBalance(bool value) {
    _showBalance = value;
    notifyListeners();
  }

  bool _showBvnRequest = false;
  bool get showBvnRequest => _showBvnRequest;
  set showBvnRequest(bool value) {
    _showBvnRequest = value;
    notifyListeners();
  }

  ApiResult<List<WalletsModel>> getWalletsResponse =
      ApiResult<List<WalletsModel>>.idle();

  ApiResult<List<BillCatModel>> billResponse =
      ApiResult<List<BillCatModel>>.idle();

  ApiResult<List<BillServiceModel>> billCategoriesResponse =
      ApiResult<List<BillServiceModel>>.idle();

  ApiResult<BillVariantModel> billServiceResponse =
      ApiResult<BillVariantModel>.idle();

  ApiResult<String> payBillResponse = ApiResult<String>.idle();
  ApiResult<String> billPaymentRES = ApiResult<String>.idle();
  BillVariantModel model = BillVariantModel.empty();

  Future<void> getWallets() async {
    getWalletsResponse = ApiResult<List<WalletsModel>>.loading('Loading...');
    notifyListeners();
    final failureOrCat = await getWalletsUseCase.call(NoParams());
    failureOrCat.fold(
      (failure) {
        getWalletsResponse =
            ApiResult<List<WalletsModel>>.error(failure.message);

        notifyListeners();
      },
      (res) {
        getWalletsResponse = ApiResult<List<WalletsModel>>.success(res);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> getCategories() async {
    billResponse = ApiResult<List<BillCatModel>>.loading('Loading...');
    notifyListeners();
    final failureOrCat = await getCatsUseCase.call(NoParams());
    failureOrCat.fold(
      (failure) {
        billResponse = ApiResult<List<BillCatModel>>.error(failure.message);
        notifyListeners();
      },
      (res) {
        billResponse = ApiResult<List<BillCatModel>>.success(res);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<List<BillServiceModel>> getCategoryId(
      String id, BuildContext context) async {
    billCategoriesResponse =
        ApiResult<List<BillServiceModel>>.loading('Loading...');

    final failureOrCat = await getCatsIDUseCase.call(id);
    failureOrCat.fold(
      (failure) {
        billCategoriesResponse =
            ApiResult<List<BillServiceModel>>.error(failure.message);
        showErrorNotification(context, failure.message);
        notifyListeners();
      },
      (res) {
        billCategoriesResponse = ApiResult<List<BillServiceModel>>.success(res);
      },
    );
    notifyListeners();
    return billCategoriesResponse.data ?? [];
  }

  Future<List<Variations>> getServiceId(String id, BuildContext context) async {
    billServiceResponse = ApiResult<BillVariantModel>.loading('Loading...');

    final failureOrCat = await getServiceIdUseCase.call(id);
    failureOrCat.fold(
      (failure) {
        billServiceResponse =
            ApiResult<BillVariantModel>.error(failure.message);
        showErrorNotification(context, failure.message);
        notifyListeners();
      },
      (res) {
        billServiceResponse = ApiResult<BillVariantModel>.success(res);
      },
    );

    model = model.copyWith(
      serviceId: id,
      serviceName: billServiceResponse.data?.serviceName ?? '',
      convenienceFee: billServiceResponse.data?.convenienceFee ?? '',
      variations: billServiceResponse.data?.variations ?? [],
    );

    notifyListeners();
    return model.variations;
  }

  void clearTEC() {
    amountController.clear();
    phoneController.clear();
    pinController.clear();
    payBillResponse = ApiResult<String>.idle();
  }

  Future<void> purchaseAirtime(BuildContext context) async {
    var data = BillPaymentDto.empty();
    data = data.copyWith(
      phoneNumber: phoneController.text,
      amount: amountController.text.toInt() *
          100, //Note: this is because it is received in kobo and we are converting it to Naira
      pin: pinController.text,
    );
    payBillResponse = ApiResult<String>.loading('Loading...');
    notifyListeners();
    final failureOrCat = await purchaseUseCase.call(data.toJson());
    failureOrCat.fold(
      (failure) {
        payBillResponse = ApiResult<String>.error(failure.message);
        showErrorNotification(context, failure.message);
        notifyListeners();
      },
      (res) {
        payBillResponse = ApiResult<String>.success(res);
        showSuccessNotification(context, res);
        notifyListeners();
      },
    );
  }

  Future<void> verifyBill(BillPaymentDto data, BuildContext context) async {
    payBillResponse = ApiResult<String>.idle();
    payBillResponse = ApiResult<String>.loading('Loading...');
    notifyListeners();
    final failureOrCat = await verifyUseCase.call(data);
    failureOrCat.fold(
      (failure) {
        payBillResponse = ApiResult<String>.error(failure.message);
        showErrorNotification(context, failure.message);
        notifyListeners();
      },
      (res) {
        payBillResponse = ApiResult<String>.success(res);
        showSuccessNotification(context, res);
        notifyListeners();
      },
    );
  }

  Future<void> payBill(BillPaymentDto data, BuildContext context) async {
    billPaymentRES = ApiResult<String>.loading('Loading...');
    notifyListeners();
    final failureOrCat = await payBillUseCase.call(data);
    failureOrCat.fold(
      (failure) {
        billPaymentRES = ApiResult<String>.error(failure.message);
        showErrorNotification(
          context,
          failure.message,
          durationInMills: 3500,
        );
        notifyListeners();
      },
      (res) {
        billPaymentRES = ApiResult<String>.success(res);
        notifyListeners();
      },
    );
  }

  void goTo(String routeName, BuildContext context) {
    AppNavigator.of(context).push(routeName);
  }

  String assetIcon(String identifier) {
    switch (identifier) {
      case 'electricity-bill':
        return electricitySvg;
      case 'tv-subscription':
        return tvSvg;
      case 'data':
        return internetSvg;
      case 'education':
        return schoolSvg;
      case 'airtime':
        return dataSvg;
      default:
        return dataSvg;
    }
  }

  final transferOptions = [
    TransferOption(
      img: r3,
      title: 'PayZilla User',
      desc: 'Send money to PayZilla User',
    ),
    TransferOption(
      img: moreSvg,
      title: 'Others',
      desc: 'Send money to Others using PayZilla',
    ),
  ];
}
// transfer option

class TransferOption {
  TransferOption({
    required this.img,
    required this.title,
    required this.desc,
  });
  final String title;
  final String desc;
  final String img;
}
