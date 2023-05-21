import 'dart:io';
import 'package:euas_library_flutter_application/model/book_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:euas_library_flutter_application/model/book.dart';
import 'package:euas_library_flutter_application/services/book_detail.dart';
import 'package:euas_library_flutter_application/controller/auth_service.dart';
import 'package:euas_library_flutter_application/pages/sign_up_page.dart';
import 'package:euas_library_flutter_application/services/pdf_view.dart';

class BookList extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Consumer<BookModel>(
      builder: (context, bookModel, child) {
        return StreamBuilder<List<Book>>(
          stream: bookModel.allBooks,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return Scaffold(
              appBar: AppBar(
                title: Text('University Library'),
                backgroundColor: Colors.yellow.shade800,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () async {
                      await _authService.signOutGoogle();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                  ),
                ],
              ),
              body: ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  Book book = snapshot.data![index];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(book.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Author: ${book.author}'),
                          SizedBox(height: 5),
                          Text('Description: ${book.description}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BookDetail(book: book)),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.book, color: Colors.purple),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PdfViewScreen(url: book.pdfUrl)),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.file_download, color: Colors.green),
                            onPressed: () async {
                              String path = await getDownloadPath();
                              await downloadFile(book.pdfUrl, path);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('PDF downloaded to $path'),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              bookModel.delete(book);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookDetail(book: book)),
                        );
                      },
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookDetail(book: null)),
                  );
                },
                backgroundColor: Colors.yellow.shade700,
                child: Icon(Icons.add),
              ),
            );
          },
        );
      },
    );
  }

  Future<String> getDownloadPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/file.pdf';
  }

  Future<void> downloadFile(String url, String path) async {
    Dio dio = Dio();
    try {
      await dio.download(url, path);
    } catch (e) {
      throw 'Error downloading file: $e';
    }
  }
}