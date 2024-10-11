import 'package:general_payment/package/xendit/scheme/respond_scheme/pay_out_link.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

extension XenditExtensiongetPayOutLinkById on Xendit {
  Future<PayOutLink> getPayOutLinkById({
    String forUserId = "",
    required String id,
      required String xenditApiKey,

  }) async {
    return await invokeBuilder(
      endpoint: "GET https://api.xendit.co/payouts/$id",
      xenditApiKey: xenditApiKey,
      headers: {
        "for-user-id": forUserId,
      },
      onResult: (result) {
        return PayOutLink(result);
      },
    );
  }
}
