import 'package:dhikras/features/zikrs/utils/show_translation_dialog.dart';
import 'package:dhikras/features/zikrs/data/after_prayer_items_data.dart';
import 'package:dhikras/features/zikrs/widgets/zikr_count_widget.dart';
import 'package:dhikras/features/zikrs/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Afterprayer extends ConsumerStatefulWidget {
  const Afterprayer({super.key});

  @override
  ConsumerState<Afterprayer> createState() => _AfterprayerState();
}

class _AfterprayerState extends ConsumerState<Afterprayer> {
  void _info3(index) {
    showTranslationDialog(context, afterPrayerItems[index].translation);
  }

  final PageController _controller = PageController();
  void _nextPage() {
    if (ref.read(currentPageProvider) < afterPrayerItems.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (ref.read(currentPageProvider) >= 0) {
      _controller.previousPage(
        duration: Duration(microseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(currentPageProvider);
    final count = ref.watch(counterProvider('afterprayer_$index'));
    final counter = ref.watch(counterProvider('afterprayer_$index').notifier);
    final isPlaying = ref.watch(audioProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('After prayer')),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: afterPrayerItems.length,
                    effect: WormEffect(
                      dotHeight: 8.h,
                      dotWidth: 8.w,
                      activeDotColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 130.h),
                  SizedBox(
                    height: 220.h,
                    width: double.infinity.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: _prevPage,
                          icon: Icon(Icons.chevron_left),
                        ),
                        Expanded(
                          child: PageView.builder(
                            controller: _controller,
                            itemCount: afterPrayerItems.length,
                            onPageChanged:
                                (index) =>
                                    ref
                                        .read(currentPageProvider.notifier)
                                        .state = index,
                            itemBuilder:
                                (BuildContext context, int index) => Center(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      afterPrayerItems[index].title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                          ),
                        ),

                        IconButton(
                          onPressed: _nextPage,
                          icon: Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 90.h),
            ZikrCountWidget(
              count: count,
              onIncrement: () => counter.incrementCounter(),
              onReset: () => counter.reset(),
              onInfo: () => _info3(index),
              onToggleAudio:
                  () => isPlaying.toggle(afterPrayerItems[index].audioPath),
              displayText:
                  (count) == 0
                      ? '0'
                      : ((count % afterPrayerItems[index].quantity == 0)
                          ? '\u2713'
                          : '${count % afterPrayerItems[index].quantity}'),
              repeat:
                  afterPrayerItems[index].quantity > 1
                      ? 'Repeat ${afterPrayerItems[index].quantity} times'
                      : 'Repeat ${afterPrayerItems[index].quantity} time',
              countValue: afterPrayerItems[index].quantity,
              isUserAdded: false,
              displayAmount: '',
            ),
          ],
        ),
      ),
    );
  }
}
