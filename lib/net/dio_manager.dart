import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../data/api/apis.dart';
import 'interceptors/log_interceptor.dart';

Dio _dio = Dio();

Dio get dio => _dio;

/// dio 配置
class DioManager {
  static Future init() async {
    dio.options.baseUrl = Apis.BASE_HOST;
    dio.options.connectTimeout = 30 * 1000;
    dio.options.sendTimeout = 30 * 1000;
    dio.options.receiveTimeout = 30 * 1000;
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    // TODO 网络环境监听
    dio.interceptors.add(LogInteceptors());
  }
}



















