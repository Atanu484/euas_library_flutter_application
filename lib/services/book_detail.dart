import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:euas_library_flutter_application/model/book.dart';
import 'package:euas_library_flutter_application/model/book_model.dart';
import 'package:euas_library_flutter_application/services/pdf_view.dart';
import 'package:euas_library_flutter_application/services/book_detail.dart';


class BookDetail extends StatefulWidget {
  final Book? book;

  BookDetail({this.book});

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _descriptionController;
  late String pdfUrl;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _authorController = TextEditingController(text: widget.book?.author ?? '');
    _descriptionController = TextEditingController(text: widget.book?.description ?? '');
    pdfUrl = widget.book?.pdfUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add Book' : 'Edit Book'),
        backgroundColor: Colors.yellow.shade800,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter title';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter author';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                String newPdfUrl = await Provider.of<BookModel>(context, listen: false).uploadPdf();
                if (newPdfUrl.isNotEmpty) {
                  setState(() {
                    pdfUrl = newPdfUrl;
                  });
                }
              },
              child: Text('Upload New PDF'),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewScreen(url: pdfUrl),
                  ),
                );
              },
              child: Text('Show PDF'),
              style: ElevatedButton.styleFrom(primary: Colors.purple),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Book updatedBook = Book(
              id: widget.book?.id ?? '',
              title: _titleController.text,
              author: _authorController.text,
              description: _descriptionController.text,
              pdfUrl: pdfUrl,
            );
            if (widget.book == null) {
              Provider.of<BookModel>(context, listen: false).add(updatedBook);
            } else {
              Provider.of<BookModel>(context, listen: false).update(updatedBook);
            }
            Navigator.of(context).pop();
          }
        },
        backgroundColor: Colors.yellow.shade700,
        child: Icon(Icons.save),
      ),
    );
  }
}

