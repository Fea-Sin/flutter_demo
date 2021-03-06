import 'package:flutter/material.dart';
import '../../widgets/pull_refresh.dart';
import '../../widgets/after_layout.dart';

class PullRefreshRoute extends StatefulWidget {
  @override
  _PullRefreshRouteState createState() => _PullRefreshRouteState();
}

class _PullRefreshRouteState extends State<PullRefreshRoute> {

  var _pullRefreshKey = GlobalKey<PullRefreshBoxState>();
  bool _init = false;

  @override
  Widget build(BuildContext context) {
    return AfterLayout(
      callback: (ctx) {
        // every time call `setState`, this call back will be called
        if (!_init) {
          _init = true;
          _pullRefreshKey.currentState.show();
        }
      },
      child: PullRefreshBox(
        key: _pullRefreshKey,
        onRefresh: () async => Future.delayed(Duration(seconds: 2)),
        child: ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: 100,
            itemBuilder: (ctx, index) => Card(
              child: ListTile(
                title: Text('index-$index'),
              ),
            ),
        ),
      ),
    );
  }
}

