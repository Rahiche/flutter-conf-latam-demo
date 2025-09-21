import 'dart:async';
import 'package:experience_common/experience_client.dart';

import 'base_repository.dart';

abstract class ExperienceRepository extends BaseRepository<Experience> {
  Future<List<Experience>> getByCategory(Category category);
  Future<List<Review>> getReviews(String experienceId);

  // Attendance methods
  Future<bool> registerAttendance(String experienceId);
  Future<bool> unregisterAttendance(String experienceId);

  // Report method
  Future<bool> reportExperience(int experienceId);
}
