import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookRepository {
  // parameter အနေဖြင့် fileName နှင့် chapterTitle ကို လက်ခံပါမည်
  Future<String> getChapterContent(String fileName, String chapterTitle) async {
    try {
      // 1. ဖိုင်လမ်းကြောင်း မှန်/မမှန် စစ်ဆေးရန်
      print('>>> ဖတ်နေသောဖိုင်: assets/data/$fileName');

      final ByteData byteData = await rootBundle.load('assets/data/$fileName');
      print('>>> ဖိုင်ကိုရှာတွေ့ပါသည်။ ByteData ဖြင့် ဖတ်ပြီးပါပြီ။');

      // 2. UTF-8 Encoding ဖြင့် စာသားပြောင်းရန်
      final String response = utf8.decode(byteData.buffer.asUint8List());
      print('>>> UTF-8 Decode လုပ်ခြင်း အောင်မြင်ပါသည်။');

      // 3. JSON format ကို ဖြည်ရန်
      final dynamic data = json.decode(response);
      print('>>> JSON Decode လုပ်ခြင်း အောင်မြင်ပါသည်။');

      // 4. Data ထဲမှ "content" ကို ရှာဖွေရန်
      if (data is List) {
        for (var item in data) {
          if (item['content'] != null) {
            print('>>> "content" key ရှာတွေ့ပါသည်။ စာသားကို ပြန်ပေးပါမည်။');
            return item['content'].toString();
          }
        }
      } else if (data is Map) {
        if (data['content'] != null) {
          print('>>> "content" key ရှာတွေ့ပါသည်။ စာသားကို ပြန်ပေးပါမည်။');
          return data['content'].toString();
        }
      }

      print('>>> Error: JSON ထဲတွင် "content" key ရှာမတွေ့ပါ။');
      return 'စာသား ရှာမတွေ့ပါ။ (JSON ဖိုင်ထဲတွင် "content" ဆိုသော key မပါဝင်ပါ)';
    } catch (e) {
      // Error တက်ပါက Terminal တွင် အနီရောင်ဖြင့် ပြပေးပါမည်
      print('>>> BookRepository Error: $e');
      return 'ဖိုင်ဖတ်ရှုရာတွင် အမှားအယွင်းရှိပါသည်။\nError: $e';
    }
  }
}

// Repository Provider
final bookRepositoryProvider = Provider<BookRepository>(
  (ref) => BookRepository(),
);

// Provider က fileName နှင့် chapterTitle နှစ်ခုလုံးကို လက်ခံနိုင်ရန် Map ကို သုံးထားပါသည်
final chapterContentProvider =
    FutureProvider.family<String, Map<String, String>>((ref, params) {
      final repository = ref.read(bookRepositoryProvider);
      return repository.getChapterContent(
        params['fileName']!,
        params['chapterTitle']!,
      );
    });
