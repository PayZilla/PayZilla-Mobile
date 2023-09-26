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

  ApiResult<List<WalletsModel>> getWalletsResponse =
      ApiResult<List<WalletsModel>>.idle();

  ApiResult<List<BillCatModel>> billResponse =
      ApiResult<List<BillCatModel>>.idle();

  ApiResult<List<BillServiceModel>> billCategoriesResponse =
      ApiResult<List<BillServiceModel>>.idle();

  ApiResult<BillVariantModel> billServiceResponse =
      ApiResult<BillVariantModel>.idle();

  String _convenienceFee = '';
  set convenienceFee(String value) {
    _convenienceFee = value;
    notifyListeners();
  }

  String get convenienceFee => _convenienceFee;

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

    convenienceFee = billServiceResponse.data?.convenienceFee ?? '';
    notifyListeners();
    return billServiceResponse.data?.variations ?? [];
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
        return dataSvg;
      case 'education':
        return schoolSvg;
      default:
        return dataSvg;
    }
  }
}
