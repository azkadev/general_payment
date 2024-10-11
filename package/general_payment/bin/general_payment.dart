import 'package:general_lib/general_lib.dart';
import 'package:general_payment/general_payment.dart'; 

void main(List<String> arguments) async {

        // production_token: "xnd_production_hstOUOUQoO2IKT7STFXPw9tjaTIPdePNigXoTZ8E0BjubO7xOqHvQSM95YCjm7A",
        // development_token: "xnd_production_hstOUOUQoO2IKT7STFXPw9tjaTIPdePNigXoTZ8E0BjubO7xOqHvQSM95YCjm7A",
  print("Heelo");

  final GeneralPayment generalPayment = GeneralPayment();
  generalPayment.ensureInitialized();
  final result = await generalPayment.createInvoice(
    external_id: "asas",
    amount: 100,
    generalPaymentAuth: GeneralPaymentAuth.auto(paymentGatewayApiKey: "xnd_production_hstOUOUQoO2IKT7STFXPw9tjaTIPdePNigXoTZ8E0BjubO7xOqHvQSM95YCjm7A", paymentGatewayOwnerId: ""),
  );
  result.rawData.printPretty();
}
