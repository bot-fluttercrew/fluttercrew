library fluttercrew.enum_to_string;

/// Class to convert enums
class EnumToString {
  static bool _isEnumItem(enumItem) {
    final splitEnum = enumItem.toString().split('.');
    return splitEnum.length > 1 &&
        splitEnum[0] == enumItem.runtimeType.toString();
  }

  /// Convert an enum to a string
  ///
  /// Pass in the enum value, so TestEnum.valueOne into [enumItem]
  /// It will return the striped off value so "valueOne".
  ///
  /// If you pass in the option [camelCase]=true it will convert it to words
  /// So TestEnum.valueOne will become Value One
  static String convertToString<T extends Object>(T enumItem,
      {bool camelCase = false}) {
    assert(
        _isEnumItem(enumItem),
        '$enumItem of type ${enumItem.runtimeType.toString()} '
        'is not an enum item');
    final _tmp = enumItem.toString().split('.')[1];
    return camelCase ? _tmp : _convertToStringWithDashes(_tmp);
  }

  /// Given a string, find and return its matching enum value
  ///
  /// You need to pass in the values of the enum object. So TestEnum.values
  /// in the first argument. The matching value is the second argument.
  ///
  /// Example ```
  /// final result = EnumToString.fromString(TestEnum.values, "valueOne")
  /// result == TestEnum.valueOne //true
  ///
  static T fromString<T extends Object>(List<T> enumValues, String value) {
    // try with camel case and without camel case
    return enumValues.singleWhere((enumItem) =>
        (EnumToString.convertToString(enumItem).toLowerCase() ==
            value.toLowerCase()) ||
        (EnumToString.convertToString(enumItem, camelCase: true)
                .toLowerCase() ==
            value.toLowerCase()));
  }

  /// Get the index of the enum value
  ///
  /// Pass in the enum values to argument one, so TestEnum.values
  /// Pass in the matching string to argument 2, so "valueOne"
  ///
  /// Eg. ```
  /// final index = EnumToString.indexOf(TestEnum.values, "valueOne")
  /// index == 0 //true
  static int indexOf<T extends Object>(List<T> enumValues, String value) =>
      enumValues.indexOf(fromString<T>(enumValues, value));

  /// get enums to list
  static List<String> toList<T extends Object>(List<T> enumValues,
      {bool camelCase = false}) {
    final _enumList = enumValues
        .map((t) => EnumToString.convertToString(t, camelCase: camelCase))
        .toList();
    return _enumList;
  }

  /// Get a list of enums given a list of strings.
  /// Basically just EnumToString.fromString, but using lists
  ///
  /// Returns null for items that are not found.
  ///
  /// As with fromString it is not case sensitive
  ///
  /// Eg. EnumToString.fromList(TestEnum.values, ["valueOne", "value2"]
  static List<T> fromList<T extends Object>(
      List<T> enumValues, List<String> valueList) {
    return List<T>.from(valueList.map((item) => fromString(enumValues, item)));
  }
}

String _convertToStringWithDashes(String enumItemString) {
  final capitalLetters = RegExp('[A-Z]+').allMatches(enumItemString);

  var newItem = enumItemString;
  for (final capitalLetter in capitalLetters) {
    final letter = capitalLetter.group(0);
    if (letter != null) {
      newItem = newItem.replaceFirst(letter, '_${letter.toLowerCase()}');
    }
  }
  return newItem;
}
