extension ListFormattingX<T> on List<T> {
  String toFormattedString() => join(', ');
}

extension StringFormattingX on String {
  /// Combines the title with the passed parameter [date].
  String combineTitleWithDate(DateTime? date) {
    if (date != null) return '$this · (${date.year})';
    return this;
  }

  /// Combines the section header and its value.
  String combineSectionHeaderWith(dynamic value) => '$this: $value';
}

extension StringCasingX on String {
  String toCapitalized() {
    return length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  }
}
