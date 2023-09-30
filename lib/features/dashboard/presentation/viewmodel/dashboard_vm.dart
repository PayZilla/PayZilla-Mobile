import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider({
    required this.billRepository,
    required this.cardsRepository,
    required this.accountRepository,
  });

  final BillRepository billRepository;
  final CardsRepository cardsRepository;
  final AccountRepository accountRepository;

  // Airtime bills TEC
  final amountController = TextEditingController();
  final phoneController = TextEditingController();
  final pinController = TextEditingController();

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
    final failureOrCat = await accountRepository.getWallets();
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
    final failureOrCat = await billRepository.getCategories();
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

  Future<List<BillServiceModel>> getCategoryId(String id) async {
    billCategoriesResponse =
        ApiResult<List<BillServiceModel>>.loading('Loading...');

    final failureOrCat = await billRepository.getCategoryId(id);
    failureOrCat.fold(
      (failure) {
        billCategoriesResponse =
            ApiResult<List<BillServiceModel>>.error(failure.message);
        showErrorNotification(failure.message);
      },
      (res) {
        billCategoriesResponse = ApiResult<List<BillServiceModel>>.success(res);
      },
    );
    notifyListeners();
    return billCategoriesResponse.data ?? [];
  }

  Future<List<Variations>> getServiceId(String id) async {
    billServiceResponse = ApiResult<BillVariantModel>.loading('Loading...');

    final failureOrCat = await billRepository.getServiceId(id);
    failureOrCat.fold(
      (failure) {
        billServiceResponse =
            ApiResult<BillVariantModel>.error(failure.message);
        showErrorNotification(failure.message);
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

  Future<void> purchaseAirtime() async {
    var data = BillPaymentDto.empty();
    data = data.copyWith(
      phoneNumber: phoneController.text,
      amount: amountController.text.toInt() *
          100, //Note: this is because it is received in kobo and we are converting it to Naira
      pin: pinController.text,
    );
    payBillResponse = ApiResult<String>.loading('Loading...');
    notifyListeners();
    final failureOrCat = await billRepository.purchaseAirtime(data.toJson());
    failureOrCat.fold(
      (failure) {
        payBillResponse = ApiResult<String>.error(failure.message);
        showErrorNotification(failure.message);
        notifyListeners();
      },
      (res) {
        payBillResponse = ApiResult<String>.success(res);
        showSuccessNotification(res);
        notifyListeners();
      },
    );
  }

  Future<void> verifyBill(BillPaymentDto data) async {
    payBillResponse = ApiResult<String>.idle();
    payBillResponse = ApiResult<String>.loading('Loading...');
    notifyListeners();
    final failureOrCat = await billRepository.verifyBill(data);
    failureOrCat.fold(
      (failure) {
        payBillResponse = ApiResult<String>.error(failure.message);
        showErrorNotification(failure.message);
        notifyListeners();
      },
      (res) {
        payBillResponse = ApiResult<String>.success(res);
        showSuccessNotification(res);
        notifyListeners();
      },
    );
  }

  Future<void> payBill(BillPaymentDto data) async {
    billPaymentRES = ApiResult<String>.loading('Loading...');
    notifyListeners();
    final failureOrCat = await billRepository.payBill(data);
    failureOrCat.fold(
      (failure) {
        billPaymentRES = ApiResult<String>.error(failure.message);
        showErrorNotification(
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
