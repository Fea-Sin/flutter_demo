import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum PullRefreshIndicatorMode {
  /// Pointer is down (over scroll)
  drag,

  /// Running the refresh callback
  refresh,

  /// Animating the indicator's fade-out after refreshing.
  done,

  /// Animating the indicator's fade-out after not arming.
  canceled,
}

typedef Future PullRefreshCallback();

abstract class PullRefreshIndicator {
  /// The distance from the child's top or bottom edge to where the refresh
  /// indicator will settle. During the drag that exposes the refresh indicator,
  /// its actual displacement may significantly exceed this value.
  double get displacement;

  /// Header height
  double get height;

  Widget build(
        BuildContext context,
        PullRefreshIndicatorMode mode,
        double offset,
        ScrollDirection direction,
      );
}

/// this is a default PullRefreshIndicator.
class DefaultPullRefreshIndicator implements PullRefreshIndicator {

  final TextStyle style;
  final Color arrowColor;
  final String loadingTip;
  final String pullTip;
  final String loosenTip;
  ProgressIndicator progressIndicator;

  DefaultPullRefreshIndicator({
    this.style = const TextStyle(color: Colors.grey),
    this.arrowColor = Colors.grey,
    this.loadingTip,
    this.pullTip,
    this.loosenTip,
    this.progressIndicator,
  });

  @override
  double get displacement => 100.0;

  @override
  double get height => displacement;

  @override
  Widget build(BuildContext context, PullRefreshIndicatorMode mode, offset,
      ScrollDirection direction) {
    if (mode == PullRefreshIndicatorMode.refresh) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          progressIndicator ??
            SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(loadingTip ?? '正在刷新...', style: style,),
          )
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(3.0),
        )
      ],
    );
  }
}