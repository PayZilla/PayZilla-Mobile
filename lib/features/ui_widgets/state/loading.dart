import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({this.size = 15, this.color, Key? key})
      : super(key: key);
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
