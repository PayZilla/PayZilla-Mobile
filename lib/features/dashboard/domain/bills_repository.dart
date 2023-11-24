import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';

abstract class BillRepository {
  Future<Either<ApiFailure, List<BillCatModel>>> getCategories();
  Future<Either<ApiFailure, List<BillServiceModel>>> getCategoryId(String id);
  Future<Either<ApiFailure, BillVariantModel>> getServiceId(String id);
  Future<Either<ApiFailure, String>> purchaseAirtime(
    Map<String, dynamic> data,
  );
  Future<Either<ApiFailure, String>> verifyBill(BillPaymentDto data);
  Future<Either<ApiFailure, String>> payBill(BillPaymentDto data);
}

class BillRepositoryImpl extends BillRepository {
  BillRepositoryImpl({
    required this.remoteDataSource,
  });

  final IBillRemoteDataSource remoteDataSource;

  @override
  Future<Either<ApiFailure, List<BillCatModel>>> getCategories() async {
    return remoteDataSource.getCategories();
  }

  @override
  Future<Either<ApiFailure, List<BillServiceModel>>> getCategoryId(
    String id,
  ) async {
    return remoteDataSource.getCategoryId(id);
  }

  @override
  Future<Either<ApiFailure, BillVariantModel>> getServiceId(String id) async {
    return remoteDataSource.getServiceId(id);
  }

  @override
  Future<Either<ApiFailure, String>> purchaseAirtime(
    Map<String, dynamic> data,
  ) async {
    return remoteDataSource.purchaseAirtime(data);
  }

  @override
  Future<Either<ApiFailure, String>> verifyBill(BillPaymentDto data) async {
    return remoteDataSource.verifyBill(data);
  }

  @override
  Future<Either<ApiFailure, String>> payBill(BillPaymentDto data) async {
    return remoteDataSource.payBill(data);
  }
}
