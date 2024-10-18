extension FirstWhereOrNullExtension<E> on List<E> {
  /// Returns the first element that satisfies the given [test].
  /// If no element satisfies the [test], returns `null`.
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
        
      }
    }
    return null;
  }
}
