/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:experience_common/src/protocol/model/category.dart' as _i3;
import 'package:experience_common/src/protocol/model/experience.dart' as _i4;
import 'package:experience_common/src/protocol/model/user.dart' as _i5;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i6;
import 'protocol.dart' as _i7;

/// {@category Endpoint}
class EndpointCategory extends _i1.EndpointRef {
  EndpointCategory(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'category';

  _i2.Future<List<_i3.Category>> getCategories() =>
      caller.callServerEndpoint<List<_i3.Category>>(
        'category',
        'getCategories',
        {},
      );

  _i2.Future<_i3.Category?> getCategory(int id) =>
      caller.callServerEndpoint<_i3.Category?>(
        'category',
        'getCategory',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointExperience extends _i1.EndpointRef {
  EndpointExperience(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'experience';

  _i2.Future<List<_i4.Experience>> getExperiences({
    required String orderBy,
    required bool includePastEvents,
  }) =>
      caller.callServerEndpoint<List<_i4.Experience>>(
        'experience',
        'getExperiences',
        {
          'orderBy': orderBy,
          'includePastEvents': includePastEvents,
        },
      );

  _i2.Future<List<_i4.Experience>> getExperiencesByCategory(
          {required _i3.Category category}) =>
      caller.callServerEndpoint<List<_i4.Experience>>(
        'experience',
        'getExperiencesByCategory',
        {'category': category},
      );

  _i2.Future<_i4.Experience> getExperience(int experienceId) =>
      caller.callServerEndpoint<_i4.Experience>(
        'experience',
        'getExperience',
        {'experienceId': experienceId},
      );

  _i2.Future<bool> registerAttendance(int experienceId) =>
      caller.callServerEndpoint<bool>(
        'experience',
        'registerAttendance',
        {'experienceId': experienceId},
      );

  _i2.Future<bool> unregisterAttendance(int experienceId) =>
      caller.callServerEndpoint<bool>(
        'experience',
        'unregisterAttendance',
        {'experienceId': experienceId},
      );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i5.User> getMe() => caller.callServerEndpoint<_i5.User>(
        'user',
        'getMe',
        {},
      );

  _i2.Future<_i5.User> getUser(int userId) =>
      caller.callServerEndpoint<_i5.User>(
        'user',
        'getUser',
        {'userId': userId},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i6.Caller(client);
  }

  late final _i6.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i7.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    category = EndpointCategory(this);
    experience = EndpointExperience(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointCategory category;

  late final EndpointExperience experience;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'category': category,
        'experience': experience,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
