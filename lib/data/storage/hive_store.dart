import 'package:hive_flutter/hive_flutter.dart';
import '../models/history_entry.dart';

class HiveStore {
  static const String historyBoxName = 'history';

  static Future<void> init() async {
    await Hive.initFlutter();
    // Register HistoryEntry adapter\n    if (!Hive.isAdapterRegistered(11)) {\n      Hive.registerAdapter(HistoryEntryAdapter());\n    }
    await Hive.openBox<HistoryEntry>(historyBoxName);
  }

  static Box<HistoryEntry> get historyBox =>
      Hive.box<HistoryEntry>(historyBoxName);

  static Future<void> addHistoryEntry(HistoryEntry entry) async {
    await historyBox.put(entry.id, entry);
  }

  static Future<void> removeHistoryEntry(String id) async {
    await historyBox.delete(id);
  }

  static List<HistoryEntry> getAllHistoryEntries() {
    return historyBox.values.toList();
  }

  static List<HistoryEntry> getHistoryEntriesByRegion(String regionId) {
    return historyBox.values
        .where((entry) => entry.regionId == regionId)
        .toList();
  }

  static List<HistoryEntry> getRecentEntries(int days) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return historyBox.values
        .where((entry) => entry.createdAt.isAfter(cutoff))
        .toList();
  }

  static Map<String, int> getRegionFrequency(int days) {
    final recent = getRecentEntries(days);
    final freq = <String, int>{};
    for (final entry in recent) {
      if (entry.regionId != null) {
        freq[entry.regionId!] = (freq[entry.regionId!] ?? 0) + 1;
      }
    }
    return freq;
  }

  static Future<void> clear() async {
    await historyBox.clear();
  }
}
