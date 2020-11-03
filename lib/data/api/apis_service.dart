
import '../../net/index.dart';
import './apis.dart';

ApiService _apiService = new ApiService();

ApiService get apiService => _apiService;

class ApiService {
  /// 获取首页轮播图
  void getBannerList(Function callback) async {
    dio.get(Apis.home_banner).then((response) {
      callback();
    });
  }
}