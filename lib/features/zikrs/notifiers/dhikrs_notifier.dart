import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dhikras/features/zikrs/models/new_zikr_items.dart';
import 'package:dhikras/features/zikrs/services/storage_service.dart';

class DhikrsNotifier extends StateNotifier<List<Items>> {
  static const _key = "dhikrs"; 

  DhikrsNotifier() : super([]) {
    _load();
  }

  Future<void> _load() async {
    final jsonList = await StorageService.loadItemsList(_key);
    state = jsonList.map((e) => Items.fromJson(e)).toList();
  }

  Future<void> add(Items item) async {
    final updated = [...state, item];
    state = updated;
    await StorageService.saveItemsList(
      _key,
      updated.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> remove(Items item) async {
    final updated = state.where((e) => e != item).toList();
    state = updated;
    await StorageService.saveItemsList(
      _key,
      updated.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> removeAt(int index) async {
    final updated = [...state]..removeAt(index);
    state = updated;
    await StorageService.saveItemsList(
      _key,
      updated.map((e) => e.toJson()).toList(),
    );
  }
}





