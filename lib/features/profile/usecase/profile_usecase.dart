// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/data/core_data.dart';

import 'package:pay_zilla/core/error/failure.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/profile/profile.dart';

class UploadImageUseCase extends UseCase<bool, String> {
  ProfileRepository profileRepository;
  UploadImageUseCase({
    required this.profileRepository,
  });

  @override
  Future<Either<ApiFailure, bool>> call(String params) {
    return profileRepository.uploadImage(params);
  }
}

class UpdateProfileUseCase extends UseCase<User, AuthParams> {
  ProfileRepository profileRepository;
  UpdateProfileUseCase({
    required this.profileRepository,
  });

  @override
  Future<Either<ApiFailure, User>> call(AuthParams params) {
    return profileRepository.updateProfile(params);
  }
}

class GetFaqsUseCase extends UseCase<List<FAQsModel>, NoParams> {
  ProfileRepository profileRepository;
  GetFaqsUseCase({
    required this.profileRepository,
  });

  @override
  Future<Either<ApiFailure, List<FAQsModel>>> call(NoParams params) {
    return profileRepository.getFAQs();
  }
}
