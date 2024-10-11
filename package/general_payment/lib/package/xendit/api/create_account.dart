import 'package:general_payment/package/xendit/scheme/respond_scheme/account.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

extension XenditExtensioncreateAccount on Xendit {
  Future<Account> createAccount({
    required String email,
    required String type,
    required String bussiness_name,
      required String xenditApiKey,

    Map<String, String>? headers,
  }) async {
    return await invokeBuilder(
      endpoint: "POST https://api.xendit.co/v2/accounts",
      xenditApiKey: xenditApiKey,
      parameters: {
        "email": email,
        "type": type,
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
