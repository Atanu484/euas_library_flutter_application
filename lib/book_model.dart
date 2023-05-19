import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'book.dart';
import 'book_model.dart';

class BookModel extends ChangeNotifier {
  final CollectionReference booksCollection = FirebaseFirestore.instance.collection('books');
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if(result != null) {
      File file = File(result.files.single.path!);
      try {
        String path = 'pdfs/${DateTime.now().toIso8601String()}.pdf';
        await storage.ref(path).putFile(file);
        String downloadURL = await storage.ref(path).getDownloadURL();
        return downloadURL;
      } catch (e) {
        print(e);
        return '';
      }
    } else {
      return '';
    }
  }

  Future<void> deletePdf(String pdfUrl) async {
    Reference ref = storage.refFromURL(pdfUrl);
    try {
      await ref.delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> add(Book book) async {
    await booksCollection.add({
      'title': book.title,
      'author': book.author,
      'description': book.description,
      'pdfUrl': book.pdfUrl,
    });
    notifyListeners();
  }

  Future<void> update(Book book) async {
    await booksCollection.doc(book.id).update({
      'title': book.title,
      'author': book.author,
      'description': book.description,
      'pdfUrl': book.pdfUrl,
    });
    notifyListeners();
  }

  Future<void> delete(Book book) async {
    try {
      await deletePdf(book.pdfUrl);
    } catch (e) {
      print('Failed to delete PDF: $e');
    }

    try {
      await booksCollection.doc(book.id).delete();
      notifyListeners();
    } catch (e) {
      print('Failed to delete Firestore document: $e');
    }
  }

  Stream<List<Book>> get allBooks {
    return booksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();
    });
  }
}
