import 'dart:io';

import 'package:rightnow/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

const BASE_URL = "https://app.rightnow-by-brenco.com/";
//"https://apptest.rightnow-by-brenco.com/";
const IMG_BASE_URL = "https://app.rightnow-by-brenco.com"; // "https://apptest.rightnow-by-brenco.com";

class ApiClient {
  Dio? _dio;
  final List<Interceptor>? interceptors;

  dynamic requestInterceptor(RequestOptions options) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(AUTH_KEY);
    if (token != null) {
      print("loading api key from shared preferences " + token);
      options.headers['Authorization'] = "Token $token";
    }
    //options.headers.addAll({"Token": "$token${DateTime.now()}"});

    return options;
  }

  ApiClient(Dio dio, {this.interceptors}) {
    _dio = Dio();
    _dio!
      ..options.baseUrl = BASE_URL
      //..options.connectTimeout = _defaultConnectTimeout
      //..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
      };
    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        RequestOptions r = await requestInterceptor(options);
        handler.next(r);
      },
    ));
    if (interceptors?.isNotEmpty ?? false) {
      _dio!.interceptors.addAll(interceptors!);
    }
    if (kDebugMode) {
      _dio!.interceptors.add(LogInterceptor(responseBody: true, error: true, requestHeader: false, responseHeader: false, request: false, requestBody: false));
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio!.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
}
