class ApiError implements Exception {
  static const String notAuthed = "not_authed";
  static const String invalidAuth = "invalid_authed";
  static const String tokenRevoked = "tokenRevoked";
  static const List<String> authErrors = [notAuthed, invalidAuth, tokenRevoked];

  final String _errorMsg;

  ApiError._internal(this._errorMsg);

  factory ApiError(String errorMsg) {
    if (authErrors.contains(errorMsg)) {
      return AuthError(errorMsg);
    }
    return ApiError._internal(errorMsg);
  }

  String get errorMsg => _errorMsg;
}

class AuthError extends ApiError {
  AuthError(String error) : super._internal(error);
}
