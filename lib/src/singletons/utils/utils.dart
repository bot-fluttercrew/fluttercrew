import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/custom_logger.dart';

/// [Utils] singleton
class Utils {
  /// [Utils] singleton
  factory Utils() => _instance;
  Utils._privateConstructor();
  static final Utils _instance = Utils._privateConstructor();

  late SharedPreferences _prefs;
  late Logger _logger;

  /// [SharedPreferences] instance
  SharedPreferences get prefs => _prefs;

  /// [Logger] instance
  Logger get logger => _logger;

  /// initialize [Utils] singleton
  Future<void> init({String projectName = ''}) async {
    _prefs = await SharedPreferences.getInstance();
    _logger = customLogger(projectName);
  }
}
