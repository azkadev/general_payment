import 'package:general_payment/package/xendit/scheme/respond_scheme/account.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

extension XenditExtensiongetAccount on Xendit {
  Future<Account> getAccount({
    required String id,
    required String xenditApiKey,
    Map<String, String>? headers,
  }) async {
    return await invokeRaw<Account>(
      parameters: XenditInvokeParameters(
        endpoint: "GET https://api.xendit.co/v2/accounts/$id",
        headers: headers,
        xenditApiKey: xenditApiKey,
        builder: (result) {
          return Account(result);
        },
        parameters: {},
        queryParameters: {},
        specialTypeSucces: "account",
        isThrowOnError: false,
      ),
    );
  }
}
