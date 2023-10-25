class DateConverter {
  static DateTime? toDateTime(String? value) {
    return value != null ? DateTime.tryParse(value) : null;
  }
}
