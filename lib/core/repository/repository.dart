import 'package:dartz/dartz.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/di/dependency_injection_container.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

abstract class Repository with LogoutMixin {
  Repository({NetworkManager? networkNotifier})
      : _networkNotifier = networkNotifier ?? sl<NetworkManager>();
  final NetworkManager _networkNotifier;

  Future<bool> get hasNetwork => _networkNotifier.hasNetwork();

  @protected
  Future<Either<Failure, T>> runGuard<T>(
    Future<T> Function() call,
  ) async {
    if (await hasNetwork) {
      try {
        final result = await call();
        return Right(result);
      } catch (e, stack) {
        Log().error('Run guard {runGuard}==', e.toString());
        if (kReleaseMode) {
          await FirebaseCrashlytics.instance.recordError(
            e,
            stack,
            reason: {
              'error_response': e.toString(),
            },
          );
        }
        // Handle all exceptions here
        if (e is SessionExpiredServerException) {
          sessionTimeout(reason: 'Oops, Session expired');
          return Left(ServerFailure(e.message));
        }
        if (e is PZillaException) {
          return Left(ServerFailure(e.message));
        }
        if (e is InvalidArgOrDataException) {
          return Left(InvalidArgOrDataFailure());
        }
        return Left(UnexpectedFailure());
      }
    }
    return Left(NetworkFailure());
  }
}
