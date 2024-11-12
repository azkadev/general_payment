import 'package:general_payment/package/xendit/scheme/respond_scheme/pay_out_link.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

extension XenditExtensioncreatePayOutLink on Xendit {
  Future<PayOutLink> createPayOutLink({
    String forUserId = "",
    required String external_id,
    required int amount,
    required String email,
    required String xenditApiKey,
  }) async { 
    return await invokeRaw<PayOutLink>(
      parameters: XenditInvokeParameters(
        
      endpoint: "POST https://api.xendit.co/payouts",
      xenditApiKey: xenditApiKey,
      headers: {
        "for-user-id": forUserId,
      },
      parameters: {
        "external_id": external_id,
        "amount": amount,
        "email": email,
      },
        queryParameters: {},
        specialTypeSucces: "payOutLink",
        isThrowOnError: false,
        builder: (result) {
          return PayOutLink(result);
        },
      ),
    );
  }
}
