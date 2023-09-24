import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/qr/qr.dart';

class QrRepository extends Repository {
  QrRepository({
    required this.remoteDataSource,
  });

  final IQRRemoteDataSource remoteDataSource;

  Future<Either<Failure, TransferValidateModel>> validateQR(
    ValidateQRDto params,
  ) async {
    return runGuard(() async {
      final response = await remoteDataSource.validateQR(params);

      return response;
    });
  }
}
