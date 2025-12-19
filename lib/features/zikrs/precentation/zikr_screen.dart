import 'package:dhikras/features/zikrs/utils/show_translation_dialog.dart';
import 'package:dhikras/features/zikrs/models/zikr_items.dart';
import 'package:dhikras/features/zikrs/widgets/zikr_count_widget.dart';
import 'package:dhikras/features/zikrs/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZikrScreen extends ConsumerStatefulWidget {
  const ZikrScreen({super.key, required this.items});

  final ZikrItems items;

  @override
  ConsumerState<ZikrScreen> createState() => _ZikrScreenState();
}

class _ZikrScreenState extends ConsumerState<ZikrScreen> {

void info () {
 showTranslationDialog(context, widget.items.translation);
}

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(counterProvider(widget.items.counterKey));
    final counter = ref.read(counterProvider(widget.items.counterKey).notifier);
    final isPlaying = ref.watch(audioProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(widget.items.title)),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200).h,
              child: Text(
                widget.items.title,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            SizedBox(height: 200.h),
            ZikrCountWidget(
              count: count,
              onIncrement: () => counter.incrementCounter(),
              onInfo: info,
              onReset: () => counter.reset(),
              onToggleAudio: () => isPlaying.toggle(widget.items.audioPath),
              displayText:
                  (count % widget.items.quantity == 0 && count != 0)
                      ? '\u2713'
                      : '${count % widget.items.quantity}',
              repeat: 'Repeat 33 times',
              countValue: widget.items.quantity,
              isUserAdded: false,
              displayAmount: '$count',
            ),
          ],
        ),
      ),
    );
  }
}
