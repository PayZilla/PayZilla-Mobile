import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';

import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:provider/provider.dart';

class AppWebViewArgs {
  AppWebViewArgs(this.url, this.title);

  final String url;
  final String title;
}

class AppWebview extends StatefulWidget {
  const AppWebview({required this.args, Key? key}) : super(key: key);
  final AppWebViewArgs args;

  @override
  State<AppWebview> createState() => _AppWebviewState();
}

class _AppWebviewState extends State<AppWebview> {
  final GlobalKey webViewKey = GlobalKey();
  late final InAppWebViewController webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: 'camera; microphone',
    iframeAllowFullscreen: true,
  );
  String url = '';
  double progress = 0;
  final urlController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.args.title,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(
                url: WebUri(widget.args.url),
              ),
              initialUserScripts: UnmodifiableListView<UserScript>([]),
              initialSettings: settings,
              onWebViewCreated: (controller) async {
                webViewController = controller;
              },
              onLoadStart: (controller, url) async {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onPermissionRequest: (controller, request) async {
                return PermissionResponse(
                  resources: request.resources,
                  action: PermissionResponseAction.GRANT,
                );
              },
              onLoadStop: (controller, url) async {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onReceivedError: (controller, request, error) {},
              onProgressChanged: (controller, p) {
                setState(() {
                  progress = p / 100;
                  urlController.text = url;
                });
              },
              onUpdateVisitedHistory: (controller, url, isReload) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                if (consoleMessage.message.contains('handleDataReceived')) {
                  final json = jsonDecode(consoleMessage.message);
                  auth
                    ..bvnModel = BvnModel.fromJson(json)
                    ..requestBvn = false;
                  setState(() {});
                }
              },
            ),
            if (progress < 1.0)
              AppCircularLoadingWidget(
                value: progress,
                color: AppColors.white,
                size: 50,
              )
            else
              const SizedBox.shrink(),
            if (urlController.text.split('/').last.contains('error'))
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: const Icon(Icons.refresh),
                  onPressed: () {
                    webViewController.reload();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
