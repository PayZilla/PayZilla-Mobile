import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

/// simple wrapper around CachedNetworkImage that provides any boilerplate we need for images in the app
class HostedImage extends StatelessWidget {
  const HostedImage(
    this.url, {
    Key? key,
    this.height,
    this.width,
    this.fallbackImage,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  final String url;
  final double? height, width;
  final BoxFit fit;

  /// image to be displayed when the image is not available
  final Widget? fallbackImage;

  @override
  Widget build(BuildContext context) {
    var secureUrl = url;
    if (url.contains('http://')) {
      secureUrl = secureUrl.replaceAll('http://', 'https://');
    }
    return CachedNetworkImage(
      imageUrl: secureUrl,
      fit: fit,
      height: height,
      width: width,
      progressIndicatorBuilder: (_, s, i) =>
          CupertinoActivityIndicator.partiallyRevealed(
        progress: i.progress ?? 1,
      ),
      errorWidget: (_, s, ___) =>
          fallbackImage ??
          LocalSvgImage(
            logoSvg,
            fit: fit,
            height: height,
            width: width,
          ),
      fadeInDuration: 1.seconds,
    );
  }
}

class LocalImage extends StatelessWidget {
  const LocalImage(
    this.image, {
    Key? key,
    this.height,
    this.width,
    this.semanticLabel,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  final String image;
  final String? semanticLabel;
  final double? height, width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: fit,
      height: height,
      width: width,
      semanticLabel: '',
    );
  }
}

class LocalSvgImage extends StatelessWidget {
  const LocalSvgImage(
    this.image, {
    Key? key,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  final String image;
  final double? height, width;
  final BoxFit fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      fit: fit,
      height: height,
      width: width,
      color: color,
    );
  }
}
