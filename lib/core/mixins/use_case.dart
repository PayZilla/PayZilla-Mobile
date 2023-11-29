// ignore_for_file: one_member_abstracts

import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
