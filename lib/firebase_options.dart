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
    apiKey: 'AIzaSyDlpTNQh6eW5ILFvcwzTeDRlaIhd6aMgkk',
    appId: '1:807006308387:web:03665902e76c1c26480996',
    messagingSenderId: '807006308387',
    projectId: 'vital-invention-397314',
    authDomain: 'vital-invention-397314.firebaseapp.com',
    storageBucket: 'vital-invention-397314.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCM8ADHvSCN5Hfj8UNFFQQ_rDsC4JpHSoE',
    appId: '1:807006308387:android:91ff3a4eba14632c480996',
    messagingSenderId: '807006308387',
    projectId: 'vital-invention-397314',
    storageBucket: 'vital-invention-397314.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRmnJKQDS906e8pXv7kve1hFDoQRxlNKk',
    appId: '1:807006308387:ios:eb82fce33b122d96480996',
    messagingSenderId: '807006308387',
    projectId: 'vital-invention-397314',
    storageBucket: 'vital-invention-397314.appspot.com',
    iosBundleId: 'com.example.expenditureManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRmnJKQDS906e8pXv7kve1hFDoQRxlNKk',
    appId: '1:807006308387:ios:659cd566fff8b2b9480996',
    messagingSenderId: '807006308387',
    projectId: 'vital-invention-397314',
    storageBucket: 'vital-invention-397314.appspot.com',
    iosBundleId: 'com.example.expenditureManagement.RunnerTests',
  );
}