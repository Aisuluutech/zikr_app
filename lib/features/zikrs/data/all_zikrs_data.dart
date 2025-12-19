import 'package:dhikras/features/zikrs/data/after_prayer_items_data.dart';
import 'package:dhikras/features/zikrs/data/zikr_items_data.dart';
import 'package:dhikras/features/zikrs/models/zikr_items.dart';

final List<ZikrItems> allZikrs = [
  ...zikritems, 
  ...afterPrayerItems
  ];
 // na vsyakiy sluchai, esli vdrug dobavlyu poisk i favorite 
