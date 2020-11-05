
import '../../net/index.dart';
import './apis.dart';
import '../model/banner_model.dart';

ApiService _apiService = new ApiService();

ApiService get apiService => _apiService;

class ApiService {
  /// 获取首页轮播图
  void getBannerList(Function callback) async {
    dio.get(Apis.home_banner)
        .then((response) {
//          print('请求数据返回====$response');
//          print('请求数据返回,如果是data====${response.data}');
          callback(BannerModel.fromJson(response.data));
        });
  }
}