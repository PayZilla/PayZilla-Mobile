import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    required this.child,
    this.onDismiss,
    this.height,
    this.desc,
    this.title,
    this.isDismissible = true,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final void Function()? onDismiss;
  final bool isDismissible;
  final double? height;
  final String? title;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffD7D4F7),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Insets.dim_16),
            topLeft: Radius.circular(Insets.dim_16),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  if (isDismissible)
                    Padding(
                      padding: const EdgeInsets.only(right: 19),
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Color(0xff333D47),
                        ),
                        label: Text(
                          'Close',
                          style: context.textTheme.bodyMedium
                              .size(Insets.dim_16)
                              .copyWith(
                                color: const Color(0xff333D47),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    )
                  else
                    const YBox(Insets.dim_50),
                  Container(
                    height: height ?? context.getHeight(0.3),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xffFBFBFE),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Insets.dim_24),
                        topLeft: Radius.circular(Insets.dim_24),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.dim_16,
                    ),
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const YBox(Insets.dim_40),
                        if (title != null) ...[
                          Text(
                            title ?? '',
                            style: context.textTheme.headlineLarge!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                        if (desc != null) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: Insets.dim_8),
                            child: Text(
                              desc ?? '',
                              style: context.textTheme.bodySmall,
                            ),
                          ),
                        ],
                        const YBox(Insets.dim_16),
                        child,
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
