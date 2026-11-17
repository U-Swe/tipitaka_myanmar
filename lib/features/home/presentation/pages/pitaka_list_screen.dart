// ဖိုင်လမ်းကြောင်း: lib/features/home/presentation/pages/pitaka_list_screen.dart

import 'package:flutter/material.dart';
import 'package:tipitaka_myanmar/features/reader/presentation/pages/reader_screen.dart';

class PitakaListScreen extends StatelessWidget {
  // အရှေ့စာမျက်နှာမှ လှမ်းပို့ပေးမည့် Variable များ
  final String pitakaTitle;
  final List> bookList;

  const PitakaListScreen({
    super.key,
    required this.pitakaTitle,
    required this.bookList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Variable ကို အသုံးပြုထားသဖြင့် 'ဝိနည်း' နှိပ်လျှင် 'ဝိနည်းပိဋကတ်'၊ 'သုတ္တန္တ' နှိပ်လျှင် 'သုတ္တန္တပိဋကတ်' ဟု အလိုအလျောက် ပြောင်းလဲပေါ်မည်ဖြစ်သည်
        title: Text(pitakaTitle),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bookList.length,
        itemBuilder: (context, index) {
          final item = bookList[index];

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReaderScreen(
                      pitakaTitle: pitakaTitle, 
                      subTitle: item['title']!, 
                      chapterTitle: item['title']!, 
                      fileName: item['fileName']!, 
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