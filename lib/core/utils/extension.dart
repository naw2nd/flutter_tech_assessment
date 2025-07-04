extension IntAbbreviation on int {
  String toAbbreviatedString() {
    if (this >= 1e9) {
      return "${(this / 1e9).toStringAsFixed(2)}B";
    } else if (this >= 1e6) {
      return "${(this / 1e6).toStringAsFixed(2)}M";
    } else if (this >= 1e3) {
      return "${(this / 1e3).toStringAsFixed(2)}K";
    } else {
      return toString();
    }
  }
}
