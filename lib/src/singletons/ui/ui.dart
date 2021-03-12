import 'dart:async';

export 'widgets/splash_screen.dart';

/// UI singleton
class UI {
  /// UI singleton
  factory UI() => _instance;
  UI._privateConstructor();
  static final UI _instance = UI._privateConstructor();

  final StreamController<bool> _splashController = StreamController<bool>();

  /// stream of the splash widget
  Stream<bool> get splashStream => _splashController.stream;

  /// function to add events to splash widget
  void Function(bool) get setSplash => _splashController.add;

  /// dispose the stream controller
  Future<void> dispose() async {
    await _splashController.close();
  }
}
