import 'package:dhikras/features/prayer_time/providers/prayer_time_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrayerTime extends ConsumerWidget {
  const PrayerTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPrayerTime = ref.watch(prayerTimeProvider);

    return asyncPrayerTime.when(
      data: (times) {
      final timesMap = times.toJson();
      return  Row(
          children:
              timesMap.entries
                  .map(
                    (entry) => Expanded(
                      child: Column(
                        children: [
                          Text(entry.key),
                          Text(
                            entry.value,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
        );
      },
      error: (err, _) => Center(child: Text('Error: $err')),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
