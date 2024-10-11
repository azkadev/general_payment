import 'package:general_payment/converter/invoice.dart';
import 'package:general_payment/general_payment_auth.dart';
import 'package:general_payment/general_payment_core.dart';
import 'package:general_payment/scheme/respond_scheme/invoice.dart';
import 'package:general_payment/package/xendit/xendit.dart';

extension GeneralPaymentExtensiongetInvoice on GeneralPayment {
  Future<Invoice> getInvoice({
    String forUserId = "",
    required String invoice_id,
    required GeneralPaymentAuth generalPaymentAuth,
  }) async {
    return await invokeBuilder(
      generalPaymentAuth: generalPaymentAuth,
      onXendit: (generalPaymentAuth) async {
        final result = await xendit.getInvoice(
          xenditApiKey: generalPaymentAuth.apiKey,
          forUserId: forUserId,
          invoice_id: invoice_id,
        );

        return result.toGeneralPaymentInvoice();
      },
      onMidtrans: (generalPaymentAuth) {
        return Invoice({
          "@type": "error",
          "message": "unimplemented",
        });
      },
      onCoinlox: (generalPaymentAuth) {
        return Invoice({
          "@type": "error",
          "message": "unimplemented",
        });
      },
      onUnknown: (generalPaymentAuth) {
        return Invoice({
          "@type": "error",
          "message": "unimplemented",
        });
      },
    );
  }
}
