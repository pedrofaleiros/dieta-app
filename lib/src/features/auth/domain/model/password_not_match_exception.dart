class PasswordNotMatchException implements Exception {
  final String message;

  PasswordNotMatchException(this.message);

  @override
  String toString() {
    return message;
  }
}
