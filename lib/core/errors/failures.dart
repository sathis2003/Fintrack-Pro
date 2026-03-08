abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.msg = 'No internet connection']);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([super.msg = 'Database error']);
}

class AIFailure extends Failure {
  const AIFailure([super.msg = 'AI service unavailable']);
}

class RateLimitFailure extends Failure {
  const RateLimitFailure()
      : super('AI rate limit reached. Try again in a moment.');
}

class AuthFailure extends Failure {
  const AuthFailure([super.msg = 'Authentication failed']);
}

class ParseFailure extends Failure {
  const ParseFailure([super.msg = 'Could not understand response from AI']);
}

class SyncFailure extends Failure {
  const SyncFailure([super.msg = 'Sync failed']);
}

class ServerFailure extends Failure {
  const ServerFailure([super.msg = 'Server error']);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure() : super('An unexpected error occurred');
}
