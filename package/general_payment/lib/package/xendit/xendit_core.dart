/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
// ignore_for_file: non_constant_identifier_names, empty_catches, unnecessary_brace_in_string_interps, unused_catch_stack, unnecessary_string_interpolations

import 'dart:async';
import 'dart:convert';

import 'package:general_lib/general_lib.dart';
import 'package:general_payment/extension/map.dart';
import 'package:general_payment/general_payment.dart';
import 'package:general_payment/package/xendit/scheme/respond_scheme/respond_scheme.dart';

/// xendit helo world heo gais
class Xendit extends GeneralPaymentCore {
  Xendit({
    required super.onGeneralPayment,
  });

  static final RegExp regExp_http_method =
      RegExp(r"^(get|post|patch)([ ]+)?", caseSensitive: false);

  /// request method support all update
  FutureOr<T> invokeRaw<T>({
    required XenditInvokeParameters<T> parameters,
    // /// GET https://api.xendit.co/v2/invoices/{invoice_id}
  }) async {
    parameters.parameters.extension_general_payment_removeValueEmptyOrNull();
    final String methodRequest =
        (regExp_http_method.stringMatch(parameters.endpoint) ?? "get")
            .toLowerCase()
            .replaceAll(RegExp(r"([ ]+)?", caseSensitive: false), "")
            .trim();

    final Map<String, String> requestHeaders = <String, String>{
      "Authorization":
          "Basic ${base64.encode(utf8.encode("${parameters.xenditApiKey}:"))}",
      "Content-Type": 'application/json',
    };

    generalPayment.utilsAddHeaders(
        headers: requestHeaders, newHeaders: parameters.headers);
    return await invokeBuilder<T>(
      parameters: GeneralPaymentInvokeParameters(
        url: parameters.endpoint.replaceAll(regExp_http_method, ""),
        isThrowOnError: true,
        queryParameters: parameters.queryParameters,
        headers: requestHeaders,
        method: methodRequest,
        parameters: parameters.parameters,
        builder: (response) {
          final Map body = {
            "@type": parameters.specialTypeSucces,
          };
          if (response.statusCode != 200) {
            body["@type"] = "error";
          }
          final String raw_data = response.body;
          try {
            final dynamic data = (json.decode(raw_data));
            if (data is List) {
              final String snake_key =
                  parameters.specialTypeSucces.snakeCaseClass();
              body["total_count"] = data.length;
              if (RegExp(r"(s)$", caseSensitive: false).hashData(snake_key)) {
                body["${snake_key}s"] = data;
              } else {
                body[snake_key] = data;
              }
            } else {
              body.addAll(data);
            }
          } catch (e, stack) {
            body.addAll({
              "message": "${raw_data}",
            });
          }
          return parameters.builder(body);
        },
      ),
    );
  }

  Future<TransactionBalanceAccount> transferBalanceAccount({
    required String reference,
    required int amount,
    required String source_user_id,
    required String destination_user_id,
    required String xenditApiKey,
    Map<String, String>? headers,
  }) async {
    return await invokeRaw<TransactionBalanceAccount>(
      parameters: XenditInvokeParameters(
        endpoint: "POST https://api.xendit.co/transfers",
        parameters: {
          "reference": reference,
          "amount": amount,
          "source_user_id": source_user_id,
          "destination_user_id": destination_user_id,
        },
        headers: headers,
        xenditApiKey: xenditApiKey,
        specialTypeSucces: "transactionBalanceAccount",
        isThrowOnError: false,
        queryParameters: {},
        builder: (result) {
          return TransactionBalanceAccount(result);
        },
      ),
    );
  }

  Future<TransactionBalanceAccount> getTransferBalanceAccount({
    required String reference,
    Map<String, String>? headers,
    required String xenditApiKey,
  }) async {
    return await invokeRaw<TransactionBalanceAccount>(
      parameters: XenditInvokeParameters(
        endpoint: "GET https://api.xendit.co/transfers/reference=${reference}",
        parameters: {},
        headers: headers,
        xenditApiKey: xenditApiKey,
        specialTypeSucces: "transactionBalanceAccount",
        isThrowOnError: false,
        queryParameters: {},
        builder: (result) {
          return TransactionBalanceAccount(result);
        },
      ),
    );
  }

  Future<TransactionBalanceAccount> createFeeRule({
    required String name,
    required String description,
    required List<Map> routes,
    required String xenditApiKey,
    Map<String, String>? headers,
  }) async {
    return await invokeRaw<TransactionBalanceAccount>(
      parameters: XenditInvokeParameters(
        endpoint: "POST https://api.xendit.co/fee_rules",
        parameters: {
          "name": name,
          "description": description,
          "routes": routes,
        },
        headers: headers,
        xenditApiKey: xenditApiKey,
        specialTypeSucces: "transactionBalanceAccount",
        isThrowOnError: false,
        queryParameters: {},
        builder: (result) {
          return TransactionBalanceAccount(result);
        },
      ),
    );
  }
}

class XenditInvokeParameters<T> {
  /// GET https://api.xendit.co/v2/invoices/{invoice_id}
  final String endpoint;
  final Map<String, dynamic>? queryParameters;

  final String xenditApiKey;
  final String specialTypeSucces;
  final Map? headers;
  final Map parameters;
  final bool isThrowOnError;
  final FutureOr<T> Function(Map result) builder;
  const XenditInvokeParameters({
    required this.endpoint,
    required this.xenditApiKey,
    required this.specialTypeSucces,
    required this.isThrowOnError,
    required this.queryParameters,
    required this.headers,
    required this.parameters,
    required this.builder,
  });

  XenditInvokeParameters copyWith({
    String? endpoint,
    String? xenditApiKey,
    String? specialTypeSucces,
    bool? isThrowOnError,
    Map<String, dynamic>? queryParameters,
    Map<dynamic, dynamic>? headers,
    String? method,
    Map<dynamic, dynamic>? parameters,
    FutureOr<T> Function(Map result)? builder,
  }) {
    return XenditInvokeParameters(
      queryParameters: queryParameters ?? this.queryParameters,
      isThrowOnError: isThrowOnError ?? this.isThrowOnError,
      headers: headers ?? this.headers,
      parameters: parameters ?? this.parameters,
      builder: builder ?? this.builder,
      endpoint: endpoint ?? this.endpoint,
      xenditApiKey: xenditApiKey ?? this.xenditApiKey,
      specialTypeSucces: specialTypeSucces ?? this.specialTypeSucces,
    );
  }
}
