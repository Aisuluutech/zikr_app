import 'package:dhikras/features/prayer_time/models/prayer_time_model.dart';
import 'package:dhikras/features/prayer_time/services/prayer_time.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//final prayerTimeProvider = FutureProvider((ref)=> getPrayerTime());
final prayerTimeProvider =
    FutureProvider<PrayerTimesModel>((ref) async {
  return getPrayerTime();
});
