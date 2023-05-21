import 'book.dart';
import 'book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String pdfUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.pdfUrl,
  });

  factory Book.fromFirestore(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data() as Map<String, dynamic>;
    String id = documentSnapshot.id;
    return Book(
      id: id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      description: data['description'] ?? '',
      pdfUrl: data['pdfUrl'] ?? '',
    );
  }
}
