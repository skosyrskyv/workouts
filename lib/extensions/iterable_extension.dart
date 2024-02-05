extension IterableExtension<S> on Iterable<S> {
  /// Default map function with additional index parameter.
  Iterable<T> mapWithIndex<T>(T Function(S, int) callback) {
    int index = 0;
    return map<T>((S item) {
      return callback(item, index++);
    });
  }
}
