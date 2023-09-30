import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

abstract class IBillRemoteDataSource {
  Future<List<BillCatModel>> getCategories();
  Future<List<BillServiceModel>> getCategoryId(String id);
  Future<BillVariantModel> getServiceId(String id);
  Future<String> purchaseAirtime(Map<String, dynamic> data);
  Future<String> verifyBill(BillPaymentDto data);
  Future<String> payBill(BillPaymentDto data);
}

class BillRemoteDataSource implements IBillRemoteDataSource {
  BillRemoteDataSource(this.http);

  final HttpManager http;

  @override
  Future<List<BillCatModel>> getCategories() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.billCategories),
      );
      if (response.isResultOk) {
        final data = response.data as List;

        return data
            .map((e) => BillCatModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<BillServiceModel>> getCategoryId(String id) async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.billCategoryId(id)),
      );
      if (response.isResultOk) {
        final data = response.data as List;
        return data
            .map((e) => BillServiceModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<BillVariantModel> getServiceId(String id) async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.billCategoryServiceId(id)),
      );
      if (response.isResultOk) {
        return BillVariantModel.fromJson(response.data);
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> purchaseAirtime(Map<String, dynamic> data) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(accountEndpoints.payAirtime, data),
      );
      if (response.isResultOk) {
        return response.message;
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> verifyBill(BillPaymentDto data) async {
    Log().debug('what is verified', data.toJson());
    try {
      final response = ResponseDto.fromMap(
        await http.post(accountEndpoints.verifyBill, data.toJson()),
      );
      if (response.isResultOk) {
        return response.message;
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> payBill(BillPaymentDto data) async {
    Log().debug('what is paid', data.toJson());
    try {
      final response = ResponseDto.fromMap(
        await http.post(accountEndpoints.payBill, data.toJson()),
      );
      if (response.isResultOk) {
        return response.message;
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }
}
