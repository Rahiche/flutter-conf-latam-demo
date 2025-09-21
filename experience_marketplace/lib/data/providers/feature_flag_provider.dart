import 'package:flutter/foundation.dart';

class FeatureFlagProvider extends ChangeNotifier {
  FeatureFlagProvider({bool enableTimeSorting = false})
      : _enableTimeSorting = enableTimeSorting;

  bool _enableTimeSorting = false;

  bool get enableTimeSorting => _enableTimeSorting;

  void setTimeSortingEnabled(bool enabled) {
    _enableTimeSorting = enabled;
    notifyListeners();
  }

  void toggleTimeSorting() {
    _enableTimeSorting = !_enableTimeSorting;
    notifyListeners();
  }
}
