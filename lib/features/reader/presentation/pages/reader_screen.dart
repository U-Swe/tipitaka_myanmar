import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tipitaka_myanmar/core/theme/settings_provider.dart';
// သင့် project ၏ မှန်ကန်သော လမ်းကြောင်းကို အသုံးပြုပါ
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
  Widget build(BuildContext context) {
    final String breadcrumbTitle =
        '${widget.pitakaTitle} \\ ${widget.chapterTitle}';

    // Theme နှင့် Settings များကို စောင့်ကြည့်ရန်
    ref.watch(fontSizeProvider);

    // Mobile / APK အတွက် pdfPathProvider ကို ပြန်လည်အသုံးပြုပါမည်
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
      ),

      // PDF Viewer အပိုင်း (SfPdfViewer.asset ကို ပြန်သုံးထားပါသည်)
      body: pdfPathAsyncValue.when(
        data: (pdfPath) {
          return SfPdfViewer.asset(
            pdfPath,
            controller: _pdfViewerController,
            canShowScrollHead: false,
            // Document လုံးဝ load ပြီးသွားသောအခါ စုစုပေါင်း Page အရေအတွက်ကို ယူမည်
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _pageCount = details.document.pages.count;
              });
            },
            // Page အကူးအပြောင်းတွင် လက်ရှိ Page နံပါတ်ကို Update လုပ်မည်
            onPageChanged: (PdfPageChangedDetails details) {
              setState(() {
                _currentPage = details.newPageNumber;
              });
            },
            onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              print('>>> PDF Load Failed: ${details.error}');
            },
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.brown)),
        error: (err, stack) =>
            Center(child: Text('Error: PDF ဖိုင် ဖွင့်၍မရပါ။ \n$err')),
      ),

      // အောက်ခြေရှိ Navigation & Zoom Control Bar
      bottomNavigationBar: BottomAppBar(
        color: Colors.brown.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1. Zoom In / Zoom Out အပိုင်း
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.zoom_out, color: Colors.brown),
                    onPressed: () {
                      _pdfViewerController.zoomLevel =
                          (_pdfViewerController.zoomLevel - 0.5).clamp(
                            1.0,
                            double.infinity,
                          );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.zoom_in, color: Colors.brown),
                    onPressed: () {
                      _pdfViewerController.zoomLevel =
                          _pdfViewerController.zoomLevel + 0.5;
                    },
                  ),
                ],
              ),

              // 2. Page Navigation အပိုင်း (Up, Down, Current/Total)
              Row(
                children: [
                  // Page Up (အပေါ်စာမျက်နှာသို့ သွားရန်)
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_up,
                      color: Colors.brown,
                    ),
                    onPressed: () {
                      _pdfViewerController.previousPage();
                    },
                  ),

                  // လက်ရှိစာမျက်နှာ / စုစုပေါင်းစာမျက်နှာ ဖော်ပြချက်
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown),
                      borderRadius: BorderRadius.circular(4),
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

                  // Page Down (အောက်စာမျက်နှာသို့ သွားရန်)
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_down,
                      color: Colors.brown,
                    ),
                    onPressed: () {
                      _pdfViewerController.nextPage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
