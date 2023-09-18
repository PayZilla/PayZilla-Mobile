import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/di/dependency_injection_container.dart';

class CloudImageManager {
  CloudImageManager({Cloudinary? cloudinary}) {
    _cloudinary = cloudinary ??
        Cloudinary(
          '995159486526392',
          'MNLKDci0S560CQ7JXZuGt0ArvSI',
          'didbuzmxi',
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
