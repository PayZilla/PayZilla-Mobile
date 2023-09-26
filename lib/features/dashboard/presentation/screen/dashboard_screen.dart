import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final dsProvider = context.watch<DashboardProvider>();
    final authProvider = context.watch<AuthProvider>();
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
                            authProvider.user.fullName,
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
                            AppNavigator.of(context)
                                .push(AppRoutes.fundingAccountDetails);
                          },
                          () {
                            dsProvider.goTo(AppRoutes.transfer, context);
                          },
                          () {
                            Log().debug('The action tapped is Withdraw');
                          },
                          () =>
                              AppNavigator.of(context).push(AppRoutes.referral)
                        ],
                      ),
                      if (dsProvider.billResponse.isLoading)
                        const Center(
                          child: AppLoadingWidget(),
                        )
                      else if (dsProvider.billResponse.isSuccess &&
                          dsProvider.billResponse.data!.isNotEmpty)
                        Container(
                          clipBehavior: Clip.hardEdge,
                          padding: const EdgeInsets.all(Insets.dim_22),
                          margin: const EdgeInsets.symmetric(
                            horizontal: Insets.dim_22,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: Corners.mdBorder,
                            color: AppColors.borderColor,
                          ),
                          child: Wrap(
                            runSpacing: 20,
                            spacing: 20,
                            children: dsProvider.billResponse.data!
                                .map(
                                  (e) => InkWell(
                                    onTap: () {
                                      FutureBottomSheet<BillServiceModel>(
                                        title: 'Select an option',
                                        height: context.getHeight(0.5),
                                        future: () async {
                                          return dsProvider
                                              .getCategoryId(e.identifier);
                                        },
                                        itemBuilder: (context, item) {
                                          return ListTile(
                                            title: Text(
                                              item.name,
                                            ),
                                          );
                                        },
                                      ).show(context).then((value) {
                                        if (value != null) {
                                          FutureBottomSheet<Variations>(
                                            title: 'Select an option',
                                            height: context.getHeight(0.5),
                                            searchWidget: dsProvider
                                                    .convenienceFee.isNotEmpty
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Convenience Fee',
                                                        style: context.textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                          color:
                                                              AppColors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          letterSpacing: 0.30,
                                                        ),
                                                      ),
                                                      Text(
                                                        dsProvider
                                                            .convenienceFee,
                                                      ),
                                                    ],
                                                  )
                                                : null,
                                            future: () async {
                                              return dsProvider.getServiceId(
                                                (value as BillServiceModel)
                                                    .serviceId,
                                              );
                                            },
                                            itemBuilder: (context, service) {
                                              return ListTile(
                                                title: Text(
                                                  service.name,
                                                ),
                                              );
                                            },
                                          ).show(context).then((value) {
                                            if (value != null) {
                                              //  TODO(DEV)=> submit request here for bills transaction
                                            }
                                          });
                                        }
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        LocalSvgImage(
                                          dsProvider.assetIcon(e.identifier),
                                        ),
                                        const YBox(Insets.dim_12),
                                        Text(
                                          e.name,
                                          style: context.textTheme.bodyMedium!
                                              .copyWith(
                                            color: AppColors.textHeaderColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            letterSpacing: 0.30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
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
                                  onPressed: () => AppNavigator.of(context)
                                      .push(AppRoutes.allTransactions),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Insets.dim_4,
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
