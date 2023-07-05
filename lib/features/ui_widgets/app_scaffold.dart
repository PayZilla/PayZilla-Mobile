import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.extendedBody = false,
  });
  final Widget? body;
  final bool extendedBody;
  final PreferredSizeWidget? appBar;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: widget.extendedBody,
      backgroundColor: AppColors.scaffold,
      appBar: widget.appBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: widget.body,
        ),
      ),
    );
  }
}
