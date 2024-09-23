// ignore_for_file: non_constant_identifier_names

enum GeneralPaymentType {
  xendit,
  midtrans,
  coinlox,
  unknown,
}

class GeneralPaymentAuth {
  final String apiKey;
  final String ownerId;
  final GeneralPaymentType generalPaymentType;
  GeneralPaymentAuth({
    required this.apiKey,
    required this.ownerId,
    required this.generalPaymentType,
  });

  static GeneralPaymentAuth auto({
    required String paymentGatewayApiKey,
    required String paymentGatewayOwnerId,
  }) {
    if (RegExp(r"^(xnd_(development|production)_)", caseSensitive: false).hasMatch(paymentGatewayApiKey)) {
      return GeneralPaymentAuth.xendit(
        xenditOwnerId: paymentGatewayOwnerId,
        xenditApiKey: paymentGatewayApiKey,
      );
    }
    return GeneralPaymentAuth(
      apiKey: "",
      ownerId: paymentGatewayOwnerId,
      generalPaymentType: GeneralPaymentType.unknown,
    );
  }

  static GeneralPaymentAuth xendit({
    required String xenditApiKey,
    required String xenditOwnerId,
  }) {
    return GeneralPaymentAuth(
      apiKey: xenditApiKey,
      ownerId: xenditOwnerId,
      generalPaymentType: GeneralPaymentType.xendit,
    );
  }
}
