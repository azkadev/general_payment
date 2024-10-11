import 'package:general_payment/package/xendit/scheme/respond_scheme/account.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

extension XenditExtensionupdateAccount on Xendit {
  Future<Account> updateAccount({
    required String id,
    required String email,
    required String bussiness_name,
    Map<String, String>? headers,
      required String xenditApiKey,

  }) async {
    return await invokeBuilder(
      endpoint: "PATCH https://api.xendit.co/v2/accounts/{id}",
      xenditApiKey: xenditApiKey,
      parameters: {
        "email": email,
        "public_profile": {
          "business_name": bussiness_name,
        },
      },
      headers: headers,
      onResult: (result) {
        return Account(result);
      },
    );
  }
}
