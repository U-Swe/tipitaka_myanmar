import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tipitaka_myanmar/core/theme/settings_provider.dart';
import 'package:tipitaka_myanmar/features/reader/data/book_repository.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  final String pitakaTitle;
  final String subTitle;
  final String chapterTitle;
  final String fileName; // JSON ဖိုင်နာမည်ကို လက်ခံရန်

  const ReaderScreen({
    super.key,
    required this.pitakaTitle,
    required this.subTitle,
    required this.chapterTitle,
    required this.fileName,
  });

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  @override
  Widget build(BuildContext context) {
    // Breadcrumb Title ဖန်တီးခြင်း
    final String breadcrumbTitle =
        '${widget.pitakaTitle} \\ ${widget.subTitle} \\ ${widget.chapterTitle}';

    // Provider မှ Font Size ကို ဖတ်ယူခြင်း
    final fontSize = ref.watch(fontSizeProvider);

    // ရွေးချယ်ထားသော ခေါင်းစဉ်အလိုက် Data ကို လှမ်းခေါ်ခြင်း
    // Provider သို့ fileName နှင့် chapterTitle နှစ်ခုလုံးကို Record/Map အနေဖြင့် ပို့ပေးပါသည်
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
              // Font Size ကို Provider (Notifier) မှတစ်ဆင့် တိုး/လျှော့ လုပ်ခြင်း
              double currentSize = ref.read(fontSizeProvider);
              double nextSize = currentSize >= 28.0 ? 16.0 : currentSize + 2.0;
              ref.read(fontSizeProvider.notifier).updateSize(nextSize);
            },
          ),
        ],
      ),
      // FutureProvider မှ ရရှိလာမည့် အခြေအနေ (၃) ရပ်ကို ကိုင်တွယ်ခြင်း
      body: contentAsyncValue.when(
        data: (content) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content,
            style: TextStyle(fontSize: fontSize, height: 2.0),
            textAlign: TextAlign.justify,
          ),
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.brown)),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
