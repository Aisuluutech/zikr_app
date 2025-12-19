import 'package:dhikras/features/zikrs/utils/show_translation_dialog.dart';
import 'package:dhikras/features/zikrs/models/new_zikr_items.dart';
import 'package:dhikras/features/zikrs/widgets/zikr_count_widget.dart';
import 'package:dhikras/features/zikrs/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewCounter extends ConsumerStatefulWidget {
  const NewCounter({super.key, required this.items});
  final Items items;

  @override
  ConsumerState<NewCounter> createState() => _NewCounterState();
}

class _NewCounterState extends ConsumerState<NewCounter> {
  void _infonew() {
    showTranslationDialog(context, widget.items.translation);
 }

  @override
  Widget build(BuildContext context) {
    final counterKey = "new_zikr_${widget.items.counterKey}";
    final count = ref.watch(counterProvider(counterKey));
    final counter = ref.watch(counterProvider(counterKey).notifier);

    return Scaffold(
      appBar: AppBar(title: Text(widget.items.transcription)),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200).h,
              child: Text(
                widget.items.transcription,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            SizedBox(height: 200.h),
            ZikrCountWidget(
              count: count,
              onIncrement: () => counter.incrementCounter(),
              onReset: () => counter.reset(),
              onInfo: _infonew,
              onToggleAudio: () => emptyTextSelectionControls,
              displayText:
                  (count % widget.items.amount == 0 && count != 0)
                      ? '\u2713'
                      : '${count % widget.items.amount}',
              repeat:
                  widget.items.amount > 1
                      ? 'Repeat ${widget.items.amount} times'
                      : 'Repeat ${widget.items.amount} time',
              countValue: widget.items.amount,
              isUserAdded: true, 
              displayAmount: '$count',
            ),
          ],
        ),
      ),
    );
  }
}
