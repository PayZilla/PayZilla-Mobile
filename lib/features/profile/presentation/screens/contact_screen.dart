import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
    return AppScaffold(
      useBodyPadding: false,
      appBar: CustomAppBar(
        centerTitle: true,
        leading: AppBoxedButton(
          onPressed: () {
            AppNavigator.of(context).push(AppRoutes.profile);
          },
        ),
        titleWidget: Text(
          'Contacts',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.dim_24),
        child: ListView(
          children: [
            SearchTextInputField(
              showTrailing: false,
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
            Text(
              'All contacts',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textBodyColor,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 0.30,
              ),
            ),
            const YBox(Insets.dim_24),
            if (profileProvider.permissionDenied)
              const Center(child: Text('Permission denied')),
            if (profileProvider.loading ||
                profileProvider.contactsResponse.isLoading) ...[
              const YBox(Insets.dim_24),
              const AppLoadingWidget(),
            ],
            if (profileProvider.searchedContacts != null &&
                profileProvider.searchedContacts!.isNotEmpty)
              ...List.generate(
                profileProvider.searchedContacts!.length,
                (index) => InkWell(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (profileProvider.contactsResponse.isLoading) return;
                    if (profileProvider
                        .searchedContacts![index].phones.isNotEmpty) {
                      await profileProvider.getContacts([
                        Validators.harmonizeForContacts(
                          profileProvider
                              .searchedContacts![index].phones.first.number,
                        )
                      ]).then((value) async {
                        if (profileProvider.contactsResponse.isSuccess) {
                          if (profileProvider.contactsResponse.data!.isEmpty) {
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
                              showLoading:
                                  profileProvider.userProfileUpdate.isLoading,
                              action: () {},
                            ),
                            future: () async =>
                                [profileProvider.contactsResponse.data!.first],
                            itemBuilder: remoteContactWidget,
                          ).show(context);
                        } else if (profileProvider.contactsResponse.isError) {
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
                  child: localContactWidget(
                    context,
                    profileProvider.searchedContacts![index],
                  ),
                ),
              ).toList(),
          ],
        ),
      ),
    );
  }
}
