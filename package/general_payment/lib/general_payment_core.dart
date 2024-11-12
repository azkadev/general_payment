// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:general_payment/general_payment_auth.dart';
import 'package:general_payment/package/package.dart';
import 'package:http/http.dart' as http;

typedef GeneralPaymentFunction = GeneralPayment Function();

abstract class GeneralPaymentBaseCore {
  FutureOr<T> invokeBuilder<T>({
    required GeneralPaymentInvokeParameters<T> parameters,
  }) async {
    throw UnimplementedError();
  }
}

abstract class GeneralPaymentCore implements GeneralPaymentBaseCore {
  final GeneralPaymentFunction onGeneralPayment;
  GeneralPaymentCore({
    required this.onGeneralPayment,
  });

  GeneralPayment get generalPayment {
    return onGeneralPayment();
  }

  @override
  FutureOr<T> invokeBuilder<T>({
    required GeneralPaymentInvokeParameters<T> parameters,
  }) async {
    return await generalPayment.invokeBuilder(
      parameters: parameters,
    );
  }
}

class GeneralPaymentInvokeParameters<T> {
  final String url;
  final Map<String, dynamic>? queryParameters;
  final Map? headers;
  final String method;
  final Map? parameters;
  final bool isThrowOnError;
  final FutureOr<T> Function(http.Response response) builder;
  const GeneralPaymentInvokeParameters({
    required this.url,
    required this.isThrowOnError,
    required this.queryParameters,
    required this.headers,
    required this.method,
    required this.parameters,
    required this.builder,
  });

  GeneralPaymentInvokeParameters copyWith({
    String? url,
    Map<String, dynamic>? queryParameters,
    Map<dynamic, dynamic>? headers,
    String? method,
    bool? isThrowOnError,
    Map<dynamic, dynamic>? parameters,
    FutureOr<dynamic> Function(http.Response response)? builder,
  }) {
    return GeneralPaymentInvokeParameters(
      url: url ?? this.url,
      queryParameters: queryParameters ?? this.queryParameters,
      isThrowOnError: isThrowOnError ?? this.isThrowOnError,
      headers: headers ?? this.headers,
      method: method ?? this.method,
      parameters: parameters ?? this.parameters,
      builder: builder ?? this.builder,
    );
  }
}

class GeneralPayment implements GeneralPaymentCore {
  static late final http.Client httpClient;
  static bool is_http_client_initialized = false;
  bool is_payment_gateway_initialized = false;

  GeneralPayment();

  static void ensureInitializedGeneralPayment({
    required http.Client httpClient,
  }) {
    if (is_http_client_initialized) {
      return;
    }
    GeneralPayment.httpClient = httpClient;
    is_http_client_initialized = true;
  }

  void ensureInitialized({
    http.Client? httpClient,
  }) {
    ensureInitializedGeneralPayment(httpClient: httpClient ?? http.Client());
    if (is_payment_gateway_initialized) {
      return;
    }
    is_payment_gateway_initialized = true;
  }

  void utilsAddHeaders({
    required Map<String, String> headers,
    required Map? newHeaders,
  }) {
    (newHeaders ?? {}).forEach((key, value) {
      if (key == "@type") {
        return;
      }
      if (key is String && value is String) {
        headers[key] = value;
      }
    });
  }

  @override
  FutureOr<T> invokeBuilder<T>({
    required GeneralPaymentInvokeParameters<T> parameters,
  }) async {
    final String method = parameters.method.trim().toLowerCase();
    final uri = Uri.parse(parameters.url).replace(
      queryParameters: parameters.queryParameters,
    );
    final Map<String, String> requestHeaders = {
      'Accept': '*/*',
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    };
    utilsAddHeaders(headers: requestHeaders, newHeaders: parameters.headers);
    final parameter = parameters.parameters ?? {};
    try {
      final http.Response res = await Future(() async {
        if (method == "post") {
          return await GeneralPayment.httpClient.post(
            uri,
            headers: requestHeaders,
            body: json.encode(parameter),
          );
        } else if (method == "patch") {
          return await GeneralPayment.httpClient.patch(
            uri,
            headers: requestHeaders,
            body: json.encode(parameter),
          );
        } else {
          return await GeneralPayment.httpClient.get(
            uri,
            headers: requestHeaders,
          );
        }
      });
      return await parameters.builder(res);
    } catch (e) {
      if (parameters.isThrowOnError) {
        rethrow;
      }
      final http.Response result = () {
        if (e is http.ClientException) {
          return http.Response("network_error", 600);
        } else if (e is String) {
          return http.Response(e, 600);
        } else if (e is Map) {
          return http.Response(json.encode(e), 600);
        }
        return http.Response("error", 600);
      }();

      return await parameters.builder(result);
    }
  }

  @override
  // TODO: implement generalPayment
  GeneralPayment get generalPayment => this;

  @override
  // TODO: implement onGeneralPayment
  GeneralPaymentFunction get onGeneralPayment => () {
        return this;
      };
  FutureOr<T> paymentInvokeBuilder<T>({
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

  late final Xendit xendit = Xendit(
    onGeneralPayment: onGeneralPayment,
  );
}

typedef InvokeFunctionBuilder<T> = FutureOr<T> Function(GeneralPaymentAuth generalPaymentAuth);
