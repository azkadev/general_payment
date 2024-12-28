import 'package:general_payment/package/xendit/scheme/respond_scheme/invoice.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

extension XenditExtensionGetInvoice on Xendit {
  Future<Invoice> getInvoice({
    String forUserId = "",
    required String invoice_id,
    required String xenditApiKey,
  }) async {
    return await invokeRaw(
      parameters: XenditInvokeParameters(
        endpoint: "GET https://api.xendit.co/v2/invoices/$invoice_id",
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
