import 'dart:async';

class MockReportRepository {
  MockReportRepository();

  final StreamController<int> _reportedExperienceController =
      StreamController<int>.broadcast();
  final Set<int> _reportedExperienceIds = <int>{};

  Stream<int> get reportedExperienceStream =>
      _reportedExperienceController.stream;

  Set<int> get reportedExperienceIds =>
      Set.unmodifiable(_reportedExperienceIds);

  Future<bool> reportExperience(int experienceId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (_reportedExperienceIds.contains(experienceId)) {
      return false;
    }

    _reportedExperienceIds.add(experienceId);
    _reportedExperienceController.add(experienceId);
    return true;
  }

  bool isReported(int experienceId) {
    return _reportedExperienceIds.contains(experienceId);
  }

  void dispose() {
    _reportedExperienceController.close();
  }
}
