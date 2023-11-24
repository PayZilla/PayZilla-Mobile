import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';

class GetCatsUseCase implements UseCase<List<BillCatModel>, NoParams> {
  GetCatsUseCase({required this.billsRepository});
  BillRepository billsRepository;

  @override
  Future<Either<ApiFailure, List<BillCatModel>>> call(NoParams params) {
    return billsRepository.getCategories();
  }
}

class GetCatsIDUseCase implements UseCase<List<BillServiceModel>, String> {
  GetCatsIDUseCase({required this.billsRepository});
  BillRepository billsRepository;

  @override
  Future<Either<ApiFailure, List<BillServiceModel>>> call(String params) {
    return billsRepository.getCategoryId(params);
  }
}

class GetServiceIdUseCase implements UseCase<BillVariantModel, String> {
  GetServiceIdUseCase({required this.billsRepository});
  BillRepository billsRepository;

  @override
  Future<Either<ApiFailure, BillVariantModel>> call(String params) {
    return billsRepository.getServiceId(params);
  }
}

class PurchaseUseCase implements UseCase<String, Map<String, dynamic>> {
  PurchaseUseCase({required this.billsRepository});
  BillRepository billsRepository;

  @override
  Future<Either<ApiFailure, String>> call(Map<String, dynamic> params) {
    return billsRepository.purchaseAirtime(params);
  }
}

class VerifyUseCase implements UseCase<String, BillPaymentDto> {
  VerifyUseCase({required this.billsRepository});
  BillRepository billsRepository;

  @override
  Future<Either<ApiFailure, String>> call(BillPaymentDto params) {
    return billsRepository.verifyBill(params);
  }
}

class PayBillUseCase implements UseCase<String, BillPaymentDto> {
  PayBillUseCase({required this.billsRepository});
  BillRepository billsRepository;

  @override
  Future<Either<ApiFailure, String>> call(BillPaymentDto params) {
    return billsRepository.payBill(params);
  }
}
