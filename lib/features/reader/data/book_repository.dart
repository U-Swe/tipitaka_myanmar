import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookRepository {
  Future<String> getPdfPath(String fileName) async {
    try {
      final String pdfPath = 'assets/data/$fileName';
      print('>>> Android/iOS အတွက် PDF ဖိုင်လမ်းကြောင်း: $pdfPath');

      // ဖိုင်လမ်းကြောင်း မှန်/မမှန် စစ်ဆေးခြင်း
      await rootBundle.load(pdfPath);
      return pdfPath; // Mobile အတွက် Path ကိုသာ ပြန်ပေးမည်
    } catch (e) {
      print('>>> BookRepository Error: $e');
      throw Exception('PDF ဖိုင်ဖတ်ရှုရာတွင် အမှားအယွင်းရှိပါသည်။');
    }
  }
}

final bookRepositoryProvider = Provider<BookRepository>(
  (ref) => BookRepository(),
);

final pdfPathProvider = FutureProvider.family<String, String>((ref, fileName) {
  final repository = ref.read(bookRepositoryProvider);
  return repository.getPdfPath(fileName);
});
