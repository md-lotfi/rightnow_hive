import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class ScrollableTextWidget extends StatefulWidget {
  final Text text;
  const ScrollableTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ScrollableTextWidget> createState() => _ScrollableTextWidgetState();
}

class _ScrollableTextWidgetState extends State<ScrollableTextWidget> {
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0);
  bool scroll = false;
  int speedFactor = 20;
  bool reverse = false;

  double lastPos = 0;

  int duration = 2;

  @override
  void initState() {
    log("scrollable text init");
    super.initState();

    _scrollController.addListener(() async {
      double maxExtent = _scrollController.position.maxScrollExtent;
      double distanceDifference = maxExtent - _scrollController.offset;

      double durationDouble = distanceDifference / speedFactor;
      if (durationDouble.ceil() >= 1) {
        duration = durationDouble.ceil();
      }
      if (_scrollController.position.pixels == (_scrollController.position.maxScrollExtent)) {
        log('reached end ..................., going to 0');
        /*_scrollController.animateTo(0, duration: Duration(seconds: duration), curve: Curves.linear).then((value) {
          log('je sui sla');
          _scrollController.animateTo(0, duration: Duration(seconds: duration), curve: Curves.linear);
        });*/
        _scrollController.jumpTo(0);
      } else if (_scrollController.position.pixels == _scrollController.position.minScrollExtent) {
        log('reached start ...................');
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(seconds: duration), curve: Curves.linear).then((value) {
          _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(seconds: duration), curve: Curves.linear);
        });
        //lastPos = _scrollController.position.maxScrollExtent;
        //_scrollX();
        /*setState(() {
          reverse = false;
        });*/
      }
    });
    Future.delayed(const Duration(seconds: 2), () {
      lastPos = _scrollController.position.maxScrollExtent;
      _scrollX();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _scrollX() async {
    if (_scrollController.hasClients) {
      //log("scroll has client $scrollTo");
      double maxExtent = _scrollController.position.maxScrollExtent;
      double distanceDifference = maxExtent - _scrollController.offset;
      double durationDouble = distanceDifference / speedFactor;
      if (durationDouble.ceil() >= 1) {
        duration = durationDouble.ceil();
      }
      _scrollController.animateTo(lastPos,
          duration: Duration(seconds: duration), curve: Curves.linear); //lastPos == 0 ? _scrollController.position.maxScrollExtent : _scrollController.position.minScrollExtent
      log('auto scroll terminated');
      //return Future.value(true);
    }
    //await Future.delayed(const Duration(seconds: 1));
    //return Future.value(true);
  }

  _onStartScroll(ScrollMetrics metrics) {
    print("Scroll Start");
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    print("Scroll Update");
  }

  _onEndScroll(ScrollMetrics metrics) {
    log("Scroll End ${metrics.maxScrollExtent}");
    //_scroll();

    //lastPos = lastPos == 0 ? metrics.maxScrollExtent : metrics.minScrollExtent;
    //_scroll();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _onStartScroll(notification.metrics);
          } else if (notification is ScrollUpdateNotification) {
            _onUpdateScroll(notification.metrics);
          } else if (notification is ScrollEndNotification) {
            _onEndScroll(notification.metrics);
            log('previous pos $lastPos');
            /*lastPos = lastPos == 0 ? notification.metrics.maxScrollExtent : notification.metrics.minScrollExtent;
            log('new pos $lastPos');
            _scrollX();*/
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: widget.text,
        ),
      ),
    );
  }
}
