// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAvwzp4lEJRGGO4dZyj2-VT1v6mfVR2FYE',
    appId: '1:531641790203:web:8aa8034d58f582ae614a5e',
    messagingSenderId: '531641790203',
    projectId: 'hustlehub-baba8',
    authDomain: 'hustlehub-baba8.firebaseapp.com',
    storageBucket: 'hustlehub-baba8.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHFSxCujRjkJ5NW87IH9uz5osLgWRFP6E',
    appId: '1:531641790203:android:d82e3b70aa52c85a614a5e',
    messagingSenderId: '531641790203',
    projectId: 'hustlehub-baba8',
    storageBucket: 'hustlehub-baba8.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAvwzp4lEJRGGO4dZyj2-VT1v6mfVR2FYE',
    appId: '1:531641790203:web:d8094d64633adede614a5e',
    messagingSenderId: '531641790203',
    projectId: 'hustlehub-baba8',
    authDomain: 'hustlehub-baba8.firebaseapp.com',
    storageBucket: 'hustlehub-baba8.firebasestorage.app',
  );
}