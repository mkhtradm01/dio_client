library dio_client;

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///This is a super class for handling all api integration.
class DioClient {
  ///This creates a new instances of [DioClient] and initializes it with the
  ///[BaseOptions] [_baseOptions]
  DioClient({required String baseUrl}) {
    client = Dio(
      _baseOptions..baseUrl = baseUrl,
    );
    baseUrl = baseUrl;
  }

  ///[baseUrl]
  late String baseUrl;

  ///[client] is a [Dio] object.
  late Dio client;

  ///This contains all other base options like headers, contentType
  ///
  ///though not all endpoints use the same headers, so we will just leave it
  ///like this, can be updated whenever we need a universal options to be added.
  final _baseOptions = BaseOptions(
    headers: <String, dynamic>{
      'Access-Control-Allow-Headers': 'Access-Control-Allow-Origin, Accept',
    },
  );

  ///[contentType] can be any, default is set to application/json
  ///
  ///[onSendProgress] is a callback which takes sentData and totalData to track
  ///the progress of what is uploading or sent to server,
  ///[onReceiveProgress] is another callback to keep track of downloads or
  ///data to be received.
  ///[queryParameters] takes parameters for the request query.
  ///[path] is the endpoint path.
  ///[body] is the content of the request, can be null.
  Future<Response<dynamic>> postRequest({
    required String path,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    String contentType = 'application/json',
    Map<String, dynamic>? body,
  }) async {
    final requestBody = jsonEncode(body);
    //holds request options
    final options = Options(
      responseType: ResponseType.json,
      contentType: contentType,
    );

    debugPrint('================API REQUEST================');
    debugPrint('REQUEST BODY: $body');
    try {
      final response = await client.post<dynamic>(
        path,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: options,
        data: requestBody,
      );
      debugPrint('================API RESPONSE================');
      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('DATA: ${response.data}');
      return response;
    } on DioError catch (e) {
      //any logging platform can be configured like firebase crashlytics
      debugPrint('DioError: $e');
      rethrow;
    }
  }

  ///[contentType] can be any, default is set to application/json
  ///
  ///[onReceiveProgress] is another callback to keep track of downloads or
  ///data to be received.
  ///[queryParameters] takes parameters for the request query.
  ///[path] is the endpoint path.
  Future<Response<dynamic>> getRequest({
    required String path,
    void Function(int, int)? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    String contentType = 'application/json',
  }) async {
    //holds request options
    final options = Options(
      responseType: ResponseType.json,
      contentType: contentType,
    );

    debugPrint('================API REQUEST================');
    // debugPrint('REQUEST BODY: $body');
    try {
      final response = await client.get<dynamic>(
        path,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        options: options,
      );

      debugPrint('================API RESPONSE================');
      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('DATA: ${response.data}');
      return response;
    } on DioError catch (e) {
      debugPrint('DioError: $e');
      rethrow;
    }
  }

  ///[contentType] can be any, default is set to application/json
  ///
  ///[queryParameters] takes parameters for the request query.
  ///[path] is the endpoint path.
  ///[body] is the content of the request, can be null.
  Future<Response<dynamic>> deleteRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    String contentType = 'application/json; charset=UTF-8',
  }) async {
    final requestBody = jsonEncode(body);

    //holds request options
    final options = Options(
      responseType: ResponseType.json,
      contentType: contentType,
    );

    debugPrint('================API REQUEST================');
    debugPrint('REQUEST BODY: $body');
    try {
      final response = await client.delete<dynamic>(
        path,
        queryParameters: queryParameters,
        options: options,
        data: requestBody,
      );

      debugPrint('================API RESPONSE================');
      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('DATA: ${response.data}');
      return response;
    } on DioError catch (e) {
      debugPrint('DioError: $e');
      rethrow;
    }
  }

  ///[contentType] can be any, default is set to application/json
  ///
  ///[onSendProgress] is a callback which takes sentData and totalData to track
  ///the progress of what is uploading or sent to server,
  ///[onReceiveProgress] is another callback to keep track of downloads or
  ///data to be received.
  ///[queryParameters] takes parameters for the request query.
  ///[path] is the endpoint path.
  ///[body] is the content of the request, can be null.
  Future<Response<dynamic>> updateRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    String contentType = 'application/json',
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    final requestBody = jsonEncode(body);

    //holds request options
    final options = Options(
      responseType: ResponseType.json,
      contentType: contentType,
    );

    debugPrint('================API REQUEST================');
    debugPrint('REQUEST BODY: $body');
    try {
      final response = await client.put<dynamic>(
        path,
        queryParameters: queryParameters,
        options: options,
        data: requestBody,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      debugPrint('================API RESPONSE================');
      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('DATA: ${response.data}');
      return response;
    } on DioError catch (e) {
      debugPrint('DioError: $e');
      rethrow;
    }
  }
}
