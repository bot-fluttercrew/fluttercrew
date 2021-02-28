import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../ui.dart';

const Duration _showOffDuration = Duration(seconds: 1);

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    @required this.splash,
    @required this.child,
    Key key,
  }) : super(key: key);

  final Widget child;
  final Widget splash;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showSplash = true;

  StreamSubscription<bool> _subscription;

  @override
  void initState() {
    _subscription ??= UI().splashStream.listen((showSplash) {
      _subscription.pause(Future.delayed(_showOffDuration));
      setState(() => _showSplash = showSplash);
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: ui.TextDirection.ltr,
      children: <Widget>[
        widget.child,
        IgnorePointer(
          ignoring: !_showSplash,
          child: AnimatedOpacity(
            curve: Curves.easeOutQuad,
            opacity: _showSplash ? 1 : 0,
            duration: _showOffDuration,
            child: widget.splash,
          ),
        ),
      ],
    );
  }
}
