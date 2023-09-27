import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  int? currentSelectedIndex;
  late ProfileProvider profileProvider;
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => profileProvider
        ..searchedContacts = []
        ..fetchedContacts = []
        ..fetchContacts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = context.watch<ProfileProvider>();
    final dsProvider = context.watch<DashboardProvider>();
    return Stack(
      children: [
        AppScaffold(
          useBodyPadding: false,
          appBar: CustomAppBar(
            centerTitle: true,
            leading: AppBoxedButton(
              onPressed: () => AppNavigator.of(context).pop(),
            ),
            titleWidget: Text(
              'Transfer',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 0.30,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.dim_22),
            child: ListView(
              children: [
                const YBox(Insets.dim_24),
                Text(
                  'Choose cards',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.btnPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    letterSpacing: 0.30,
                  ),
                ),
                const YBox(Insets.dim_16),
                SizedBox(
                  height: context.getHeight(0.25),
                  child: dsProvider.getWalletsResponse.isLoading
                      ? const TempLoadingAtmCard(
                          color: AppColors.textHeaderColor,
                        )
                      : const AtmCardWidget(
                          color: AppColors.textHeaderColor,
                        ),
                ),
                const YBox(Insets.dim_24),
                Text(
                  'Choose recipients',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.btnPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    letterSpacing: 0.30,
                  ),
                ),
                const YBox(Insets.dim_16),
                SearchTextInputField(
                  showTrailing: false,
                  title: 'Search contacts',
                  onChanged: (value) {
                    if (value.isNotEmpty &&
                        profileProvider.fetchedContacts != null) {
                      profileProvider.searchedContacts =
                          profileProvider.fetchedContacts!
                              .where(
                                (contact) => contact.displayName
                                    .toLowerCase()
                                    .contains(value.toLowerCase()),
                              )
                              .toList();
                    } else {
                      profileProvider.searchedContacts =
                          profileProvider.fetchedContacts;
                    }
                    setState(() {});
                  },
                ),
                const YBox(Insets.dim_24),
                if (profileProvider.searchedContacts != null &&
                    profileProvider.searchedContacts!.isNotEmpty)
                  SizedBox(
                    height: context.getHeight(0.22),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const XBox(Insets.dim_14),
                      itemCount: profileProvider.searchedContacts!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (profileProvider.contactsResponse.isLoading)
                              return;
                            setState(() => currentSelectedIndex = index);
                            if (profileProvider
                                .searchedContacts![index].phones.isNotEmpty) {
                              await profileProvider.getContacts([
                                Validators.harmonizeForContacts('2348122437265'
                                    // profileProvider
                                    //     .searchedContacts![index].phones.first.number,
                                    )
                              ]).then((value) async {
                                if (profileProvider
                                    .contactsResponse.isSuccess) {
                                  if (profileProvider
                                      .contactsResponse.data!.isEmpty) {
                                    showInfoNotification(
                                      "This phone number doesn't exist on our record.\nInvite them to join PayZilla",
                                      durationInMills: 3000,
                                    );
                                    return;
                                  }
                                  await FutureBottomSheet<ContactsModel>(
                                    title:
                                        'Send money to ${profileProvider.contactsResponse.data!.first.name}',
                                    height: context.getHeight(0.5),
                                    bottomWidget: AppSolidButton(
                                      textTitle: 'Send Money',
                                      showLoading: profileProvider
                                          .userProfileUpdate.isLoading,
                                      action: () {
                                        AppNavigator.of(context).push(
                                          AppRoutes.sendMoney,
                                          args: SendMoneyScreenArgs(
                                            contact: profileProvider
                                                .contactsResponse.data!.first,
                                          ),
                                        );
                                      },
                                    ),
                                    future: () async => [
                                      profileProvider
                                          .contactsResponse.data!.first
                                    ],
                                    itemBuilder: remoteContactWidget,
                                  ).show(context);
                                } else if (profileProvider
                                    .contactsResponse.isError) {
                                  showInfoNotification(
                                    "This phone number doesn't exist on our record.\nInvite them to join PayZilla",
                                    durationInMills: 3000,
                                  );
                                }
                              });
                            } else {
                              showInfoNotification('No phone number');
                            }
                          },
                          child: SelectableContactWidget(
                            index: index,
                            isSelected: currentSelectedIndex == index,
                            contact: profileProvider.searchedContacts![index],
                          ),
                        );
                      },
                    ),
                  ),
                const YBox(Insets.dim_32),
              ],
            ),
          ),
        ),
        if (profileProvider.contactsResponse.isLoading)
          Container(
            color: AppColors.black.withOpacity(0.5),
            child: const AppLoadingWidget(
              color: AppColors.white,
              size: Insets.dim_30,
            ),
          ),
      ],
    );
  }
}
