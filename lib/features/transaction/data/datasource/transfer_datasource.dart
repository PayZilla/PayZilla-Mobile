import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

abstract class ITransferRemoteDataSource {
  Future<List<BanksModel>> getBanks();
  Future<WalletOrBankModel> validateBanksOrWallet(
    ValidateBankOrWalletDto params,
  );
  Future<String> transferBanksOrWallet(ValidateBankOrWalletDto params);
}

class TransferRemoteDataSource implements ITransferRemoteDataSource {
  TransferRemoteDataSource(this.http);
  final HttpManager http;
  @override
  Future<List<BanksModel>> getBanks() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(transferEndpoints.getBanks),
      );
      if (response.isResultOk) {
        final data = response.data as List;
        return data
            .map((e) => BanksModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> transferBanksOrWallet(ValidateBankOrWalletDto params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          transferEndpoints.transferBanksOrWallet,
          params.toJson(),
        ),
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
  Future<WalletOrBankModel> validateBanksOrWallet(
    ValidateBankOrWalletDto params,
  ) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          transferEndpoints.validateBanksOrWallet,
          params.toJson(),
        ),
      );
      if (response.isResultOk) {
        return WalletOrBankModel.fromJson(response.data);
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }
}
