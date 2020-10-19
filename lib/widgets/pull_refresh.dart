import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'turn_box.dart';

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
          child: TurnBox(
            turns: offset > 100 ? 0.5 : .0,
            child: Icon(
              Icons.arrow_upward,
              color: Colors.grey,
            ),
          ),
        ),
        Text(offset > 100 ? loosenTip ?? '松开刷新' : pullTip ?? '继续下拉',
          style: style,)
      ],
    );
  }
}

class PullRefreshBox extends StatefulWidget {

  PullRefreshBox({
    Key key,
    this.child,
    @required this.onRefresh,
    PullRefreshIndicator indicator,
    this.overScrollEffect,
  }) : this.indicator = indicator ?? DefaultPullRefreshIndicator(),
       super(key: key);

  final PullRefreshCallback onRefresh;
  final Widget child;
  final TargetPlatform overScrollEffect;
  final PullRefreshIndicator indicator;

  @override
  PullRefreshBoxState createState() => PullRefreshBoxState();
}

class PullRefreshBoxState extends State<PullRefreshBox> with TickerProviderStateMixin {

  PullRefreshIndicatorMode _mode;
  AnimationController _controller;
  double _dragOffset = .0;
  ScrollDirection _direction;
  bool _refreshing = false;

  bool get _androidEffect =>
      widget.overScrollEffect == TargetPlatform.android ||
          (widget.overScrollEffect == null &&
              defaultTargetPlatform == TargetPlatform.android);
  double get _indicatorHeight =>
      widget.indicator.height ?? widget.indicator.displacement ?? 100.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      lowerBound: -500.0,
      upperBound: 500.0,
    );
    _controller.value = 0.0;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> show() {
    _mode = PullRefreshIndicatorMode.refresh;
    return _checkIfNeedRefresh();
  }

  Future _checkIfNeedRefresh() {
    if (_mode == PullRefreshIndicatorMode.refresh && !_refreshing) {
      _refreshing = true;
      _controller.animateTo(widget.indicator.displacement ?? 100.0,
        duration: Duration(milliseconds: 200));
      return widget.onRefresh().whenComplete(()  {
        _mode = PullRefreshIndicatorMode.done;
        _goBack();
        _refreshing = false;
      });
    }
    return Future.value(null);
  }

  _goBack() {
    _dragOffset = 0.0;
    if (mounted) {
      _controller.animateTo(
        0.0,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      ).then((value) {
        _mode = PullRefreshIndicatorMode.done;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkIfNeedRefresh();
    return Stack(
      children: <Widget>[
        AnimatedBuilder(
          builder: (BuildContext context, Widget child) {
            return Transform.translate(
                offset: Offset(0.0, _controller.value),
              child: NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification,
                child: new NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: _handleGlowNotification,
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(platform: TargetPlatform.android),
                    child: widget.child,
                  ),
                ),
              ),
            );
          },
          animation: _controller,
        ),
        // Header
        AnimatedBuilder(
          builder: (BuildContext context, Widget child) {
            return Transform.translate(
                offset: Offset(0.0, -_indicatorHeight + _controller.value + 1),
                child: SizedBox(
                  height: _indicatorHeight,
                  width: double.infinity,
                  child: widget.indicator.build(context, _mode, _dragOffset, _direction),
                ),
            );
          },
          animation: _controller,
        ),
      ],
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (_mode == PullRefreshIndicatorMode.refresh) {
      return true;
    }
    if (notification is OverscrollNotification) {
      if (_mode != PullRefreshIndicatorMode.refresh) {
        double _temp = _dragOffset;
        _dragOffset -= notification.overscroll / 3.0;
        _mode = PullRefreshIndicatorMode.drag;
        if (_androidEffect) {
          if (_dragOffset < 0.0) {
            _dragOffset = 0.0;
          }
        }
        if (_temp != _dragOffset) {
          _controller.value = _dragOffset;
        }
      }
    } else if (notification is ScrollUpdateNotification) {
      if (_dragOffset > 0.0) {
        _dragOffset -= notification.scrollDelta;
        _controller.value = _dragOffset;
      }
    } else if (notification is ScrollEndNotification) {
      if (_dragOffset >= (widget.indicator.displacement ?? 100.0) &&
        _mode != PullRefreshIndicatorMode.refresh) {
        setState(() {
          _mode = PullRefreshIndicatorMode.refresh;
        });
      }
      if (_mode != PullRefreshIndicatorMode.refresh) {
        _mode = PullRefreshIndicatorMode.canceled;
        _goBack();
      }
    } else if (notification is UserScrollNotification) {
      _direction = notification.direction;
    }

    return false;
  }

  bool _handleGlowNotification(OverscrollIndicatorNotification notification) {
    if (!_androidEffect || notification.leading) {
      notification.disallowGlow();
    }
    return true;
  }


}
