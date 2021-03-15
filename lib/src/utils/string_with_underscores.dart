/// Extension on [String] for convertation
extension ToStringWithUnderscores on String {
  /// Convert initial camelCase string into string
  /// with underscores (`_`)
  ///
  /// ```dart
  /// final str = 'oneAndTwo'.withUnderscores();
  /// str == 'one_and_two'; // true
  /// ```
  String withUnderscores() {
    final capitalLetters = RegExp('[A-Z]+').allMatches(this);

    var newItem = this;
    for (final capitalLetter in capitalLetters) {
      final letter = capitalLetter.group(0);
      if (letter != null) {
        newItem = newItem.replaceFirst(letter, '_${letter.toLowerCase()}');
      }
    }
    return newItem;
  }
}
