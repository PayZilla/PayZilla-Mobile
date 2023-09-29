import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  late ProfileProvider provider;
  List<FAQsModel> _faqs = [];
  List<FAQsModel> _searchedFaqs = [];
  @override
  void initState() {
    Future.microtask(_fetchFaqs);
    super.initState();
  }

  Future _fetchFaqs() async {
    await provider.getFAQs();
    setState(() {
      if (provider.faqResponse.isSuccess) {
        _faqs = provider.faqResponse.data!;
        _searchedFaqs = _faqs;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = context.watch<ProfileProvider>();
    return AppScaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: 'Frequently Asked',
        leading: AppBoxedButton(
          onPressed: () {
            AppNavigator.of(context).push(AppRoutes.profile);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You have any question ?',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textHeaderColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              letterSpacing: 0.30,
            ),
          ),
          const YBox(Insets.dim_40),
          SearchTextInputField(
            showTrailing: false,
            onChanged: (value) {
              if (value.isNotEmpty && _faqs.isNotEmpty) {
                _searchedFaqs = _faqs
                    .where(
                      (faq) =>
                          faq.title.toLowerCase().contains(value.toLowerCase()),
                    )
                    .toList();
              } else {
                _searchedFaqs = _faqs;
              }
              setState(() {});
            },
          ),
          const YBox(Insets.dim_24),
          Text(
            'Frequently Asked',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              letterSpacing: 0.30,
            ),
          ),
          const YBox(Insets.dim_24),
          if (provider.faqResponse.isLoading) const AppCircularLoadingWidget(),
          if (provider.faqResponse.isSuccess)
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const YBox(Insets.dim_12),
                itemCount: _searchedFaqs.length,
                itemBuilder: (context, index) {
                  final data = _searchedFaqs[index];
                  return faqColumnWidget(
                    context,
                    title: data.title,
                    subtitle: data.body,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Container faqColumnWidget(
    BuildContext context, {
    String? title,
    String? subtitle,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: Corners.mdBorder,
        border: Border.all(color: AppColors.grey),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Insets.dim_24,
        horizontal: Insets.dim_16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'How do I create a PayZilla account?',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textHeaderColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              letterSpacing: 0.30,
            ),
          ),
          const YBox(Insets.dim_12),
          Text(
            subtitle ??
                'You can create a Smartpay account by: download and  open the smartpay application first then select ...',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textBodyColor,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              letterSpacing: 0.30,
            ),
          ),
        ],
      ),
    );
  }
}
