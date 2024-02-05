import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class AppCircularLoadingWidget extends StatelessWidget {
  const AppCircularLoadingWidget({
    this.size = 15,
    this.color,
    Key? key,
    this.value,
  }) : super(key: key);
  final double size;
  final double? value;
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
          value: value,
        ),
      ),
    );
  }
}

class AppLinearLoadingWidget extends StatefulWidget {
  const AppLinearLoadingWidget({super.key, this.color});
  final Color? color;

  @override
  State<AppLinearLoadingWidget> createState() => _AppLinearLoadingWidget();
}

class _AppLinearLoadingWidget extends State<AppLinearLoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: 1.seconds,
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: controller.value,
      backgroundColor: AppColors.white,
      valueColor: AlwaysStoppedAnimation<Color>(
        widget.color ?? AppColors.textHeaderColor,
      ),
      semanticsLabel: 'loading progress indicator',
    );
  }
}
