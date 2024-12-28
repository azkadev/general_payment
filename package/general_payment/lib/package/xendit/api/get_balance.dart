import 'package:general_payment/package/xendit/scheme/respond_scheme/balance.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

extension XenditExtensiongetBalance on Xendit {
  Future<Balance> getBalance({
    String forUserId = "",
    required String account_type,
    required String xenditApiKey,
  }) async {
    return await invokeRaw<Balance>(
      parameters: XenditInvokeParameters(
        endpoint:
            "GET https://api.xendit.co/balance?account_type=$account_type",
        xenditApiKey: xenditApiKey,
        headers: {
          "for-user-id": forUserId,
        },
        specialTypeSucces: "balance",
        builder: (result) {
          return Balance(result);
        },
        parameters: {},
        queryParameters: {},
        isThrowOnError: false,
      ),
    );
  }
}
