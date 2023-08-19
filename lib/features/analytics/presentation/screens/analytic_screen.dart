import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/analytics/analytics.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/extensions/context_extension.dart';
import 'package:pay_zilla/functional_utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    final analyticProvider = context.watch<AnalyticProvider>();
    final authProvider = context.watch<AuthProvider>();
    final money = context.money();
    return DefaultTabController(
      length: 4,
      child: AppScaffold(
        useBodyPadding: false,
        appBar: CustomAppBar(
          centerTitle: true,
          leading: const SizedBox.shrink(),
          titleWidget: Text(
            'Activity',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              letterSpacing: 0.30,
            ),
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: context.getHeight(0.070),
                  width: double.infinity,
                  child: PageView.builder(
                    onPageChanged: analyticProvider.onSliderChange,
                    controller: analyticProvider.pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: analyticProvider.sliders.length,
                    itemBuilder: (context, index) => AtmCardWidget(
                      color: analyticProvider.sliders[index],
                    ),
                  ),
                ),
                const YBox(Insets.dim_8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    analyticProvider.sliders.length,
                    (index) => buildDot(
                      index: index,
                      currentPage: analyticProvider.currentSliderIndex,
                    ),
                  ),
                ),
              ],
            ),
            const YBox(Insets.dim_24),
            Container(
              height: context.getHeight(0.4),
              width: context.getWidth(),
              margin: const EdgeInsets.symmetric(horizontal: Insets.dim_16),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: Corners.mdBorder,
                border: Border.all(
                  width: 2,
                  color: AppColors.borderColor,
                ),
              ),
              child: Column(
                children: [
                  const YBox(Insets.dim_24),
                  Text(
                    'Total Spending',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.textBodyColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: 0.30,
                    ),
                  ),
                  const YBox(Insets.dim_4),
                  Text(
                    money.formatValue(521500),
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.textHeaderColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  const YBox(Insets.dim_24),
                  Container(
                    height: context.getHeight(0.06),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.dim_4,
                      vertical: Insets.dim_4,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: Corners.mdBorder,
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: AppColors.borderColor,
                        borderRadius: Corners.mdBorder,
                      ),
                      labelColor: AppColors.black,
                      unselectedLabelColor: AppColors.textBodyColor,
                      tabs: const [
                        Tab(
                          text: 'Day',
                        ),
                        Tab(
                          text: 'Week',
                        ),
                        Tab(
                          text: 'Month',
                        ),
                        Tab(
                          text: 'Year',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        const TabBarView(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Insets.dim_24,
                              ),
                              child: LineChartWidget(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Insets.dim_24,
                              ),
                              child: LineChartWidget(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Insets.dim_24,
                              ),
                              child: LineChartWidget(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Insets.dim_24,
                              ),
                              child: LineChartWidget(),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.black
                                .withOpacity(isShowingMainData ? 1.0 : 0.5),
                          ),
                          onPressed: () {
                            setState(() {
                              isShowingMainData = !isShowingMainData;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const YBox(Insets.dim_22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.dim_16),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      'Transaction',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textHeaderColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ClickableFormField(
                      hintText: 'All',
                      labelStyle: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textHeaderColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      onPressed: () async {
                        authProvider.showNavBar = true;
                        final result = await FutureBottomSheet<String>(
                          future: () => Future.value([
                            'All',
                            'Pending',
                            'Done',
                          ]),
                          title: 'Select an option',
                          itemBuilder: (context, item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 8,
                              ),
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            );
                          },
                        ).show(context);
                        authProvider.showNavBar = false;

                        if (result != null) {
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const YBox(Insets.dim_22),
            SizedBox(
              height: context.getHeight(0.5),
              child: const TransactionList(),
            ),
            const YBox(Insets.dim_14),
          ],
        ),
      ),
    );
  }
}
