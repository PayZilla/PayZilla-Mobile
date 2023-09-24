import 'package:flutter/foundation.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/qr/qr.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class QrProvider extends ChangeNotifier {
  QrProvider(this.qrRepository);

  final QrRepository qrRepository;

  ApiResult<TransferValidateModel> qrResponse =
      ApiResult<TransferValidateModel>.idle();

  // cloud upload file
  Future<void> validateQR(ValidateQRDto params) async {
    qrResponse = ApiResult<TransferValidateModel>.loading('Loading...');
    notifyListeners();
    final failureOrQr = await qrRepository.validateQR(params);
    await failureOrQr.fold(
      (failure) {
        qrResponse = ApiResult<TransferValidateModel>.error(failure.message);
        showErrorNotification(failure.message, durationInMills: 2000);
      },
      (res) async {
        qrResponse = ApiResult<TransferValidateModel>.success(res);
      },
    );

    notifyListeners();
  }
}
