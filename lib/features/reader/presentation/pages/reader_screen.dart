import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// settings_provider.dart ကို import လုပ်ရန် မမေ့ပါနှင့်

class ReaderScreen extends ConsumerStatefulWidget {
  final String pitakaTitle;
  final String subTitle;
  final String chapterTitle;

  const ReaderScreen({
    Key? key,
    required this.pitakaTitle,
    required this.subTitle,
    required this.chapterTitle,
  }) : super(key: key);

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  @override
  Widget build(BuildContext context) {
    final String breadcrumbTitle =
        '${widget.pitakaTitle} \\ ${widget.subTitle} \\ ${widget.chapterTitle}';

    // Provider မှ Font Size ကို ဖတ်ယူခြင်း
    final fontSize = ref.watch(fontSizeProvider);

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
              // Font Size ကို Provider မှတစ်ဆင့် တိုး/လျှော့ လုပ်ခြင်း
              double currentSize = ref.read(fontSizeProvider);
              if (currentSize >= 28.0) {
                ref.read(fontSizeProvider.notifier).state = 16.0;
              } else {
                ref.read(fontSizeProvider.notifier).state = currentSize + 2.0;
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'ဤနေရာတွင် ${widget.chapterTitle} ၏ အသေးစိတ် စာသားများ ပေါ်လာပါမည်။',
          style: TextStyle(
            fontSize: fontSize, // Provider မှ ရသော Size ကို အသုံးပြုခြင်း
            height: 2.0,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
