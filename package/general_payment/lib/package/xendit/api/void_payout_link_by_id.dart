import 'package:general_payment/package/xendit/scheme/respond_scheme/pay_out_link.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

extension XenditExtensionvoidPayOutLinkById on Xendit {
  Future<PayOutLink> voidPayOutLinkById({
    String forUserId = "",
      required String xenditApiKey,

    required String id,
  }) async {
    return await invokeBuilder(
      endpoint: "POST https://api.xendit.co/payouts/$id/void",
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
