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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJ2IRo6NRRnhf4ga8vF0rPpGkdwIbs6oo',
    appId: '1:648213492359:android:199edea0aaa2a0014efe22',
    messagingSenderId: '648213492359',
    projectId: 'my-portfolio-fe1ff',
    storageBucket: 'my-portfolio-fe1ff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlQdYtn_pDGsu6USHGFVOXoXuFiQ9S44M',
    appId: '1:648213492359:ios:0771929d8eb3c2174efe22',
    messagingSenderId: '648213492359',
    projectId: 'my-portfolio-fe1ff',
    storageBucket: 'my-portfolio-fe1ff.appspot.com',
    androidClientId: '648213492359-ohucvsinm4s9rocj6lv1rqhijaelf4fh.apps.googleusercontent.com',
    iosClientId: '648213492359-i93apmjntii68dl0ehq70b613fp0k9g8.apps.googleusercontent.com',
    iosBundleId: 'com.example.fireFlutter',
  );
}
