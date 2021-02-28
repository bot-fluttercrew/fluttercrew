import 'dart:developer';

import 'package:logger/logger.dart';

Logger customLogger(String name) {
  return Logger(
    output: name != null ? _DevLogOutput(name) : null,
    level: Level.verbose,
    filter: DevelopmentFilter(),
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 10,
      lineLength: 30,
      printEmojis: false,
      printTime: true,
    ),
  );
}

class _DevLogOutput extends LogOutput {
  _DevLogOutput(this.name);

  final String name;

  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      log(line, name: name);
    }
  }
}
