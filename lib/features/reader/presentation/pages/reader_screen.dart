import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tipitaka_myanmar/core/theme/settings_provider.dart';
import 'package:tipitaka_myanmar/features/home/data/favorites_recent_provider.dart';
import 'package:tipitaka_myanmar/features/reader/data/book_repository.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  final String pitakaTitle;
  final String subTitle;
  final String chapterTitle;
  final String fileName;

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
  final PdfViewerController _pdfViewerController = PdfViewerController();

  // လက်ရှိစာမျက်နှာနှင့် စုစုပေါင်းစာမျက်နှာကို သိမ်းဆည်းရန် State
  int _currentPage = 1;
  int _pageCount = 1;

  @override
  void initState() {
    super.initState();
    // စာမျက်နှာဖွင့်လိုက်သည်နှင့် Recent ထဲသို့ အလိုအလျောက် သိမ်းမည်
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(recentProvider.notifier)
          .addRecent(
            ReadingItem(
              pitakaTitle: widget.pitakaTitle,
              subTitle: widget.subTitle,
              chapterTitle: widget.chapterTitle,
              fileName: widget.fileName,
            ),
          );
    });
  }

  // လိုချင်သည့် စာမျက်နှာနံပါတ် ရိုက်ထည့်သွားရန် Dialog
  void _showJumpToPageDialog() {
    final TextEditingController pageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('စာမျက်နှာသို့ သွားရန်'),
          content: TextField(
            controller: pageController,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: InputDecoration(
              hintText: '1 မှ $_pageCount အတွင်း ရိုက်ထည့်ပါ',
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'ပယ်ဖျက်မည်',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final int? targetPage = int.tryParse(
                  pageController.text.trim(),
                );
                if (targetPage != null &&
                    targetPage >= 1 &&
                    targetPage <= _pageCount) {
                  _pdfViewerController.jumpToPage(targetPage);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '1 မှ $_pageCount အတွင်း မှန်ကန်သော နံပါတ်ရိုက်ထည့်ပါ',
                      ),
                    ),
                  );
                }
              },
              child: const Text('သွားမည်'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String breadcrumbTitle =
        '${widget.pitakaTitle} \\ ${widget.chapterTitle}';

    // Theme နှင့် Settings များကို စောင့်ကြည့်ရန်
    ref.watch(fontSizeProvider);

    // Mobile / APK အတွက် pdfPathProvider ကို အသုံးပြုခြင်း
    final pdfPathAsyncValue = ref.watch(pdfPathProvider(widget.fileName));

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
          Builder(
            builder: (context) {
              final favorites = ref.watch(favoritesProvider);
              final isFav = favorites.any(
                (e) =>
                    e.fileName == widget.fileName &&
                    e.chapterTitle == widget.chapterTitle,
              );
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.redAccent : Colors.white,
                ),
                onPressed: () {
                  ref
                      .read(favoritesProvider.notifier)
                      .toggleFavorite(
                        ReadingItem(
                          pitakaTitle: widget.pitakaTitle,
                          subTitle: widget.subTitle,
                          chapterTitle: widget.chapterTitle,
                          fileName: widget.fileName,
                        ),
                      );
                },
              );
            },
          ),
        ],
      ),

      // PDF Viewer အပိုင်း
      body: pdfPathAsyncValue.when(
        data: (pdfPath) {
          return SfPdfViewer.asset(
            pdfPath,
            controller: _pdfViewerController,
            canShowScrollHead: false,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _pageCount = details.document.pages.count;
              });
            },
            onPageChanged: (PdfPageChangedDetails details) {
              setState(() {
                _currentPage = details.newPageNumber;
              });
            },
            onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              debugPrint('>>> PDF Load Failed: ${details.error}');
            },
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.brown)),
        error: (err, stack) =>
            Center(child: Text('Error: PDF ဖိုင် ဖွင့်၍မရပါ။ \n$err')),
      ),

      // အောက်ခြေရှိ Page Navigation Control Bar (|<  <  1 / 54  >  >|)
      bottomNavigationBar: BottomAppBar(
        color: Colors.brown.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ၁။ Home Page / ပထမဆုံးစာမျက်နှာ (|<)
              IconButton(
                icon: const Icon(Icons.first_page, color: Colors.brown),
                tooltip: 'ပထမဆုံးစာမျက်နှာ',
                onPressed: _currentPage > 1
                    ? () => _pdfViewerController.jumpToPage(1)
                    : null,
              ),

              // ၂။ Page Up / ရှေ့စာမျက်နှာ (<)
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.brown),
                tooltip: 'ရှေ့စာမျက်နှာ',
                onPressed: _currentPage > 1
                    ? () => _pdfViewerController.previousPage()
                    : null,
              ),

              // ၃။ လက်ရှိစာမျက်နှာ / စုစုပေါင်းစာမျက်နှာ (နှိပ်လျှင် Input Dialog ပေါ်မည်)
              InkWell(
                onTap: _showJumpToPageDialog,
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.brown),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Text(
                    '$_currentPage / $_pageCount',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ),

              // ၄။ Page Down / နောက်စာမျက်နှာ (>)
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.brown),
                tooltip: 'နောက်စာမျက်နှာ',
                onPressed: _currentPage < _pageCount
                    ? () => _pdfViewerController.nextPage()
                    : null,
              ),

              // ၅။ End Page / နောက်ဆုံးစာမျက်နှာ (>|)
              IconButton(
                icon: const Icon(Icons.last_page, color: Colors.brown),
                tooltip: 'နောက်ဆုံးစာမျက်နှာ',
                onPressed: _currentPage < _pageCount
                    ? () => _pdfViewerController.jumpToPage(_pageCount)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
