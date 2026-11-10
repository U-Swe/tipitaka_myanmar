import 'package:flutter/material.dart';
// ReaderScreen ကို Package လမ်းကြောင်းဖြင့် တိုက်ရိုက်လှမ်းခေါ်ခြင်း
import 'package:tipitaka_myanmar/features/reader/presentation/pages/reader_screen.dart';

// Data များကို ဤဖိုင်ထဲတွင်ပင် တစ်ခါတည်း ကြေညာထားပါသည်
// JSON အစား PDF ဖိုင်အမည်များကို ပြောင်းလဲသတ်မှတ်ထားပါသည်
final List<Map<String, String>> pitakaIndexList = [
  {'title': '၁။ ပဌမ ပါရာဇိက', 'fileName': '1010100.pdf'},
  {'title': '၂။ ဒုတိယ ပါရာဇိက', 'fileName': '1010200.pdf'},
  {'title': '၃။ တတိယ ပါရာဇိက', 'fileName': '1010300.pdf'},
  {'title': '၄။ စတုတ္ထ ပါရာဇိက', 'fileName': '1010400.pdf'},
  {'title': 'ပါရာဇိက အကျဉ်းချုပ်', 'fileName': '1010500.pdf'},
];

class PitakaListScreen extends StatelessWidget {
  const PitakaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // pitakaTitle ဟု အသေမထားဘဲ အမှန်တကယ် ပေါ်စေချင်သော ခေါင်းစဉ်ကို ထည့်ပါ
        title: const Text('ဝိနည်းပိဋကတ်'),
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
                      pitakaTitle:
                          'ဝိနည်းပိဋကတ်', // သက်ဆိုင်ရာ ပိဋကတ်အမည်ကို ထည့်ပါ
                      subTitle: item['title']!, // မှန်ကန်သော 'title' key ကို ခေါ်ယူထားပါသည်
                      chapterTitle: item['title']!, // မှန်ကန်သော 'title' key ကို ခေါ်ယူထားပါသည်
                      fileName: item['fileName']!, // '1010100.pdf' စသည့် မှန်ကန်သော 'fileName' key ကို ခေါ်ယူထားပါသည်
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
