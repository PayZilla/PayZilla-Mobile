import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useBodyPadding: false,
      body: Stack(
        children: [
          Stack(
            fit: StackFit.expand,
            children: [
              FractionallySizedBox(
                heightFactor: .4,
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.only(
                    left: Insets.dim_22,
                    top: context.getHeight(.1),
                    right: Insets.dim_22,
                  ),
                  color: AppColors.btnPrimaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back!',
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              letterSpacing: 0.30,
                            ),
                          ),
                          const YBox(Insets.dim_10),
                          Text(
                            'John O.Williams',
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              letterSpacing: 0.30,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.white.withOpacity(0.5),
                          ),
                          borderRadius: Corners.mdBorder,
                        ),
                        child: const Icon(
                          PhosphorIcons.bellBold,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              FractionallySizedBox(
                heightFactor: .6,
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: AppColors.white,
                  child: ListView(
                    children: List.generate(
                      50,
                      (index) => Container(
                        height: 70,
                        color: index.isEven
                            ? AppColors.textBodyColor
                            : AppColors.borderErrorColor,
                      ),
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment(0, -0.46),
            child: AtmCardWidget(),
          )
        ],
      ),
    );
  }
}
