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
    apiKey: 'AIzaSyAs1oTVe-uIrotrsv2F4LJq6-IB8ou1vJ8',
    appId: '1:757880039105:web:b93616194f9b4ebc61d640',
    messagingSenderId: '757880039105',
    projectId: 'weatherapp-223fc',
    authDomain: 'weatherapp-223fc.firebaseapp.com',
    storageBucket: 'weatherapp-223fc.appspot.com',
    measurementId: 'G-T9ZN5CEC4L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZ1mG8xWHCTtwaRCKm92PloY1p3lZJ4T0',
    appId: '1:757880039105:android:63a8cbdc5814911561d640',
    messagingSenderId: '757880039105',
    projectId: 'weatherapp-223fc',
    storageBucket: 'weatherapp-223fc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBNwvoXA9OpMHDVoeRso2h3Db4h6xAaKmg',
    appId: '1:757880039105:ios:d42c61e00f95051e61d640',
    messagingSenderId: '757880039105',
    projectId: 'weatherapp-223fc',
    storageBucket: 'weatherapp-223fc.appspot.com',
    iosBundleId: 'com.example.weatherapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBNwvoXA9OpMHDVoeRso2h3Db4h6xAaKmg',
    appId: '1:757880039105:ios:d42c61e00f95051e61d640',
    messagingSenderId: '757880039105',
    projectId: 'weatherapp-223fc',
    storageBucket: 'weatherapp-223fc.appspot.com',
    iosBundleId: 'com.example.weatherapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAs1oTVe-uIrotrsv2F4LJq6-IB8ou1vJ8',
    appId: '1:757880039105:web:089fb94e5328281361d640',
    messagingSenderId: '757880039105',
    projectId: 'weatherapp-223fc',
    authDomain: 'weatherapp-223fc.firebaseapp.com',
    storageBucket: 'weatherapp-223fc.appspot.com',
    measurementId: 'G-HPNYZT91W5',
  );
}
