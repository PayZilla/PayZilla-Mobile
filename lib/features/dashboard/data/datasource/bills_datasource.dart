import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

abstract class IBillRemoteDataSource {
  Future<Either<ApiFailure, List<BillCatModel>>> getCategories();
  Future<Either<ApiFailure, List<BillServiceModel>>> getCategoryId(String id);
  Future<Either<ApiFailure, BillVariantModel>> getServiceId(String id);
  Future<Either<ApiFailure, String>> purchaseAirtime(Map<String, dynamic> data);
  Future<Either<ApiFailure, String>> verifyBill(BillPaymentDto data);
  Future<Either<ApiFailure, String>> payBill(BillPaymentDto data);
}

class BillRemoteDataSource implements IBillRemoteDataSource {
  BillRemoteDataSource(this.http);

  final HttpManager http;

  @override
  Future<Either<ApiFailure, List<BillCatModel>>> getCategories() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.billCategories),
      );

      return Right(
        (response.data as List)
            .map((e) => BillCatModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, List<BillServiceModel>>> getCategoryId(
    String id,
  ) async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.billCategoryId(id)),
      );

      return Right(
        (response.data as List)
            .map((e) => BillServiceModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, BillVariantModel>> getServiceId(String id) async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.billCategoryServiceId(id)),
      );

      return Right(BillVariantModel.fromJson(response.data));
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, String>> purchaseAirtime(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(accountEndpoints.payAirtime, data),
      );
      return Right(response.message);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, String>> verifyBill(BillPaymentDto data) async {
    Log().debug('what is verified', data.toJson());
    try {
      final response = ResponseDto.fromMap(
        await http.post(accountEndpoints.verifyBill, data.toJson()),
      );

      return Right(response.data['customerName']);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, String>> payBill(BillPaymentDto data) async {
    Log().debug('what is paid', data.toJson());
    try {
      final response = ResponseDto.fromMap(
        await http.post(accountEndpoints.payBill, data.toJson()),
      );
      return Right(response.message);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }
}
