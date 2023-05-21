import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:euas_library_flutter_application/model/book.dart';
import 'package:euas_library_flutter_application/model/book_model.dart';

class PdfViewScreen extends StatefulWidget {
  final String url;

  PdfViewScreen({required this.url});

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String? path;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    final response = await http.get(Uri.parse(widget.url));
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/file.pdf');
    await file.writeAsBytes(response.bodyBytes);
    setState(() {
      path = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF View'),
      ),
      body: path == null
          ? Center(child: CircularProgressIndicator())
          : PDFView(
        filePath: path!,
      ),
    );
  }
}
