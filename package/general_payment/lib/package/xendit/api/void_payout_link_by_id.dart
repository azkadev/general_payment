import 'package:general_payment/package/xendit/scheme/respond_scheme/pay_out_link.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

extension XenditExtensionvoidPayOutLinkById on Xendit {
  Future<PayOutLink> voidPayOutLinkById({
    String forUserId = "",
    required String xenditApiKey,
    required String id,
  }) async {
    return await invokeRaw(
      parameters: XenditInvokeParameters(
        endpoint: "POST https://api.xendit.co/payouts/$id/void",
        xenditApiKey: xenditApiKey,
        headers: {
          "for-user-id": forUserId,
        },
        builder: (result) {
          return PayOutLink(result);
        },
        specialTypeSucces: "payOutLink",
        queryParameters: {},
        isThrowOnError: false,
        parameters: {},
      ),
    );
  }
}
