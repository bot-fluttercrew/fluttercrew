import 'dart:async';

class UI {
  factory UI() => _instance;
  UI._privateConstructor();
  static final UI _instance = UI._privateConstructor();

  StreamController<bool> _splashController;
  Stream<bool> get splashStream => _splashController.stream;
  Function(bool) get setSplash => _splashController.add;

  Future<void> init() async {
    _splashController ??= StreamController<bool>();
  }

  Future<void> dispose() async {
    await _splashController?.close();
  }
}
