import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingItem {
  final String pitakaTitle;
  final String subTitle;
  final String chapterTitle;
  final String fileName;

  ReadingItem({
    required this.pitakaTitle,
    required this.subTitle,
    required this.chapterTitle,
    required this.fileName,
  });

  Map<String, dynamic> toJson() => {
    'pitakaTitle': pitakaTitle,
    'subTitle': subTitle,
    'chapterTitle': chapterTitle,
    'fileName': fileName,
  };

  factory ReadingItem.fromJson(Map<String, dynamic> json) => ReadingItem(
    pitakaTitle: json['pitakaTitle'] ?? '',
    subTitle: json['subTitle'] ?? '',
    chapterTitle: json['chapterTitle'] ?? '',
    fileName: json['fileName'] ?? '',
  );
}

class ReadingListNotifier extends Notifier<List<ReadingItem>> {
  final String storageKey;

  ReadingListNotifier(this.storageKey);

  @override
  List<ReadingItem> build() {
    _loadItems();
    return [];
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(storageKey);
    if (raw != null) {
      final List decoded = jsonDecode(raw);
      state = decoded.map((e) => ReadingItem.fromJson(e)).toList();
    }
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(state.map((e) => e.toJson()).toList());
    await prefs.setString(storageKey, encoded);
  }

  // Favorites အတွက် ထည့်/ဖြုတ် လုပ်ရန်
  Future<void> toggleFavorite(ReadingItem item) async {
    final exists = state.any(
      (e) => e.fileName == item.fileName && e.chapterTitle == item.chapterTitle,
    );
    if (exists) {
      state = state
          .where(
            (e) =>
                !(e.fileName == item.fileName &&
                    e.chapterTitle == item.chapterTitle),
          )
          .toList();
    } else {
      state = [item, ...state];
    }
    await _saveItems();
  }

  // Recent အတွက် နောက်ဆုံးကြည့်ထားသည်ကို ထိပ်ဆုံးတွင် ထည့်ရန်
  Future<void> addRecent(ReadingItem item) async {
    final filtered = state
        .where(
          (e) =>
              !(e.fileName == item.fileName &&
                  e.chapterTitle == item.chapterTitle),
        )
        .toList();
    state = [item, ...filtered].take(30).toList(); // အများဆုံး ၃၀ ခု သိမ်းမည်
    await _saveItems();
  }

  // တစ်ခုချင်း ဖျက်ရန်
  Future<void> removeItem(ReadingItem item) async {
    state = state
        .where(
          (e) =>
              !(e.fileName == item.fileName &&
                  e.chapterTitle == item.chapterTitle),
        )
        .toList();
    await _saveItems();
  }

  // အားလုံး ဖျက်ရန် (Clear All)
  Future<void> clearAll() async {
    state = [];
    await _saveItems();
  }
}

final favoritesProvider =
    NotifierProvider<ReadingListNotifier, List<ReadingItem>>(
      () => ReadingListNotifier('favorites_list'),
    );

final recentProvider = NotifierProvider<ReadingListNotifier, List<ReadingItem>>(
  () => ReadingListNotifier('recent_list'),
);
