import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: AppScaffold(
        useBodyPadding: false,
        appBar: CustomAppBar(
          centerTitle: true,
          leading: const Padding(
            padding: EdgeInsets.only(left: Insets.dim_24),
            child: AppBoxedButton(),
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
                            Column(
                              children: [
                                const Text('Manage Page'),
                                const Spacer(),
                                AppSolidButton(
                                  textTitle: 'Get Free Card',
                                  action: () {},
                                ),
                                const YBox(Insets.dim_44),
                              ],
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
}
