import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../data/api/apis_service.dart';
import '../data/model/banner_model.dart';

class WrapperRoute extends StatefulWidget {
  @override
  _WrapperRouteState createState() => _WrapperRouteState();
}

class _WrapperRouteState extends State<WrapperRoute> {

  // 首页轮播图
  List<BannerBean> _bannerList = new List();

  // 获取轮播数据
  Future getBannerList() async {
    print('获取数据----');
    apiService.getBannerList((BannerModel bannerModel) {
      print('页面中传入数据-----${bannerModel.data}');
      print('能输出一条数据吗${bannerModel.data[0].toJson()['imagePath']}');
      if (bannerModel.data.length > 0) {
        setState(() {
          _bannerList = bannerModel.data;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getBannerList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text('构建轮播图', style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: Text(_bannerList.length > 0 ? _bannerList[2].title : '文本展位符'),
          ),
          Container(
            child: Image(
              height: 200,
              image: NetworkImage(_bannerList.length > 0
                  ? _bannerList[2].imagePath
                  : 'https://wanandroid.com/blogimgs/affe33fb-a160-4c63-bcc5-2ba83965a7bc.png'),
            ),
          ),
          Container(
            child: _buildSwipper(),
          ),
        ],
      ),
    );
  }

  // 构建轮播视图
  Widget _buildSwipper() {
    return Container(
      height: 200,
      child: Offstage(

      )
    );
  }
}


