import 'package:flutter/material.dart';

class ReaderScreen extends StatefulWidget {
  final String pitakaTitle; // ဥပမာ - ဝိနည်းပိဋကတ်
  final String subTitle; // ဥပမာ - ၁။ ပါရာဇိက
  final String chapterTitle; // ဥပမာ - ပထမသိက္ခာပုဒ်

  const ReaderScreen({
    Key? key,
    required this.pitakaTitle,
    required this.subTitle,
    required this.chapterTitle,
  }) : super(key: key);

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    // App Title တွင် Breadcrumb ပုံစံ ဖန်တီးခြင်း
    final String breadcrumbTitle =
        '${widget.pitakaTitle} \\ ${widget.subTitle} \\ ${widget.chapterTitle}';

    return Scaffold(
      appBar: AppBar(
        // စာသားရှည်ပါက အလိုအလျောက် သေးသွားစေရန် FittedBox ကို အသုံးပြုထားပါသည်
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
                if (_fontSize > 28.0) _fontSize = 16.0;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'ဤနေရာတွင် ${widget.chapterTitle} ၏ အသေးစိတ် စာသားများ ပေါ်လာပါမည်။',
          style: TextStyle(fontSize: _fontSize, height: 2.0),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
