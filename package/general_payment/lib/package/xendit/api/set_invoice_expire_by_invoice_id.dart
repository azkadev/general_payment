import 'package:general_payment/package/xendit/scheme/respond_scheme/invoice.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

extension XenditExtensionsetInvoiceExpireByInvoiceId on Xendit {
  Future<Invoice> setInvoiceExpireByInvoiceId({
    String forUserId = "",
    required String invoice_id,
    required String xenditApiKey,
  }) async {
    return await invokeRaw(
      parameters: XenditInvokeParameters(
        endpoint: "POST https://api.xendit.co/invoices/$invoice_id/expire!",
        xenditApiKey: xenditApiKey,
        headers: {
          "for-user-id": forUserId,
        },
        builder: (result) {
          return Invoice(result);
        },
        specialTypeSucces: "invoice",
        parameters: {},
        queryParameters: {},
        isThrowOnError: false,
      ),
    );
  }
}
