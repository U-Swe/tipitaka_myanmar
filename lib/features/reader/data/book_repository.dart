import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookRepository {
  Future<Uint8List> getPdfBytes(String fileName) async {
    try {
      final String pdfPath = 'assets/data/$fileName';
      print('>>> ဖတ်နေသော PDF လမ်းကြောင်း: $pdfPath');

      // rootBundle ဖြင့် Asset ကို ByteData အဖြစ် ဖတ်ပါမည်
      final ByteData byteData = await rootBundle.load(pdfPath);
      print('>>> PDF ByteData ဖတ်ရှုခြင်း အောင်မြင်ပါသည်။');

      // SfPdfViewer.memory အတွက် Uint8List သို့ ပြောင်းပေးပါသည်
      return byteData.buffer.asUint8List();
    } catch (e) {
      print('>>> BookRepository Error: $e');
      throw Exception('PDF ဖိုင်ဖတ်ရှုရာတွင် အမှားအယွင်းရှိပါသည်။');
    }
  }
}

// Repository Provider
final bookRepositoryProvider = Provider<BookRepository>(
  (ref) => BookRepository(),
);

// ဤ pdfBytesProvider ကို reader_screen.dart မှ လှမ်းခေါ်မည်ဖြစ်သည်
final pdfBytesProvider = FutureProvider.family<Uint8List, String>((
  ref,
  fileName,
) {
  final repository = ref.read(bookRepositoryProvider);
  return repository.getPdfBytes(fileName);
});
