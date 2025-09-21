import 'package:experience_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

import 'endpoint_extension.dart';

enum ExperienceOrderBy {
  nameAsc,
  nameDesc,
  startAtAsc,
  startAtDesc,
  ratingAsc,
  ratingDesc,
  ;
}

class ExperienceEndpoint extends Endpoint {
  Future<List<Experience>> getExperiences(
    Session session, {
    required String orderBy,
    bool includePastEvents = false,
  }) async {
    return onlyIfAuthenticated(session, (session) async {
      final orderByDeserialized =
          ExperienceOrderBy.values.firstWhere((value) => value.name == orderBy);
      final queryResults = await Experience.db.find(
        session,
        where: includePastEvents
            ? null
            : (table) => table.startsAt > DateTime.now(),
        orderBy: (table) {
          switch (orderByDeserialized) {
            case ExperienceOrderBy.nameAsc:
              return table.name;
            case ExperienceOrderBy.nameDesc:
              return table.name;
            case ExperienceOrderBy.startAtAsc:
              return table.startsAt;
            case ExperienceOrderBy.startAtDesc:
              return table.startsAt;
            case ExperienceOrderBy.ratingAsc:
              return table.endsAt;
            case ExperienceOrderBy.ratingDesc:
              return table.endsAt;
          }
        },
      );
      return queryResults;
    });
  }

  Future<List<Experience>> getExperiencesByCategory(
    Session session, {
    required Category category,
  }) async {
    return onlyIfAuthenticated(session, (session) async {
      final queryResults = await Experience.db.find(
        session,
        where: (table) => table.categoryId.equals(category.id),
        orderBy: (table) => table.startsAt,
      );
      return queryResults;
    });
  }

  Future<Experience> getExperience(Session session, int experienceId) async {
    return onlyIfAuthenticated(session, (session) async {
      final queryResults = await Experience.db.findById(session, experienceId);
      if (queryResults != null) {
        return queryResults;
      }
      session.log('Couldn\'t find an experience with id $experienceId',
          level: LogLevel.error);
      throw Exception('Experience not found: $experienceId');
    });
  }

  Future<bool> registerAttendance(Session session, int experienceId) async {
    return onlyIfAuthenticated(session, (session) async {
      final authenticationInfo = await session.authenticated;
      if (authenticationInfo != null) {
        final userId = authenticationInfo.userId;
        final experience = await Experience.db.findById(session, experienceId);
        final user = await User.db.findById(session, userId);
        if (experience != null) {
          final experienceAttendees = experience.attendees ?? <User>[];
          if (experienceAttendees
                  .indexWhere((candidate) => candidate.id == userId) ==
              -1) {
            experienceAttendees.add(user!);
            experience.attendees = experienceAttendees;
            await Experience.db.updateRow(session, experience);
            return true;
          } else {
            session.log(
                'User $userId is already registered for experience $experienceId');
            return false;
          }
        } else {
          session.log('Couldn\'t find an experience with id $experienceId',
              level: LogLevel.error);
          return false;
        }
      }
      return false;
    });
  }

  Future<bool> unregisterAttendance(Session session, int experienceId) async {
    return onlyIfAuthenticated(session, (session) async {
      final authenticationInfo = await session.authenticated;
      if (authenticationInfo != null) {
        final userId = authenticationInfo.userId;
        final experience = await Experience.db.findById(session, experienceId);
        if (experience != null) {
          final experienceAttendees = experience.attendees ?? <User>[];
          experienceAttendees
              .removeWhere((candidate) => candidate.id == userId);
          experience.attendees = experienceAttendees;
          if (experienceAttendees.length !=
              (experience.attendees?.length ?? 0)) {
            await Experience.db.updateRow(session, experience);
          }
          return true;
        } else {
          session.log('Couldn\'t find an experience with id $experienceId',
              level: LogLevel.error);
          return false;
        }
      }
      return false;
    });
  }
}
