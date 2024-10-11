import 'package:general_payment/converter/invoice.dart';
import 'package:general_payment/general_payment_auth.dart';
import 'package:general_payment/general_payment_core.dart';
import 'package:general_payment/scheme/respond_scheme/invoice.dart';
import 'package:general_payment/package/xendit/xendit.dart';

extension GeneralPaymentExtensionCreateInvoice on GeneralPayment {
  Future<Invoice> createInvoice({
    String forUserId = "",
    String withFeeRule = "",
    required String external_id,
    required int amount,
    String? description,
    String? payer_email,
    Map<dynamic, dynamic>? customer,
    Map<dynamic, dynamic>? customer_notification_preference,
    int? invoice_duration,
    String? success_redirect_url,
    String? failure_redirect_url,
    List<String>? payment_methods,
    String? currency,
    bool? fixed_va,
    String? callback_virtual_account_id,
    String? mid_label,
    String? reminder_time_unit,
    int? reminder_time,
    String? locale,
    List<dynamic>? items,
    List<dynamic>? fees,
    bool? should_authenticate_credit_card,
    Map<String, String>? headers,
    required GeneralPaymentAuth generalPaymentAuth,
  }) async {
    return await invokeBuilder(
      generalPaymentAuth: generalPaymentAuth,
      onXendit: (generalPaymentAuth) async {
        final result = await xendit.createInvoice(
          xenditApiKey: generalPaymentAuth.apiKey,
          external_id: external_id,
          amount: amount,
          forUserId: forUserId,
          failure_redirect_url: failure_redirect_url,
          fees: fees,
          fixed_va: fixed_va,
          withFeeRule: withFeeRule,
          payer_email: payer_email,
          reminder_time: reminder_time,
          reminder_time_unit: reminder_time_unit,
          success_redirect_url: success_redirect_url,
          invoice_duration: invoice_duration,
          items: items,
          payment_methods: payment_methods,
          customer_notification_preference: customer_notification_preference,
          should_authenticate_credit_card: should_authenticate_credit_card,
          callback_virtual_account_id: callback_virtual_account_id,
          description: description,
          headers: headers,
          locale: locale,
          mid_label: mid_label,
          currency: currency,
          customer: customer,
        );

        return result.toGeneralPaymentInvoice();
      },
      onMidtrans: (generalPaymentAuth) {
        return Invoice({
          "@type": "error",
          "message": "unimplemented",
        });
      },
      onCoinlox: (generalPaymentAuth) {
        return Invoice({
          "@type": "error",
          "message": "unimplemented",
        });
      },
      onUnknown: (generalPaymentAuth) {
        return Invoice({
          "@type": "error",
          "message": "unimplemented",
        });
      },
    );
  }
}
