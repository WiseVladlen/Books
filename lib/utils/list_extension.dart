extension ListX<T> on List<T> {
  /// The first index of an element in the given list whose type is [type].
  ///
  /// Returns -1 if element is not found.
  int indexWhereType(Type type) {
    for (final (int index, T value) in indexed) {
      if (value.runtimeType == type) return index;
    }
    return -1;
  }

  /// The first element in the given list whose type is [type].
  ///
  /// Throw exception if element is not found.
  T firstWhereType(Type type) {
    for (final T value in this) {
      if (value.runtimeType == type) return value;
    }
    throw Exception('No element error');
  }
}
