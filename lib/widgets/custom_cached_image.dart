import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCachedImage extends StatelessWidget {

  // 图片链接
  final String imageUrl;
  final BoxFit fit;

  CustomCachedImage({Key key, @required this.imageUrl, this.fit = BoxFit.cover})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty
        ? CachedNetworkImage(
            fit: fit,
            imageUrl: imageUrl,
            errorWidget: (context, url, error) => new Icon(Icons.error),
          )
        : Container();
  }
}

