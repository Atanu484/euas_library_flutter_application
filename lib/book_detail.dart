import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book.dart';
import 'book_model.dart';
import 'pdf_view_screen.dart';

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
      ),
      body: Form(
        key: _formKey,
        child: Column(
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
            ),
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
        child: Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                if (widget.book != null) {
                  Provider.of<BookModel>(context, listen: false).delete(widget.book!);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}


