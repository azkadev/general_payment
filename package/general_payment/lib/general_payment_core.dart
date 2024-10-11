// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:general_payment/general_payment_auth.dart';
import 'package:http/http.dart';
import 'package:general_payment/package/xendit/xendit_core.dart';

class GeneralPayment {
  late final Xendit xendit;
  static late final Client httpClient;
  static bool is_http_client_initialized = false;
  bool is_payment_gateway_initialized = false;

  GeneralPayment();

  static void ensureInitializedGeneralPayment({
    required Client httpClient,
  }) {
    if (is_http_client_initialized) {
      return;
    }
    GeneralPayment.httpClient = httpClient;
    is_http_client_initialized = true;
  }

  void ensureInitialized({
    Client? httpClient,
  }) {
    if (is_http_client_initialized == false) {
      GeneralPayment.httpClient = httpClient ?? Client();
      is_http_client_initialized = true;
    }
    if (is_payment_gateway_initialized) {
      return;
    }
    xendit = Xendit( 
      httpClient: httpClient,
    );
    is_payment_gateway_initialized = true;
  }

  FutureOr<T> invokeBuilder<T>({
    required GeneralPaymentAuth generalPaymentAuth,
    required InvokeFunctionBuilder<T> onXendit,
    required InvokeFunctionBuilder<T> onMidtrans,
    required InvokeFunctionBuilder<T> onCoinlox,
    required InvokeFunctionBuilder<T> onUnknown,
  }) async {
    switch (generalPaymentAuth.generalPaymentType) {
      case GeneralPaymentType.xendit:
        return await onXendit(generalPaymentAuth);
      case GeneralPaymentType.midtrans:
        return await onMidtrans(generalPaymentAuth);
      case GeneralPaymentType.coinlox:
        return await onCoinlox(generalPaymentAuth);
      default:
        return await onUnknown(generalPaymentAuth);
    }
  }
}

typedef InvokeFunctionBuilder<T> = FutureOr<T> Function(GeneralPaymentAuth generalPaymentAuth);
