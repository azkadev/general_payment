import 'package:general_payment/package/xendit/scheme/respond_scheme/invoices.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

extension XenditExtensionGetInvoices on Xendit {
  Future<Invoices> getInvoices({
    String forUserId = "",
    required String xenditApiKey,
  }) async { 
    return await invokeRaw(
      parameters: XenditInvokeParameters(
      endpoint: "GET https://api.xendit.co/v2/invoices",
      xenditApiKey: xenditApiKey,
      headers: {
        "for-user-id": forUserId,
      },
        builder: (result) {

          return Invoices(result);
        },
        specialTypeSucces: "invoices",
        parameters: {},
        queryParameters: {},
        isThrowOnError: false,
      ),
    );
  }
}
