import 'package:general_payment/package/xendit/scheme/respond_scheme/pay_out_link.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

extension XenditExtensiongetPayOutLinkById on Xendit {
  Future<PayOutLink> getPayOutLinkById({
    String forUserId = "",
    required String id,
    required String xenditApiKey,
  }) async { 
    return await invokeRaw(
      parameters: XenditInvokeParameters(
      endpoint: "GET https://api.xendit.co/payouts/$id",
      xenditApiKey: xenditApiKey,
      headers: {
        "for-user-id": forUserId,
      },
      builder: (result) {
        return PayOutLink(result);
      },
        specialTypeSucces: "payOutLink",
        parameters: {},
        queryParameters: {},
        isThrowOnError: false,
      ),
    );
  }
}
