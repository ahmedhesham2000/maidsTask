// ignore_for_file: file_names

import 'package:dio/dio.dart';

abstract class DioHelper {
  static Dio? dio;
  static String baseUrl = "$baseImageUrl/";
  static String baseImageUrl = "https://dummyjson.com";
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postDataAPI({
    required String url,
    Map<String, dynamic>? query,
    data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    };

    return await dio!.post(url, data: data, queryParameters: query);
  }

  static Future<Response> putDataAPI({
    required String url,
    Map<String, dynamic>? query,
    required Object data,
    // String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    };

    return await dio!.put(url, data: data, queryParameters: query);
  }

  static Future<Response> patchDataAPI({
    required String url,
    Map<String, dynamic>? query,
    required Object data,
    // String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    };

    return await dio!.patch(url, data: data, queryParameters: query);
  }

  static Future<Response> putFromDataAPI({
    required String url,
    Map<String, dynamic>? query,
    required Object data,
    // String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      // 'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    };

    return await dio!.put(url, data: data, queryParameters: query);
  }

  static Future<Response> getDataAPI({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token == null ? null : 'Bearer $token',
    };
    var x = await dio!.get(url, data: data);

    return x;
  }

  static Future<Response> deleteDataAPI({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await dio!.delete(url, queryParameters: query, data: data);
  }

  static Future<Response> postFormDataAPI({
    required String url,
    Map<String, dynamic>? query,
    required FormData data,
    // String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      "Content-Type": "multipart/form-data",
      'Authorization': "Bearer $token",
    };

    return await dio!.post(url, data: data, queryParameters: query);
  }
}
