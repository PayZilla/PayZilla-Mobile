import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/qr/qr.dart';

// ignore: one_member_abstracts
abstract class IQRRemoteDataSource {
  Future<TransferValidateModel> validateQR(ValidateQRDto params);
}

class QRRemoteDataSource implements IQRRemoteDataSource {
  QRRemoteDataSource(this.http);

  final HttpManager http;
  @override
  Future<TransferValidateModel> validateQR(ValidateQRDto params) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          userEndpoints.qrValidate,
          params.toMap(),
        ),
      );
      if (response.isResultOk) {
        return TransferValidateModel.fromJson(response.data);
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }
}
