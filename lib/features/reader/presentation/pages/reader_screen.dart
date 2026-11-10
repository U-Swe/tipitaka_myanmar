import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tipitaka_myanmar/core/theme/settings_provider.dart';
// book_repository.dart ကို မှန်ကန်စွာ Import လုပ်ထားခြင်း
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

  @override
  Widget build(BuildContext context) {
    final String breadcrumbTitle =
        '${widget.pitakaTitle} \\ ${widget.chapterTitle}';

    // Font Size / Zoom အတွက်
    ref.watch(fontSizeProvider);

    // pdfBytesProvider ကို လှမ်းခေါ်ခြင်း (ယခုအခါ Error မတက်တော့ပါ)
    final pdfBytesAsyncValue = ref.watch(pdfBytesProvider(widget.fileName));

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
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              _pdfViewerController.zoomLevel =
                  _pdfViewerController.zoomLevel + 0.5;
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              _pdfViewerController.zoomLevel =
                  (_pdfViewerController.zoomLevel - 0.5).clamp(
                    1.0,
                    double.infinity,
                  );
            },
          ),
        ],
      ),
      body: pdfBytesAsyncValue.when(
        data: (pdfBytes) {
          return SfPdfViewer.memory(
            pdfBytes,
            controller: _pdfViewerController,
            canShowScrollHead: false,
            onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              print('>>> PDF Load Failed: ${details.error}');
              print('>>> Description: ${details.description}');
            },
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.brown)),
        error: (err, stack) =>
            Center(child: Text('Error: PDF ဖိုင် ဖွင့်၍မရပါ။ \n$err')),
      ),
    );
  }
}
