import 'package:general_payment/general_payment_auth.dart';
import 'package:general_payment/general_payment_core.dart';
import 'package:general_payment/scheme/respond_scheme/account.dart';

import 'package:general_payment/package/xendit/xendit.dart';

extension GeneralPaymentExtensiongetWalletAccountbyId on GeneralPayment {
  Future<Account> getWalletAccountbyId({
    String? walletId,
    bool isOwned = true,
    required GeneralPaymentAuth generalPaymentAuth,
  }) async {
    return await invokeBuilder(
      generalPaymentAuth: generalPaymentAuth,
      onXendit: (generalPaymentAuth) async {
        final String wallet_id = (isOwned) ? "" : walletId ?? "";
        if (isOwned) {
          return Account.create(
            id: "owner_id",
            email: "owner@gmail.com",
          );
        }
        final account = await xendit.getAccount(id: wallet_id, xenditApiKey: generalPaymentAuth.apiKey,);
        return Account(account.toJson());
      },
      onMidtrans: (generalPaymentAuth) {
        return Account({
          "@type": "error",
          "message": "unimplemented",
        });
      },
      onCoinlox: (generalPaymentAuth) {
        return Account({
          "@type": "error",
          "message": "unimplemented",
        });
      },
      onUnknown: (generalPaymentAuth) {
        return Account({
          "@type": "error",
          "message": "unimplemented",
        });
      },
    );
  }
}
