import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {

  const CustomListItem({
    this.thumbnail,
    this.title,
    this.user,
    this.viewCount
  });

  final Widget thumbnail;
  final String title;
  final String user;
  final int viewCount;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: _VideoDescription(
              title: title,
              user: user,
              viewCount: viewCount,
            ),
          ),
          const Icon(Icons.more_vert, size: 20.0,),
        ],
      ),
    );
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    Key key,
    this.title,
    this.user,
    this.viewCount,
  }) : super(key: key);

  final String title;
  final String user;
  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            user,
            style: TextStyle(fontSize: 10.0),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 1.0),),
          Text(
            '$viewCount views',
            style: TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

class CustomListViewRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      itemExtent: 106.0,
      children: <CustomListItem>[
        CustomListItem(
          user: 'Flutter',
          viewCount: 9999,
          thumbnail: Container(
            decoration: BoxDecoration(color: Colors.blue),
          ),
          title: 'The Flutter YouTube Channel',
        ),
        CustomListItem(
          user: 'Dash',
          viewCount: 88888,
          thumbnail: Container(
            decoration: BoxDecoration(color: Colors.yellow),
          ),
          title: 'Announcing Flutter 1.0',
        ),
      ],
    );
  }
}