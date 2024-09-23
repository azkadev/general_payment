import 'package:general_lib/general_lib.dart';
import 'package:general_payment/general_payment.dart'; 

void main(List<String> arguments) async {
  print("Heelo");

  final GeneralPayment generalPayment = GeneralPayment();
  generalPayment.ensureInitialized();
  final result = await generalPayment.createInvoice(
    external_id: "asas",
    amount: 100,
    generalPaymentAuth: GeneralPaymentAuth.auto(paymentGatewayApiKey: "xnd_development_sapslap", paymentGatewayOwnerId: ""),
  );
  result.rawData.printPretty();
}
