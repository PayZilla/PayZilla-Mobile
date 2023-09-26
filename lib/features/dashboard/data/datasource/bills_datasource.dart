import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';

abstract class IBillRemoteDataSource {
  Future<List<BillCatModel>> getCategories();
  Future<List<BillServiceModel>> getCategoryId(String id);
  Future<BillVariantModel> getServiceId(String id);
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

        return data.map((e) => BillCatModel.fromJson(e)).toList();
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
        return data.map((e) => BillServiceModel.fromJson(e)).toList();
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
}
