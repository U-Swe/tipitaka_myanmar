import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// သင်၏ book_repository.dart တည်ရှိရာ လမ်းကြောင်းကို မှန်ကန်စွာ Import လုပ်ပါ
import 'package:tipitaka_myanmar/features/reader/data/book_repository.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  final String pitakaTitle; // ဥပမာ - ဝိနည်းပိဋကတ်
  final String subTitle; // ဥပမာ - ၁။ ပါရာဇိက
  final String chapterTitle; // ဥပမာ - ၁။ ပဌမ ပါရာဇိက
  final String fileName; // JSON ဖိုင်နာမည် (ဥပမာ - 10101.json)

  const ReaderScreen({
    super.key,
    required this.pitakaTitle,
    required this.subTitle,
    required this.chapterTitle,
    required this.fileName, // ဖိုင်နာမည် မဖြစ်မနေ လိုအပ်ပါသည်
  });

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    // App Title တွင် Breadcrumb ပုံစံ ဖန်တီးခြင်း
    final String breadcrumbTitle =
        '${widget.pitakaTitle} \\ ${widget.subTitle} \\ ${widget.chapterTitle}';

    // Provider မှတဆင့် JSON ဖိုင်ကို လှမ်းဖတ်ခြင်း
    final contentAsyncValue = ref.watch(
      chapterContentProvider({
        'fileName': widget.fileName,
        'chapterTitle': widget.chapterTitle,
      }),
    );

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            breadcrumbTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.text_increase),
            onPressed: () {
              setState(() {
                _fontSize += 2.0;
                if (_fontSize > 28.0) _fontSize = 16.0; // အကြီးဆုံး 28 ထိသာ
              });
            },
          ),
        ],
      ),
      body: contentAsyncValue.when(
        // ဒေတာ ရရှိလာသောအခါ စာသားများကို ပြသပါမည်
        data: (content) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: TextStyle(
                fontSize: _fontSize,
                height: 2.0,
                // အရောင်ကို အသေမသတ်မှတ်ဘဲ Theme အလိုက် အလိုအလျောက် ပြောင်းလဲစေရန်
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              textAlign: TextAlign.justify,
            ),
          );
        },
        // ဒေတာ ဖတ်နေစဉ် (Loading) လည်နေသော ပုံလေး ပြသပါမည်
        loading: () => const Center(child: CircularProgressIndicator()),
        // အမှားအယွင်းရှိပါက Error စာသား ပြသပါမည်
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'စာသားဖတ်ရှုရာတွင် အမှားအယွင်းရှိပါသည်။\n$error',
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
