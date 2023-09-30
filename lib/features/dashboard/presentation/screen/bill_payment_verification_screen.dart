import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/mixins/form_mixin.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class BillPaymentVerificationScreenArgs {
  BillPaymentVerificationScreenArgs(this.billPaymentDto);

  final BillPaymentDto billPaymentDto;
}

class BillPaymentVerificationScreen extends StatefulWidget {
  const BillPaymentVerificationScreen({
    super.key,
    required this.args,
  });

  final BillPaymentVerificationScreenArgs args;

  @override
  State<BillPaymentVerificationScreen> createState() =>
      _BillPaymentVerificationScreenState();
}

class _BillPaymentVerificationScreenState
    extends State<BillPaymentVerificationScreen> with FormMixin {
  late BillPaymentDto requestDto;
  @override
  void initState() {
    super.initState();

    requestDto = widget.args.billPaymentDto;
  }

  @override
  Widget build(BuildContext context) {
    final dsProvider = context.watch<DashboardProvider>();
    return AppScaffold(
      useBodyPadding: false,
      appBar: CustomAppBar(
        centerTitle: true,
        titleWidget: Text(
          'Pay ${dsProvider.model.serviceName}',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.dim_22),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const YBox(Insets.dim_12),
                AppTextFormField(
                  initialValue: requestDto.customerId,
                  hintText: 'Enter payment ID number',
                  isLoading: dsProvider.payBillResponse.isLoading,
                  inputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (value) {
                    requestDto = requestDto.copyWith(customerId: value);
                  },
                  validator: (input) => Validators.validateString()(input),
                ),
                const YBox(Insets.dim_4),
                if (dsProvider.payBillResponse.isLoading)
                  Row(
                    children: const [
                      Spacer(),
                      AppCircularLoadingWidget(
                        color: AppColors.textHeaderColor,
                      ),
                    ],
                  ),
                if (dsProvider.payBillResponse.isSuccess)
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        dsProvider.payBillResponse.data ?? '',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.textHeaderColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ],
                  ),
                if (dsProvider.payBillResponse.isSuccess) ...[
                  const YBox(Insets.dim_14),
                  AppTextFormField(
                    hintText: '00.00',
                    labelText: 'Amount',
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    inputType: TextInputType.number,
                    validator: (input) => Validators.validateAmount()(
                      input,
                    ),
                    onSaved: (value) {},
                    isLoading: dsProvider.payBillResponse.isLoading,
                    controller: dsProvider.amountController,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.textHeaderColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const YBox(Insets.dim_24),
                  PinTextField(
                    validator: (input) => Validators.validateString()(
                      input,
                    ),
                    controller: dsProvider.pinController,
                    onSaved: (input) {},
                    labelText: 'Transaction PIN',
                  ),
                ],
                if (dsProvider.payBillResponse.isSuccess)
                  YBox(context.getHeight(0.45))
                else
                  YBox(context.getHeight(0.7)),
                AppButton(
                  textTitle:
                      dsProvider.payBillResponse.isSuccess ? 'Send' : 'Verify',
                  showLoading: dsProvider.billPaymentRES.isLoading ||
                      dsProvider.payBillResponse.isLoading,
                  action: () {
                    validate(() {
                      if (dsProvider.payBillResponse.isSuccess) {
                        // put bill name here back
                        requestDto = requestDto.copyWith(
                          billName: widget.args.billPaymentDto.billName,
                          variationCode: '',
                          serviceId: '',
                          amount:
                              dsProvider.amountController.text.toInt() * 100,
                          pin: dsProvider.pinController.text,
                          varianceCode:
                              widget.args.billPaymentDto.variationCode,
                        );
                        dsProvider.payBill(requestDto).then((value) {
                          if (dsProvider.billPaymentRES.isSuccess) {
                            showSuccessNotification(
                              dsProvider.billPaymentRES.data ?? 'Success',
                            );
                            AppNavigator.of(context).push(AppRoutes.home);
                          }
                        });
                      } else {
                        // remove bill payment here
                        requestDto = requestDto.copyWith(billName: '');
                        dsProvider.verifyBill(requestDto);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
