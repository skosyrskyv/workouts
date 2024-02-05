extension StringExtension on String {
  /// Capitalize firs word in the text
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  /// Capitalize every word in the text
  String capitalizeAll() {
    if (isEmpty) return this;
    final words = trim().split(' ');
    var result = '';
    for (var word in words) {
      result = '$result ${word.capitalize()}';
    }
    return result.trimLeft();
  }
}
