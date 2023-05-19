import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:euas_library_flutter_application/book_model.dart';
import 'package:euas_library_flutter_application/book_list.dart';
import 'package:euas_library_flutter_application/book_detail.dart';
import 'book.dart';
import 'book_model.dart';

class BookSearch extends SearchDelegate<Book?> {
  final Stream<List<Book>> allBooks;

  BookSearch(this.allBooks);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<List<Book>>(
      stream: allBooks,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final results = snapshot.data!.where((book) => book.title.toLowerCase().contains(query.toLowerCase())).toList();

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(results[index].title),
              onTap: () {
                close(context, results[index]);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<Book>>(
      stream: allBooks,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final results = snapshot.data!.where((book) => book.title.toLowerCase().contains(query.toLowerCase())).toList();

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(results[index].title),
              onTap: () {
                query = results[index].title;
              },
            );
          },
        );
      },
    );
  }
}
