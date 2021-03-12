import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../ui.dart';

/// widget that shows splash on [UI.splashStream] events
class SplashScreen extends StatefulWidget {
  /// widget that shows splash on [UI.splashStream] events
  const SplashScreen({
    required this.splash,
    required this.child,
    this.duration = const Duration(seconds: 1),
    Key? key,
  }) : super(key: key);

  /// widget splash to show
  final Widget splash;

  /// child in widget tree
  final Widget child;

  /// splash fade duration
  final Duration duration;

  @override
  _SplashScreenState createState() => _SplashScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Widget>('splash', splash))
      ..add(DiagnosticsProperty<Widget>('child', child))
      ..add(DiagnosticsProperty<Duration>('showDuration', duration));
  }
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showSplash = true;

  StreamSubscription<bool>? _subscription;

  @override
  void initState() {
    _subscription ??= UI().splashStream.listen(
      (showSplash) async {
        _subscription?.pause(Future.delayed(widget.duration));
        if (mounted) {
          setState(() => _showSplash = showSplash);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = WidgetsBinding.instance!.window.physicalSize.height;
    final width = WidgetsBinding.instance!.window.physicalSize.width;
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: AnimatedCrossFade(
        firstChild: LimitedBox(
          maxHeight: height,
          maxWidth: width,
          child: widget.splash,
        ),
        secondChild: LimitedBox(
          maxHeight: height,
          maxWidth: width,
          child: widget.child,
        ),
        crossFadeState:
            _showSplash ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: widget.duration,
        firstCurve: const Interval(1 / 2, 1, curve: Curves.easeInQuad),
        secondCurve: const Interval(1 / 2, 1, curve: Curves.easeOutQuad),
      ),
    );
  }
}
