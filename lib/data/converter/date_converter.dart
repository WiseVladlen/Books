class DateConverter {
  static DateTime? fromJson(String? value) {
    return value != null ? DateTime.tryParse(value) : null;
  }
}
