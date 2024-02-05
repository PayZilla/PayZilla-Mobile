import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class ReasonsScreen extends StatefulWidget {
  const ReasonsScreen({super.key});

  @override
  State<ReasonsScreen> createState() => _ReasonsScreenState();
}

class _ReasonsScreenState extends State<ReasonsScreen> with FormMixin {
  late List<MultiSelectItem<ReasonsModel>> listItems;
  List<String> selected = [];

  @override
  void initState() {
    super.initState();
    listItems = reasonsList.map(MultiSelectItem.new).toList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return AppScaffold(
      appBar: CustomAppBar(
        leading: AppBoxedButton(
          onPressed: () => AppNavigator.of(context).push(AppRoutes.onboarding),
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Main reason for using \nPayZilla',
              style: context.textTheme.headlineLarge!.copyWith(
                color: AppColors.textHeaderColor,
                fontWeight: FontWeight.w700,
                fontSize: Insets.dim_24,
              ),
              textAlign: TextAlign.start,
            ),
            const YBox(Insets.dim_8),
            Text(
              'We need to know this for regulatory reasons.\nPlease select!',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textBodyColor,
                fontWeight: FontWeight.w400,
                fontSize: Insets.dim_16,
              ),
              textAlign: TextAlign.start,
            ),
            const YBox(Insets.dim_16),
            Expanded(
              child: GridView.builder(
                itemCount: reasonsList.length,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        listItems[index].selected = !listItems[index].selected;
                      });
                    },
                    child: getGridItem(listItems[index], index),
                  );
                },
              ),
            ),
            AppSolidButton(
              textTitle: 'Continue',
              showLoading: provider.onboardingResp.isLoading,
              action: () async {
                selected = [];
                for (final i in listItems) {
                  if (i.selected) {
                    selected
                        .add(i.value.title.replaceAll(' ', '_').toLowerCase());
                  }
                }
                if (selected.isEmpty) {
                  showInfoNotification(
                    context,
                    'Select what you would use PayZilla for',
                  );
                  return;
                }
                await provider.purpose(selected, context);
              },
            ),
            const YBox(Insets.dim_16),
          ],
        ),
      ),
    );
  }

  Widget getGridItem(MultiSelectItem item, int index) {
    final product = item.value as ReasonsModel;
    final textColor =
        item.selected ? AppColors.btnPrimaryColor : AppColors.white;

    final bgColor = item.selected ? AppColors.white : AppColors.btnPrimaryColor;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: Corners.mdBorder,
        side: BorderSide(color: AppColors.borderColor),
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: Insets.dim_14,
          right: Insets.dim_20,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.borderColor),
          borderRadius: Corners.mdBorder,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const YBox(Insets.dim_22),
                LocalSvgImage(
                  product.image,
                  color: AppColors.btnPrimaryColor,
                  height: 24,
                ),
                const Spacer(),
                Text(
                  product.title,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.btnPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Insets.dim_14,
                  ),
                ),
                const YBox(Insets.dim_22),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.only(top: Insets.dim_16),
                decoration: BoxDecoration(
                  color: textColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: bgColor),
                ),
                child: Center(
                  child: item.selected
                      ? Icon(
                          Icons.check,
                          color: bgColor,
                        )
                      : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
