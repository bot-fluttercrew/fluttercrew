import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/custom_logger.dart';

class Utils {
  factory Utils() => _instance;
  Utils._privateConstructor();
  static final Utils _instance = Utils._privateConstructor();

  SharedPreferences _prefs;
  SharedPreferences get prefs => _prefs;

  Logger _logger;
  Logger get logger => _logger;

  Future<void> init({String projectName}) async {
    _prefs ??= await SharedPreferences.getInstance();
    _logger ??= customLogger(projectName);
  }
}
