import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';

class BillRepository extends Repository {
  BillRepository({
    required this.remoteDataSource,
  });

  final IBillRemoteDataSource remoteDataSource;

  Future<Either<Failure, List<BillCatModel>>> getCategories() async {
    return runGuard(() async {
      final response = await remoteDataSource.getCategories();

      return response;
    });
  }

  Future<Either<Failure, List<BillServiceModel>>> getCategoryId(
    String id,
  ) async {
    return runGuard(() async {
      final response = await remoteDataSource.getCategoryId(id);

      return response;
    });
  }

  Future<Either<Failure, BillVariantModel>> getServiceId(String id) async {
    return runGuard(() async {
      final response = await remoteDataSource.getServiceId(id);

      return response;
    });
  }

  Future<Either<Failure, String>> purchaseAirtime(
    Map<String, dynamic> data,
  ) async {
    return runGuard(() async {
      final response = await remoteDataSource.purchaseAirtime(data);

      return response;
    });
  }

  Future<Either<Failure, String>> verifyBill(BillPaymentDto data) async {
    return runGuard(() async {
      final response = await remoteDataSource.verifyBill(data);

      return response;
    });
  }

  Future<Either<Failure, String>> payBill(BillPaymentDto data) async {
    return runGuard(() async {
      final response = await remoteDataSource.payBill(data);

      return response;
    });
  }
}
