import 'package:dhikras/core/providers/navigation_service_provider.dart';
import 'package:dhikras/features/zikrs/data/zikr_items_data.dart';
import 'package:dhikras/features/zikrs/precentation/afterprayer_screen.dart';
import 'package:dhikras/features/zikrs/models/new_zikr_items.dart';
import 'package:dhikras/features/zikrs/precentation/new_counter_screen.dart';
import 'package:dhikras/features/zikrs/widgets/new_zikr_form.dart';
import 'package:dhikras/features/zikrs/precentation/zikr_screen.dart';
import 'package:dhikras/features/zikrs/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends ConsumerStatefulWidget {
  const Counter({super.key});

  @override
  ConsumerState<Counter> createState() => _CounterState();
}

class _CounterState extends ConsumerState<Counter> {
  void _tapToCount(BuildContext context, Items zikr) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => NewCounter(
              items: zikr,
            ),
      ),
    );
  }

  void addNewZikr(BuildContext context) {
    final addZikr = ref.read(dhikrsProvider.notifier);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => NewZikr(onAddZikr: (item) => addZikr.add(item)),
    );
  }

  Widget _buildAfterPrayer(Function(BuildContext) onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onTap(context),
          child: Container(
            margin: EdgeInsets.all(8),
            width: 400,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: Text(
                    'After prayer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 0, 8),
                  child: Text('7 dhikrs', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildStaticZikrItem(
    String title,
    String count,
    Function(BuildContext) onTap,
  ) {
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
        margin: EdgeInsets.all(8),
        width: 400,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(padding: const EdgeInsets.all(16), child: Text(title)),
            Card(
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  count,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZikrItem(Items zikr, int index) {
    final dhikars = ref.read(dhikrsProvider.notifier);

    return Dismissible(
      key: ValueKey(zikr),
      onDismissed: (_) => dhikars.removeAt(index),
      child: InkWell(
        onTap: () {
          _tapToCount(context, zikr);
        },
        child: Container(
          margin: EdgeInsets.all(8),
          width: 400,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(zikr.transcription),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      dhikars.removeAt(index);
                    },
                    icon: Icon(Icons.delete),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Card(
                      color: Theme.of(context).colorScheme.primary,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '${zikr.amount.toInt()}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final navigationService = ref.read(navigationServiceProvider);
    final dhikars = ref.watch(dhikrsProvider);

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(16),
        title: Text('DHIKRAS'),
        actions: [
          IconButton(
            onPressed: () {
              addNewZikr(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStaticZikrItem(
              'Subhaanallah',
              '33',
              (page) => navigationService.push(
                ZikrScreen(items: zikritems[0]
                ),
              ),
            ),
            _buildStaticZikrItem(
              'Alhamdulillah',
              '33',
              (page) => navigationService.push(ZikrScreen(
                 items: zikritems[1],
                ),),
            ),
            _buildStaticZikrItem(
              'Allahu Akbar',
              '33',
              (page) => navigationService.push(ZikrScreen(
                 items: zikritems[2],
                ),),
            ),
            _buildAfterPrayer((page) => navigationService.push(Afterprayer())),
            ...dhikars.asMap().entries.map((entry) {
              final index = entry.key;
              final zikr = entry.value;
              return _buildZikrItem(zikr, index);
            }),
          ],
        ),
      ),
    );
  }
}
