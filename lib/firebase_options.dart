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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyC_UDd_rCtDSknMov0atxZonbg5l8LCl98',
    appId: '1:492132585932:web:dc856b911feccd3dc90d69',
    messagingSenderId: '492132585932',
    projectId: 'fir-task-2a533',
    authDomain: 'fir-task-2a533.firebaseapp.com',
    storageBucket: 'fir-task-2a533.appspot.com',
    measurementId: 'G-4VFL6321Q6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDaNIB2ZcH9KolRFEiagipMphHoWOneiyI',
    appId: '1:492132585932:android:417255dbf5143afac90d69',
    messagingSenderId: '492132585932',
    projectId: 'fir-task-2a533',
    storageBucket: 'fir-task-2a533.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYSRnPA8HwCNd-9Cn55ox2FFLqbHMu8VQ',
    appId: '1:492132585932:ios:e79949543d128c25c90d69',
    messagingSenderId: '492132585932',
    projectId: 'fir-task-2a533',
    storageBucket: 'fir-task-2a533.appspot.com',
    iosBundleId: 'com.example.firebasetask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYSRnPA8HwCNd-9Cn55ox2FFLqbHMu8VQ',
    appId: '1:492132585932:ios:e79949543d128c25c90d69',
    messagingSenderId: '492132585932',
    projectId: 'fir-task-2a533',
    storageBucket: 'fir-task-2a533.appspot.com',
    iosBundleId: 'com.example.firebasetask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC_UDd_rCtDSknMov0atxZonbg5l8LCl98',
    appId: '1:492132585932:web:96a6245f09552242c90d69',
    messagingSenderId: '492132585932',
    projectId: 'fir-task-2a533',
    authDomain: 'fir-task-2a533.firebaseapp.com',
    storageBucket: 'fir-task-2a533.appspot.com',
    measurementId: 'G-WYGS64TBX8',
  );
}
