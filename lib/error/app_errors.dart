class AppError extends Error {
  final String message;

  AppError(this.message);

  @override
  String toString() => "Error: $message";
}

class AuthError extends AppError {
  final String message;

  AuthError(this.message) : super(message);

  @override
  String toString() => "Authentication Error: $message";
}
