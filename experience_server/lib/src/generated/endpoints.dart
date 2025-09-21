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
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/category_endpoint.dart' as _i2;
import '../endpoints/experience_endpoint.dart' as _i3;
import '../endpoints/user_endpoint.dart' as _i4;
import 'package:experience_server/src/generated/model/category.dart' as _i5;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i6;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'category': _i2.CategoryEndpoint()
        ..initialize(
          server,
          'category',
          null,
        ),
      'experience': _i3.ExperienceEndpoint()
        ..initialize(
          server,
          'experience',
          null,
        ),
      'user': _i4.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['category'] = _i1.EndpointConnector(
      name: 'category',
      endpoint: endpoints['category']!,
      methodConnectors: {
        'getCategories': _i1.MethodConnector(
          name: 'getCategories',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i2.CategoryEndpoint)
                  .getCategories(session),
        ),
        'getCategory': _i1.MethodConnector(
          name: 'getCategory',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i2.CategoryEndpoint).getCategory(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['experience'] = _i1.EndpointConnector(
      name: 'experience',
      endpoint: endpoints['experience']!,
      methodConnectors: {
        'getExperiences': _i1.MethodConnector(
          name: 'getExperiences',
          params: {
            'orderBy': _i1.ParameterDescription(
              name: 'orderBy',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'includePastEvents': _i1.ParameterDescription(
              name: 'includePastEvents',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i3.ExperienceEndpoint)
                  .getExperiences(
            session,
            orderBy: params['orderBy'],
            includePastEvents: params['includePastEvents'],
          ),
        ),
        'getExperiencesByCategory': _i1.MethodConnector(
          name: 'getExperiencesByCategory',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i5.Category>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i3.ExperienceEndpoint)
                  .getExperiencesByCategory(
            session,
            category: params['category'],
          ),
        ),
        'getExperience': _i1.MethodConnector(
          name: 'getExperience',
          params: {
            'experienceId': _i1.ParameterDescription(
              name: 'experienceId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i3.ExperienceEndpoint).getExperience(
            session,
            params['experienceId'],
          ),
        ),
        'registerAttendance': _i1.MethodConnector(
          name: 'registerAttendance',
          params: {
            'experienceId': _i1.ParameterDescription(
              name: 'experienceId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i3.ExperienceEndpoint)
                  .registerAttendance(
            session,
            params['experienceId'],
          ),
        ),
        'unregisterAttendance': _i1.MethodConnector(
          name: 'unregisterAttendance',
          params: {
            'experienceId': _i1.ParameterDescription(
              name: 'experienceId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i3.ExperienceEndpoint)
                  .unregisterAttendance(
            session,
            params['experienceId'],
          ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'getMe': _i1.MethodConnector(
          name: 'getMe',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i4.UserEndpoint).getMe(session),
        ),
        'getUser': _i1.MethodConnector(
          name: 'getUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i4.UserEndpoint).getUser(
            session,
            params['userId'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i6.Endpoints()..initializeEndpoints(server);
  }
}
