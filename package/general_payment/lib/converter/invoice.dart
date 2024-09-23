import 'package:general_payment/scheme/respond_scheme/invoice.dart' as general_payment_invoice;
import 'package:general_payment/package/xendit/scheme/respond_scheme/invoice.dart' as xendit_invoice;

extension GeneralPaymentXenditInvoiceExtension on xendit_invoice.Invoice {
  general_payment_invoice.Invoice toGeneralPaymentInvoice() {
    return general_payment_invoice.Invoice(toJson());
  }
}
