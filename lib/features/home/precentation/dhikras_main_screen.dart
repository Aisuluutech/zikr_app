import 'package:dhikras/core/providers/navigation_service_provider.dart';
import 'package:dhikras/features/zikrs/precentation/main_counter_screen.dart';
import 'package:dhikras/features/prayer_time/widgets/prayer_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dhikras extends ConsumerWidget {
  const Dhikras({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationService = ref.read(navigationServiceProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Dhikras App')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrayerTime(),
          SizedBox(height: 200.h),
          Center(
            child: InkWell(
              onTap: () {
                navigationService.push(Counter());
              },
              child: SizedBox(
                width: 60.w,
                height: 60.h,
                child: Image.asset(
                  'assets/image/love.png',
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
          ),

          Text('Start Zikr'),
        ],
      ),
    );
  }
}
