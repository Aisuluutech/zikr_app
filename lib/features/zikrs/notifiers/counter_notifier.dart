import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dhikras/features/zikrs/services/storage_service.dart';

class CounterNotifier extends StateNotifier<int> {
  final String key;

  CounterNotifier(this.key) : super(0) {
    _load();
  }

  Future<void> _load() async {
    state = await StorageService.load<int>(key) ?? 0;
  }

  Future<void> incrementCounter() async {
    state++;
    await StorageService.save<int>(key, state);
  }

  Future<void> reset() async {
    state = 0;
    await StorageService.save<int>(key, state);
  }
}

