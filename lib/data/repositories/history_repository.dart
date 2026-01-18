import '../../data/storage/hive_store.dart';
import '../../data/models/history_entry.dart';
import 'package:uuid/uuid.dart';

class HistoryRepository {
  const HistoryRepository();

  Future<void> addEntry({
    required String type,
    String? regionId,
    String? sleepQuality,
    int? intensity,
    String? notes,
  }) async {
    const uuid = Uuid();
    final entry = HistoryEntry(
      id: uuid.v4(),
      type: type,
      createdAt: DateTime.now(),
      regionId: regionId,
      sleepQuality: sleepQuality,
      intensity: intensity,
      notes: notes,
    );
    await HiveStore.addHistoryEntry(entry);
  }

  Future<void> removeEntry(String id) => HiveStore.removeHistoryEntry(id);

  List<HistoryEntry> getAllEntries() => HiveStore.getAllHistoryEntries();

  List<HistoryEntry> getByRegion(String regionId) =>
      HiveStore.getHistoryEntriesByRegion(regionId);

  List<HistoryEntry> getRecentEntries(int days) =>
      HiveStore.getRecentEntries(days);

  // Check if region has repeated entries (e.g., 3+ times in 7 days)
  Map<String, bool> checkRepeatedRegions({int threshold = 3, int days = 7}) {
    final freq = HiveStore.getRegionFrequency(days);
    final result = <String, bool>{};
    for (final entry in freq.entries) {
      result[entry.key] = entry.value >= threshold;
    }
    return result;
  }

  Future<void> clearAll() => HiveStore.clear();
}
