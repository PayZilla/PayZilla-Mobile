import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';
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
  BillPaymentDto billPaymentDto = BillPaymentDto.empty();

  @override
  Widget build(BuildContext context) {
    final dsProvider = context.watch<DashboardProvider>();
    final authProvider = context.watch<AuthProvider>();
    final notification = context.watch<NotificationProvider>();
    final historiesProvider = context.watch<TransactionHistoryProvider>();

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
                        child: Stack(
                          children: [
                            const Center(
                              child: Icon(
                                PhosphorIcons.bellBold,
                                color: AppColors.white,
                                size: Insets.dim_34,
                              ),
                            ),
                            if (notification.count > 0)
                              const Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: AppColors.borderErrorColor,
                                ),
                              ),
                          ],
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
                          nairaPng,
                          transferSvg,
                          nairaPng,
                          referEarnSvg,
                        ],
                        name: const [
                          'Add Money',
                          'To PayZilla',
                          'To Bank',
                          'Refer & Earn',
                        ],
                        todo: [
                          () => dsProvider.goTo(
                                AppRoutes.fundingAccountDetails,
                                context,
                              ),
                          () => dsProvider.goTo(AppRoutes.transfer, context),
                          () =>
                              dsProvider.goTo(AppRoutes.bankTransfer, context),
                          () => dsProvider.goTo(AppRoutes.referral, context),
                        ],
                      ),
                      const YBox(Insets.dim_2),
                      if (dsProvider.billResponse.isLoading)
                        const Center(
                          child: AppCircularLoadingWidget(),
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
                          child: LayoutBuilder(
                            builder: (context, constraints) => GridView.builder(
                              itemCount: dsProvider.billResponse.data!.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: Insets.dim_22,
                                childAspectRatio: 0.8,
                              ),
                              itemBuilder: (context, index) {
                                final e = dsProvider.billResponse.data![index];
                                return InkWell(
                                  onTap: () async {
                                    authProvider.showNavBar = true;
                                    dsProvider.clearTEC();

                                    await FutureBottomSheet<BillServiceModel>(
                                      title: 'Select an option',
                                      height: context.getHeight(0.5),
                                      future: () async {
                                        return dsProvider.getCategoryId(
                                          e.identifier,
                                          context,
                                        );
                                      },
                                      itemBuilder: (context, item) {
                                        return ListTile(
                                          title: Text(
                                            item.name,
                                          ),
                                        );
                                      },
                                    ).show(context).then((value) async {
                                      if (value != null) {
                                        await FutureBottomSheet<Variations>(
                                          title: 'Select an option',
                                          height: context.getHeight(0.5),
                                          searchWidget: dsProvider.model
                                                  .convenienceFee.isNotEmpty
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Convenience Fee',
                                                      style: context
                                                          .textTheme.bodyMedium!
                                                          .copyWith(
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        letterSpacing: 0.30,
                                                      ),
                                                    ),
                                                    Text(
                                                      dsProvider
                                                          .model.convenienceFee,
                                                    ),
                                                  ],
                                                )
                                              : null,
                                          future: () async {
                                            return dsProvider.getServiceId(
                                              (value as BillServiceModel)
                                                  .serviceId,
                                              context,
                                            );
                                          },
                                          itemBuilder: (context, service) {
                                            return ListTile(
                                              title: Text(
                                                service.name,
                                              ),
                                            );
                                          },
                                        ).show(context).then((serviceValue) {
                                          if (serviceValue != null) {
                                            final serviceData =
                                                serviceValue as Variations;
                                            billPaymentDto =
                                                billPaymentDto.copyWith(
                                              serviceId:
                                                  dsProvider.model.serviceId,
                                              variationCode:
                                                  serviceData.variationCode,
                                              billName: serviceData.name,
                                            );
                                            AppNavigator.of(context).push(
                                              AppRoutes.billPaymentVerification,
                                              args:
                                                  BillPaymentVerificationScreenArgs(
                                                billPaymentDto,
                                              ),
                                            );
                                          }
                                        });
                                      }
                                    });
                                    authProvider.showNavBar = false;
                                  },
                                  child: Column(
                                    children: [
                                      LocalSvgImage(
                                        dsProvider.assetIcon(e.identifier),
                                      ),
                                      const YBox(Insets.dim_12),
                                      Text(
                                        e.name,
                                        textAlign: TextAlign.center,
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
                                );
                              },
                            ),
                          ),
                        ),
                      const YBox(Insets.dim_2),
                      Row(
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.only(
                              left: Insets.dim_32,
                              top: Insets.dim_22,
                              bottom: Insets.dim_22,
                              right: Insets.dim_22,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: Insets.dim_22,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: Corners.mdBorder,
                              color: AppColors.borderColor,
                            ),
                            child: InkWell(
                              onTap: () async {
                                authProvider.showNavBar = true;
                                dsProvider.clearTEC();
                                await FutureBottomSheet<Widget>(
                                  title: 'Buy Airtime',
                                  height: context.getHeight(0.6),
                                  future: () async => [
                                    const YBox(Insets.dim_24),
                                    PhoneNumberTextFormField(
                                      labelText: 'Phone number',
                                      controller: dsProvider.phoneController,
                                      enabled:
                                          !dsProvider.payBillResponse.isLoading,
                                    ),
                                    const YBox(Insets.dim_24),
                                    AppTextFormField(
                                      hintText: '00.00',
                                      labelText: 'Amount',
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      inputType: TextInputType.number,
                                      validator: (input) =>
                                          Validators.validateAmount()(
                                        input,
                                      ),
                                      onSaved: (value) {},
                                      isLoading:
                                          dsProvider.payBillResponse.isLoading,
                                      controller: dsProvider.amountController,
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                        color: AppColors.textHeaderColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        letterSpacing: 0.1,
                                      ),
                                    ),
                                    const YBox(Insets.dim_24),
                                    PinTextField(
                                      validator: (input) =>
                                          Validators.validateString()(
                                        input,
                                      ),
                                      labelText: 'Transaction PIN',
                                      controller: dsProvider.pinController,
                                      onSaved: (input) {},
                                    ),
                                    YBox(context.getHeight(0.1)),
                                    AppSolidButton(
                                      textTitle: 'Confirm',
                                      showLoading:
                                          dsProvider.payBillResponse.isLoading,
                                      action: () {
                                        if (dsProvider.amountController.text
                                                .isEmpty ||
                                            dsProvider
                                                .pinController.text.isEmpty ||
                                            dsProvider
                                                .phoneController.text.isEmpty) {
                                          return showInfoNotification(
                                            context,
                                            'Please fill all fields',
                                          );
                                        }
                                        dsProvider.purchaseAirtime(context);
                                        AppNavigator.of(context).popDialog();
                                      },
                                    ),
                                  ],
                                  itemBuilder: (context, item) {
                                    return item;
                                  },
                                ).show(context);
                                authProvider.showNavBar = false;
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LocalSvgImage(
                                    dsProvider.assetIcon('airtime'),
                                  ),
                                  const YBox(Insets.dim_12),
                                  Text(
                                    'Airtime',
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      color: AppColors.textHeaderColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      letterSpacing: 0.30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
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
                                  'Today, ${DateFormatUtil.formatDate(
                                    dateMonthFormat,
                                    DateTime.now().toIso8601String(),
                                  )}',
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
                                ),
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
                            child: historiesProvider
                                    .getTransactionsResponse.isLoading
                                ? const AppCircularLoadingWidget()
                                : const TransactionList(useRefresh: false),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: const Alignment(0, -0.46),
            child: dsProvider.getWalletsResponse.isLoading
                ? const TempLoadingAtmCard(
                    color: AppColors.textHeaderColor,
                    height: .14,
                  )
                : const AtmCardWidget(),
          ),
        ],
      ),
    );
  }
}
