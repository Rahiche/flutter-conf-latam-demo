import 'package:experience_common/experience_client.dart';

extension ExperienceExtension on Experience {
  String get formattedDuration {
    final duration = endsAt.difference(startsAt);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return minutes > 0 ? '${hours}h ${minutes}min' : '${hours}h';
    }
    return '${minutes}min';
  }

  // Computed helpers for safer mobile UI
  double get averageRating {
    final dynamic r = (this as dynamic).reviews;
    if (r is List && r.isNotEmpty) {
      double sum = 0;
      int count = 0;
      for (final item in r) {
        double? value;
        if (item is Map) {
          final v = item['score'] ?? item['rating'];
          if (v is num) value = v.toDouble();
        } else {
          try {
            final dyn = (item as dynamic);
            final v = dyn.score ?? dyn.rating;
            if (v is num) value = (v).toDouble();
          } catch (_) {}
        }
        if (value != null) {
          sum += value;
          count++;
        }
      }
      if (count == 0) return 0.0;
      return double.parse((sum / count).toStringAsFixed(1));
    }
    return 0.0;
  }

  int get reviewCount {
    final dynamic r = (this as dynamic).reviews;
    if (r is List) return r.length;
    return 0;
  }
}
