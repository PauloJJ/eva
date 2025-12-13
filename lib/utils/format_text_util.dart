class FormatTextsUtil {
  static String replaceRange(String text) {
    return text.length > 10
        ? text.replaceRange(
            10,
            null,
            '.',
          )
        : text;
  }
}
