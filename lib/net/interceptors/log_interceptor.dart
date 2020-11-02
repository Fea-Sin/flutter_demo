import 'package:dio/dio.dart';
import '../../common/common.dart';
import '../../utils/index.dart';

/// Dio 请求日志拦截器

class LogInteceptors extends InterceptorsWrapper {
  bool isDebug = AppConfig.isDebug;

  @override
  onRequest(RequestOptions options) async {
    if (isDebug) {
      print('┌────────────Begin Request────────────────');
      printKV('uri', options.uri);
      printKV('method', options.method);
      printKV('queryParameters', options.queryParameters);
      printKV('contentType', options.contentType.toString());
      printKV('responseType', options.responseType.toString());

      StringBuffer stringBuffer = new StringBuffer();
      options.headers.forEach((key, value) {
        stringBuffer.write('\n $key: $value');
      });
      printKV('headers', stringBuffer.toString());
      stringBuffer.clear();

      if (options.data != null) {
        printKV('body', options.data);
      }
      print('└—————————————————————End Request———————————————————————\n\n');
    }

    return options;
  }

  @override
  onResponse(Response response) async {
    if (isDebug) {
      print('┌───────────────Begin Response─────────────');
      printKV('uri', response.request.uri);
      printKV('status', response.statusCode);
      printKV('responseType', response.request.responseType.toString());

      StringBuffer stringBuffer = new StringBuffer();
      response.headers.forEach((name, values) {
        stringBuffer.write('\n $name: $values');
      });
      stringBuffer.clear();
      print('└—————————————————————End Response———————————————————————\n\n');
    }
    return response;
  }

  @override
  onError(DioError err) async {
    if (isDebug) {
      print('┌───────────────Begin Error─────────────');
      printKV('error', err.toString());
      printKV('error message', (err.response?.toString() ?? ''));
      print('└—————————————————————End Error———————————————————————\n\n');
    }
    return err;
  }
}