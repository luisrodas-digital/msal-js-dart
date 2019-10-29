part of '../msal_js.dart';

AuthException _convertJsAuthError(AuthErrorJs jsError) {
  if (jsError == null) return null;

  if (jsError is ClientConfigurationErrorJs) {
    return new ClientConfigurationException._fromJsObject(jsError);
  } else if (jsError is InteractionRequiredAuthErrorJs) {
    return new InteractionRequiredAuthException._fromJsObject(jsError);
  } else if (jsError is ServerErrorJs) {
    return new ServerException._fromJsObject(jsError);
  } else if (jsError is ClientAuthErrorJs) {
    return new ClientAuthException._fromJsObject(jsError);
  } else {
    return new AuthException._fromJsObject(jsError);
  }
}

/// A general error thrown by MSAL.
class AuthException implements Exception {
  /// The code of the error that occurred.
  String get errorCode => _jsObject.errorCode;
  /// A message describing the error.
  String get errorMessage => _jsObject.errorMessage;
  /// Same as [errorMessage].
  String get message => _jsObject.message;
  /// The JavaScript stack trace for the error.
  String get stack => _jsObject.stack;

  final AuthErrorJs _jsObject;

  AuthException._fromJsObject(this._jsObject);

  @override
  String toString() => 'AuthException: $errorCode:$message';
}

/// Thrown by MSAL when there is an error in the client code running on the browser.
class ClientAuthException extends AuthException {
  ClientAuthException._fromJsObject(ClientAuthErrorJs jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'ClientAuthException: $errorCode:$message';
}

/// Thrown by MSAL when there is an error in the configuration of a library object.
class ClientConfigurationException extends ClientAuthException {
  ClientConfigurationException._fromJsObject(ClientConfigurationErrorJs jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'ClientConfigurationException: $errorCode:$message';
}

/// Thrown by MSAL when the user is required to perform an interactive token request.
class InteractionRequiredAuthException extends ServerException {
  InteractionRequiredAuthException._fromJsObject(InteractionRequiredAuthErrorJs jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'InteractionRequiredAuthException: $errorCode:$message';
}

/// Thrown by MSAL when there is an error with the server code,
/// for example, unavailability.
class ServerException extends AuthException {
  ServerException._fromJsObject(ServerErrorJs jsObject)
    : super._fromJsObject(jsObject);

  @override
  String toString() => 'ServerException: $errorCode:$message';
}
