// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDzZ8ngHWPViZegPMwBx_Bswrihi1xlNLk',
    appId: '1:185395998123:web:09c0d48c2c7c94091f76ee',
    messagingSenderId: '185395998123',
    projectId: 'euas-library-flutter',
    authDomain: 'euas-library-flutter.firebaseapp.com',
    storageBucket: 'euas-library-flutter.appspot.com',
    measurementId: 'G-TME6HR65ZD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB601gMJ281OnUwhR6OT2BAdLJMfmnxpcs',
    appId: '1:185395998123:android:4da82288e109f3a41f76ee',
    messagingSenderId: '185395998123',
    projectId: 'euas-library-flutter',
    storageBucket: 'euas-library-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtqDADEJpCiBGWWLG5Smj_PSxSI_KTDNY',
    appId: '1:185395998123:ios:82956a86058e9e6f1f76ee',
    messagingSenderId: '185395998123',
    projectId: 'euas-library-flutter',
    storageBucket: 'euas-library-flutter.appspot.com',
    iosClientId: '185395998123-rvuipjmou4jdfplkl26jm82fs37egmdk.apps.googleusercontent.com',
    iosBundleId: 'com.example.euasLibraryFlutterApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtqDADEJpCiBGWWLG5Smj_PSxSI_KTDNY',
    appId: '1:185395998123:ios:82956a86058e9e6f1f76ee',
    messagingSenderId: '185395998123',
    projectId: 'euas-library-flutter',
    storageBucket: 'euas-library-flutter.appspot.com',
    iosClientId: '185395998123-rvuipjmou4jdfplkl26jm82fs37egmdk.apps.googleusercontent.com',
    iosBundleId: 'com.example.euasLibraryFlutterApplication',
  );
}
