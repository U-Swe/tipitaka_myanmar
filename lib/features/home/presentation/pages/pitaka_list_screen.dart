import 'package:flutter/material.dart';
// ReaderScreen ကို Package လမ်းကြောင်းဖြင့် တိုက်ရိုက်လှမ်းခေါ်ခြင်း
import 'package:tipitaka_myanmar/features/reader/presentation/pages/reader_screen.dart';

// Data များကို ဤဖိုင်ထဲတွင်ပင် တစ်ခါတည်း ကြေညာထားပါသည်
final List<Map<String, String>> pitakaIndexList = [
  {'title': '၁။ ပဌမအနိယတသိက္ခာပုဒ်', 'fileName': '1010100.json'},
  {'title': '၂။ ဒုတိယအနိယတသိက္ခာပုဒ်', 'fileName': '1010200.json'},
  {'title': ' အနိယတသိက္ခာပုဒ်  အကျဥ်းချုပ်', 'fileName': '1010300.json'},
  {'title': '၄။ စတုတ္ထ ပါရာဇိက', 'fileName': '1010400.json'},
  {'title': 'ပါရာဇိက အကျဥ်းချုပ်', 'fileName': '1010500.json'},
];

class PitakaListScreen extends StatelessWidget {
  const PitakaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pitakaTitle'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: pitakaIndexList.length,
        itemBuilder: (context, index) {
          final item = pitakaIndexList[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.brown,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                item['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Button နှိပ်လိုက်ပါက သက်ဆိုင်ရာ Data များကို Reader Screen သို့ ပို့ပေးပါမည်
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReaderScreen(
                      pitakaTitle: 'pitakaTitle',
                      subTitle: item['title']!, // ပြင်ဆင်ထားသော အပိုင်း: မှန်ကန်သော 'title' key ကို ခေါ်ယူထားပါသည်
                      chapterTitle: item['title']!, // ပြင်ဆင်ထားသော အပိုင်း: မှန်ကန်သော 'title' key ကို ခေါ်ယူထားပါသည်
                      fileName: item['fileName']!, // မှန်ကန်သော 'fileName' key ကို ခေါ်ယူထားပါသည်
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
