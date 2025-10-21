sealed class APIException implements Exception {
  APIException(this.message);
  final String message;
}

class ConnectionTimeotException extends APIException {
  ConnectionTimeotException() : super('Request Connection Timeout');
}

class BadResponseException extends APIException {
  BadResponseException() : super('Bad Response Received');
}

class ConnectionCanceledException extends APIException {
  ConnectionCanceledException() : super('Connection has beed Canceled');
}

class ConnectionErrorException extends APIException {
  ConnectionErrorException() : super('Connection error');
}

class UnknownException extends APIException {
  UnknownException() : super('Something went wrong');
}
