import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

abstract class IAccountRemoteDataSource {
  Future<Either<ApiFailure, List<WalletsModel>>> getWallets();
  Future<Either<ApiFailure, List<ContactsModel>>> getContacts(
    List<String> contacts,
  );
  Future<Either<ApiFailure, AccountDetailsModel>> getAccounts();
}

class AccountRemoteDataSource implements IAccountRemoteDataSource {
  AccountRemoteDataSource(this.http);
  final HttpManager http;

  @override
  Future<Either<ApiFailure, List<WalletsModel>>> getWallets() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.getWallets),
      );

      return Right(
        (response.data as List)
            .map((e) => WalletsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, AccountDetailsModel>> getAccounts() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(accountEndpoints.getAccountDetails),
      );

      return Right(AccountDetailsModel.fromJson(response.data));
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, List<ContactsModel>>> getContacts(
    List<String> contacts,
  ) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          accountEndpoints.getContacts,
          {'contacts': contacts},
        ),
      );

      return Right(
        (response.data as List)
            .map((e) => ContactsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }
}
