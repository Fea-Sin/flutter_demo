import 'package:flutter/material.dart';

class NavigatorRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 350,
        child: Navigator(
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (context) => PageC();
                break;
            }
            return MaterialPageRoute(builder: builder);
          },
        ),
      ),
    );
  }
}

class PageC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          children: <Widget>[
            _buildItem(Icons.clear, '不感兴趣', '减少这类内容'),
            Divider(),
            _buildItem(Icons.access_alarm, '举报', '这标题夸张，内容质量差',
            showArrow: true,
            onPress: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return PageD();
              }));
            }),
            Divider(),
            _buildItem(Icons.perm_identity, '拉黑作者：新华客户端', ''),
            Divider(),
            _buildItem(Icons.account_circle, '屏蔽', '军事视频、驾驶员等'),
          ],
        ),
      ),
    );
  }

  _buildItem(IconData iconData, String title, String content,
  {bool showArrow = false, Function onPress}) {
    return Row(
      children: <Widget>[
        Icon(iconData),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                content,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.5),
                ),
              )
            ],
          ),
        ),
        !showArrow
          ? Container()
          : IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          iconSize: 16,
          onPressed: onPress,
        ),
      ],
    );
  }
}

class PageD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 250,
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              'HELLO WORLD',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}






