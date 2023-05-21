import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:euas_library_flutter_application/model/book_model.dart';
import 'package:euas_library_flutter_application/services/book_list.dart';
import 'package:euas_library_flutter_application/pages/landing_page.dart';
import 'package:euas_library_flutter_application/pages/sign_up_page.dart';
import 'package:euas_library_flutter_application/controller/auth_service.dart';
import 'package:euas_library_flutter_application/pages/varify_email_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (context) => BookModel(),
    child: UniversityLibraryApp(),
  ));
}

class UniversityLibraryApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'University Library',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return BookList();
          } else {
            return LandingPage();
          }
        },
      ),
    );
  }
}
