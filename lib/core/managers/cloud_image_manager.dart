import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/di/dependency_injection_container.dart';

class CloudImageManager {
  CloudImageManager({Cloudinary? cloudinary}) {
    _cloudinary = cloudinary ??
        Cloudinary(
          '699889213185692',
          'nWjjBB2Qg-1QYypYIeF17ndP-Qk',
          'dzpe8dv0d',
        );
  }
  late Cloudinary _cloudinary;

  static CloudImageManager get instance => sl<CloudImageManager>();

  /// Uploads an image to cloudinary and returns the url
  Future<Either<Failure, String>> uploadFile(
    File image, {
    CloudinaryResourceType resourceType = CloudinaryResourceType.image,
  }) async {
    final response = await _cloudinary.uploadFile(
      filePath: image.path,
      resourceType: resourceType,
    );
    if (response.isSuccessful) {
      final secureUrl = response.secureUrl;
      if (secureUrl != null) {
        return right(secureUrl);
      }
    }
    return left(ServerFailure('Error uploading image, please try again'));
  }
}
