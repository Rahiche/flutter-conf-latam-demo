import 'package:experience_server/src/generated/protocol.dart';
import 'package:serverpod/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

import 'endpoint_extension.dart';

class UserEndpoint extends Endpoint {
  Future<User> getMe(Session session) async {
    return onlyIfAuthenticated(session, (session) async {
      final authenticatedUser = await session.authenticated;
      if (authenticatedUser != null) {
        final user = await User.db.findById(session, authenticatedUser.userId);
        if (user != null) {
          return user;
        }
      }
      throw AccessDeniedException(message: 'User not found');
    });
  }

  Future<User> getUser(Session session, int userId) async {
    return onlyIfAuthenticated(session, (session) async {
      final user = await User.db.findById(session, userId);
      if (user != null) {
        return user;
      } else {
        throw Response.notFound(
            body: Body.fromString('User with id $userId not found'));
      }
    });
  }
}
