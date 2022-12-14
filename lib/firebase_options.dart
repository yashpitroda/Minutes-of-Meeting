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
    apiKey: 'AIzaSyDFtG0RBzQBinFO8mE3hEfBbLvLt78_0b4',
    appId: '1:950441569954:web:975152fe059599844bb1fb',
    messagingSenderId: '950441569954',
    projectId: 'minute-of-meeting-fdabc',
    authDomain: 'minute-of-meeting-fdabc.firebaseapp.com',
    storageBucket: 'minute-of-meeting-fdabc.appspot.com',
    measurementId: 'G-53JFKYPJMC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDm_N3MV703aBEqSi42Xd59uzCjew-GTzY',
    appId: '1:950441569954:android:3a16c102c36b749b4bb1fb',
    messagingSenderId: '950441569954',
    projectId: 'minute-of-meeting-fdabc',
    storageBucket: 'minute-of-meeting-fdabc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBX8Vj6Ei56hcdw9CIPTruon4CeFq5jUGM',
    appId: '1:950441569954:ios:be2427057d98ee174bb1fb',
    messagingSenderId: '950441569954',
    projectId: 'minute-of-meeting-fdabc',
    storageBucket: 'minute-of-meeting-fdabc.appspot.com',
    iosClientId: '950441569954-5puodhiakghekgftiu7vferlnn8cfbri.apps.googleusercontent.com',
    iosBundleId: 'com.example.minuteofmeeting',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBX8Vj6Ei56hcdw9CIPTruon4CeFq5jUGM',
    appId: '1:950441569954:ios:be2427057d98ee174bb1fb',
    messagingSenderId: '950441569954',
    projectId: 'minute-of-meeting-fdabc',
    storageBucket: 'minute-of-meeting-fdabc.appspot.com',
    iosClientId: '950441569954-5puodhiakghekgftiu7vferlnn8cfbri.apps.googleusercontent.com',
    iosBundleId: 'com.example.minuteofmeeting',
  );
}
