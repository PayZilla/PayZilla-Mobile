import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class AfrWebViewArgs {
  AfrWebViewArgs(this.url, this.title);

  final String url;
  final String title;
}

class AfrWebview extends StatefulWidget {
  const AfrWebview({required this.args, Key? key}) : super(key: key);
  final AfrWebViewArgs args;

  @override
  State<AfrWebview> createState() => _AfrWebviewState();
}

class _AfrWebviewState extends State<AfrWebview> {
  late final WebViewController _controller;
  int loadingPercent = 0;
  @override
  void initState() {
    super.initState();

    // #docRegion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                loadingPercent = progress;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.args.url));

    // #doc region platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #end docRegion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AfrAppBar(
        title: widget.args.title,
      ),
      body: loadingPercent != 100
          ? const AfrichangeLoadingWidget()
          : WebViewWidget(controller: _controller),
    );
  }
}
