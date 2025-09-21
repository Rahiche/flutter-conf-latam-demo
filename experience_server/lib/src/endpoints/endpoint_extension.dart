import 'package:serverpod/serverpod.dart';

extension ExtensionWrapper on Endpoint {
  Future<T> onlyIfAuthenticated<T>(
      Session session, Future<T> Function(Session) callback) async {
    if (await session.isUserSignedIn) {
      return callback.call(session);
    }
    return Future.error(NotAuthorizedException(
        ResultAuthenticationFailed.unauthenticated('User is not signed in')));
  }
}
