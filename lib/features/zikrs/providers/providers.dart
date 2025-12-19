import 'package:dhikras/features/zikrs/models/new_zikr_items.dart';
import 'package:dhikras/features/zikrs/notifiers/audio_notifier.dart';
import 'package:dhikras/features/zikrs/notifiers/counter_notifier.dart';
import 'package:dhikras/features/zikrs/notifiers/dhikrs_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final audioProvider = StateNotifierProvider<AudioNotifier, bool>((ref) {
  return AudioNotifier();
});

final counterProvider =
    StateNotifierProvider.family<CounterNotifier, int, String>(
  (ref, key) => CounterNotifier(key),
);

final currentPageProvider = StateProvider<int>((ref) => 0);

final dhikrsProvider =
    StateNotifierProvider<DhikrsNotifier, List<Items>>((ref) {
  return DhikrsNotifier();
});





