extension DurationExtension on Duration {
  String toStringTime() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60).abs());
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
