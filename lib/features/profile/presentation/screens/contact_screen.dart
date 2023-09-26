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
  late List<Contact>? _contacts;
  late List<Contact>? _searchedContacts;
  bool _permissionDenied = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _contacts = [];
    _searchedContacts = [];
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      setState(() => _loading = true);

      final contacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() {
        _contacts = contacts;
        _searchedContacts = contacts;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
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
                if (value.isNotEmpty && _contacts != null) {
                  _searchedContacts = _contacts!
                      .where(
                        (contact) => contact.displayName
                            .toLowerCase()
                            .contains(value.toLowerCase()),
                      )
                      .toList();
                } else {
                  _searchedContacts = _contacts;
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
            if (_permissionDenied)
              const Center(child: Text('Permission denied')),
            if (_loading || profileProvider.contactsResponse.isLoading) ...[
              const YBox(Insets.dim_24),
              const AppLoadingWidget(),
            ],
            if (_searchedContacts != null && _searchedContacts!.isNotEmpty)
              ...List.generate(
                _searchedContacts!.length,
                (index) => InkWell(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (profileProvider.contactsResponse.isLoading) return;
                    if (_searchedContacts![index].phones.isNotEmpty) {
                      await profileProvider.getContacts([
                        Validators.harmonizeForContacts(
                          _searchedContacts![index].phones.first.number,
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
                    _searchedContacts![index],
                  ),
                ),
              ).toList(),
          ],
        ),
      ),
    );
  }
}
