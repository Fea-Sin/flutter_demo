import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class CookieInterceptor extends Interceptor {
  final CookieJar cookieJar;

  CookieInterceptor(this.cookieJar);

  static String getCookies(List<Cookie> cookies) {
    return cookies.map((cookie) => "${cookie.name}=${cookie.value}").join(";");
  }

  @override
  Future onRequest(RequestOptions options) async {
    var cookies = cookieJar.loadForRequest(options.uri);
    cookies.removeWhere((element) {
      if (element.expires != null) {
        return element.expires.isBefore(DateTime.now());
      }
      return false;
    });

    String cookie = getCookies(cookies);
    if (cookie.isEmpty) options.headers[HttpHeaders.cookieHeader] = cookie;
  }

  _saveCookies(Response response) {
    if (response != null && response.headers != null) {

    }
  }


}