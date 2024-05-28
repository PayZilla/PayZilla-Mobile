import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

abstract class ITransferRemoteDataSource {
  Future<Either<ApiFailure, List<BanksModel>>> getBanks();
  Future<Either<ApiFailure, WalletOrBankModel>> validateBanksOrWallet(
    ValidateBankOrWalletDto params,
  );
  Future<Either<ApiFailure, String>> transferBanksOrWallet(
    ValidateBankOrWalletDto params,
  );
}

class TransferRemoteDataSource implements ITransferRemoteDataSource {
  TransferRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<Either<ApiFailure, List<BanksModel>>> getBanks() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(transferEndpoints.getBanks),
      );

      return Right(
        (response.data as List)
            .map((e) => BanksModel.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, String>> transferBanksOrWallet(
      ValidateBankOrWalletDto params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          transferEndpoints.transferBanksOrWallet,
          params.toJson(),
        ),
      );

      return Right(response.message);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, WalletOrBankModel>> validateBanksOrWallet(
    ValidateBankOrWalletDto params,
  ) async {
    Log().debug('What is validated on api', params.toJson());
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          transferEndpoints.validateBanksOrWallet,
          params.toJson(),
        ),
      );

      return Right(WalletOrBankModel.fromJson(response.data));
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }
}
