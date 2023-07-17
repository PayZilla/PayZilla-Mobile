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

  @override
  void initState() {
    super.initState();
    listItems = context
        .read<AuthProvider>()
        .reasonsList
        .map(MultiSelectItem.new)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return AppScaffold(
      appBar: CustomAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: Insets.dim_24),
          child: AppBoxedButton(
            onPressed: () => AppNavigator.of(context).pop(),
          ),
        ),
        leadingWidth: 80,
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
              'We need to know this for regulatory reasons. And also we’re curious!',
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
                itemCount: provider.reasonsList.length,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
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
              action: () =>
                  AppNavigator.of(context).push(AppRoutes.reasonsToPin),
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
        item.selected ? AppColors.white : AppColors.btnPrimaryColor;

    final bgColor = item.selected ? AppColors.btnPrimaryColor : AppColors.white;

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
          color: bgColor,
          border: Border.all(color: AppColors.borderColor),
          borderRadius: Corners.mdBorder,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const YBox(Insets.dim_22),
            LocalSvgImage(
              product.image,
              color: textColor,
              height: 24,
            ),
            const Spacer(),
            Text(
              product.title,
              style: context.textTheme.bodyMedium!.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: Insets.dim_14,
              ),
            ),
            const YBox(Insets.dim_22),
          ],
        ),
      ),
    );
  }
}
