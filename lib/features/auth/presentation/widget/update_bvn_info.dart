import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

FutureBottomSheet<Widget> showBvnInfoUpdate({
  bool dismissible = true,
  required void Function(List<String>) onTap,
  required BuildContext context,
}) {
  final nameTEC = TextEditingController();
  final phoneTEC = TextEditingController();

  return FutureBottomSheet<Widget>(
    future: () => Future.value([]),
    height: context.getHeight(0.5),
    isDismissible: dismissible,
    title: 'Update Bvn Info',
    searchWidget: Column(
      children: [
        const YBox(Insets.dim_34),
        AppTextFormField(
          hintText: 'Full name',
          labelText: 'Full name (eg. John Doe)',
          controller: nameTEC,
          inputType: TextInputType.text,
          validator: (input) => Validators.validateFullName()(input),
        ),
        const YBox(Insets.dim_24),
        PhoneNumberTextFormField(
          key: const ValueKey('09'),
          labelText: 'Phone Number',
          hintText: 'Phone Number',
          controller: phoneTEC,
        ),
        const YBox(Insets.dim_60),
        AppSolidButton(
          textTitle: 'Update',
          action: () {
            if (phoneTEC.text.isNotEmpty && nameTEC.text.isNotEmpty) {
              onTap([nameTEC.text, phoneTEC.text]);
              AppNavigator.of(context).popDialog();
            } else {
              showErrorNotification(context, 'Enter valid BVN information');
            }
          },
        ),
      ],
    ),
    itemBuilder: (context, item) {
      return const SizedBox.shrink();
    },
  );
}
