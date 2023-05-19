import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:euas_library_flutter_application/book_model.dart';
import 'package:euas_library_flutter_application/book_list.dart';
import 'book.dart';
import 'book_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (context) => BookModel(),
    child: UniversityLibraryApp(),
  ));
}

class UniversityLibraryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'University Library',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookList(),
    );
  }
}

