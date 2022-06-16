import 'package:dio/dio.dart';
import 'package:dio_client/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('🧪DioClient Unit Tests', () {
    const baseUrl = 'https://jsonplaceholder.typicode.com';
    test('🧪Test [getRequest]', () async {
      final dioClient = DioClient(baseUrl: baseUrl);
      final response = await dioClient.getRequest(path: '/posts');
      expect(response.statusCode, 200);
    });
    test('🧪Failed [getRequest] with Exception', () async {
      late dynamic error;
      final dioClient = DioClient(baseUrl: 'fadlfakf fake baseUrl');
      try {
        await dioClient.getRequest(path: '//');
      } on Exception catch (e) {
        error = e;
      }
      expect(error, isNotNull);
      expect(error is Exception, isTrue);
    });
    test('🧪Test [postRequest]', () async {
      final dioClient = DioClient(baseUrl: baseUrl);
      final reqBody = {'title': 'foo', 'body': 'bar', 'userId': 1};
      final response = await dioClient.postRequest(
        path: '/posts/',
        body: reqBody,
        onSendProgress: (progress, total) {
          debugPrint('Progress: $progress, Total: $total');
        },
      );
      expect(response.statusCode, 201);
    });
    test('🧪Test [updateRequest]', () async {
      final dioClient = DioClient(baseUrl: baseUrl);
      final reqBody = {'id': 101, 'title': 'foo', 'body': 'bar', 'userId': 1};
      final response = await dioClient.updateRequest(
        path: '/posts/1',
        body: reqBody,
        onSendProgress: (progress, total) {
          debugPrint('Progress: $progress, Total: $total');
        },
      );
      expect(response.statusCode, 200);
    });
    test('🧪Test [deleteRequest]', () async {
      final dioClient = DioClient(baseUrl: baseUrl);
      try {
        final response = await dioClient.deleteRequest(
          path: '/posts/1',
        );

        expect(response.statusCode, 200);
      } on Exception catch (e) {
        expect(e is DioError, isTrue);
      }
    });
  });
}
