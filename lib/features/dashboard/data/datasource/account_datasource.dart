import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

abstract class IAccountRemoteDataSource {
  Future<List<WalletsModel>> getWallets();
  Future<AccountDetailsModel> getAccounts();

  Future<List<ContactsModel>> getContacts(List<String> contacts);
}

class AccountRemoteDataSource implements IAccountRemoteDataSource {
  AccountRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<List<WalletsModel>> getWallets() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.getWallets),
      );
      if (response.isResultOk) {
        final data = response.data as List;
        return data.map((e) => WalletsModel.fromJson(e)).toList();
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<AccountDetailsModel> getAccounts() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.getAccountDetails),
      );
      if (response.isResultOk) {
        return AccountDetailsModel.fromJson(response.data);
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<ContactsModel>> getContacts(List<String> contacts) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          accountEndpoints.getContacts,
          {'contacts': contacts},
        ),
      );
      if (response.isResultOk) {
        final data = response.data as List;
        return data.map((e) => ContactsModel.fromJson(e)).toList();
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }
}
