import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class EditCardScreenArgs {
  const EditCardScreenArgs({
    required this.card,
    required this.cardPrimaryColor,
  });
  final Widget card;
  final Color cardPrimaryColor;
}

class EditCardScreen extends StatefulWidget {
  const EditCardScreen({super.key, required this.args});
  final EditCardScreenArgs args;

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  bool mag = false;
  bool contact = false;
  bool card = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: AppScaffold(
        useBodyPadding: false,
        appBar: CustomAppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: Insets.dim_24),
            child: AppBoxedButton(
              onPressed: () {
                AppNavigator.of(context).push(AppRoutes.myCard);
              },
            ),
          ),
          leadingWidth: 80,
          titleWidget: Text(
            'Edit Card',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              letterSpacing: 0.30,
            ),
          ),
        ),
        body: Container(
          height: context.getHeight(),
          width: context.getWidth(),
          color: AppColors.grey,
          child: Column(
            children: [
              const YBox(Insets.dim_44),
              Card(
                elevation: 12,
                shadowColor: widget.args.cardPrimaryColor,
                clipBehavior: Clip.hardEdge,
                shape: const RoundedRectangleBorder(
                  borderRadius: Corners.mdBorder,
                ),
                child: widget.args.card,
              ),
              const YBox(Insets.dim_44),
              Expanded(
                child: Container(
                  color: AppColors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: Insets.dim_24),
                  child: Column(
                    children: [
                      const YBox(Insets.dim_24),
                      Container(
                        height: context.getHeight(0.06),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Insets.dim_4,
                          vertical: Insets.dim_4,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: Corners.mdBorder,
                        ),
                        child: const TabBar(
                          indicator: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: Corners.mdBorder,
                          ),
                          labelColor: AppColors.textHeaderColor,
                          unselectedLabelColor: AppColors.textBodyColor,
                          tabs: [
                            Tab(
                              text: 'Personal',
                            ),
                            Tab(
                              text: 'Manage',
                            ),
                            Tab(
                              text: 'Detail',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            const Center(
                              child: Text('Personal page'),
                            ),
                            Scrollbar(
                              thumbVisibility: false,
                              thickness: 0.7,
                              child: ListView(
                                children: [
                                  const YBox(Insets.dim_32),
                                  manageOptionWidget(
                                    context,
                                    switched: card,
                                    onChanged: (value) {
                                      setState(() {
                                        card = value;
                                      });
                                    },
                                  ),
                                  manageOptionWidget(
                                    context,
                                    switched: contact,
                                    onChanged: (value) {
                                      setState(() {
                                        contact = value;
                                      });
                                    },
                                  ),
                                  manageOptionWidget(
                                    context,
                                    switched: mag,
                                    onChanged: (value) {
                                      setState(() {
                                        mag = value;
                                      });
                                    },
                                  ),
                                  const YBox(Insets.dim_44),
                                  AppSolidButton(
                                    textTitle: 'Save',
                                    action: () {},
                                  ),
                                  const YBox(Insets.dim_44),
                                ],
                              ),
                            ),
                            const Center(
                              child: Text('Details Page'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget manageOptionWidget(
    BuildContext context, {
    bool switched = false,
    void Function(bool)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.black.withOpacity(0.2),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Insets.dim_14),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: Corners.mdBorder,
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.credit_card_rounded,
              size: 32,
            ),
          ),
          title: Text(
            'Freeze physical card',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textHeaderColor,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 0.30,
            ),
          ),
          trailing: CupertinoSwitch(
            value: switched,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
