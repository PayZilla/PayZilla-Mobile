import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
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
                      ).onTap(
                        () => AppNavigator.of(context)
                            .push(AppRoutes.homeToNotifications),
                      ),
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
                    children: [
                      DashboardIconActionWidget(
                        icon: [
                          depositSvg,
                          transferSvg,
                          withdrawSvg,
                          referEarnSvg
                        ],
                        name: const [
                          'Deposit',
                          'Transfers',
                          'Withdraw',
                          'Refer & Earn'
                        ],
                        todo: [
                          () {
                            Log().debug('The action tapped is deposit');
                          },
                          () {
                            Log().debug('The action tapped is Transfers');
                          },
                          () {
                            Log().debug('The action tapped is Withdraw');
                          },
                          () {
                            Log().debug('The action tapped is Refer');
                          }
                        ],
                      ),
                      DashboardIconActionWidget(
                        icon: [dataSvg, dataSvg, safeRideSvg, tvSvg],
                        name: const ['Airtime', 'Data', 'Safe Ride', 'TV'],
                        todo: [
                          () {
                            Log().debug('The action tapped is airtime');
                          },
                          () {
                            Log().debug('The action tapped is data');
                          },
                          () {
                            Log().debug('The action tapped is safe ride');
                          },
                          () {
                            Log().debug('The action tapped is tv');
                          }
                        ],
                      ),
                      DashboardIconActionWidget(
                        length: 3,
                        icon: [electricitySvg, schoolSvg, moreSvg],
                        name: const ['Electricity', 'School', 'More'],
                        todo: [
                          () {
                            Log().debug('The action tapped is Electricity');
                          },
                          () {
                            Log().debug('The action tapped is School');
                          },
                          () {
                            Log().debug('The action tapped is more');
                          },
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Insets.dim_24,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Today, Mar 20',
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.textBodyColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    letterSpacing: 0.30,
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'All transactions',
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(
                                          color: AppColors.textHeaderColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.30,
                                        ),
                                      ),
                                      const XBox(Insets.dim_8),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.black,
                                        size: Insets.dim_14,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.borderColor,
                            endIndent: Insets.dim_22,
                            indent: Insets.dim_22,
                          ),
                          SizedBox(
                            height: context.getHeight(0.3),
                            child: const TransactionList(),
                          ),
                        ],
                      )
                    ],
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
