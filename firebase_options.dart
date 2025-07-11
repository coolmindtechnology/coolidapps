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
    apiKey: 'AIzaSyCgvBMk1EUGk9ujLA0p8lM2vPPOg8ZrolE',
    appId: '1:252404014317:web:b390ab4aea6fcd035f80e4',
    messagingSenderId: '252404014317',
    projectId: 'cool-app-641a1',
    authDomain: 'cool-app-641a1.firebaseapp.com',
    storageBucket: 'cool-app-641a1.appspot.com',
    measurementId: 'G-2JY8LGXM4M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCT9ENmxJqn8L4kKKy7bEkm8YlUb6zgyUo',
    appId: '1:252404014317:android:517741646345f6175f80e4',
    messagingSenderId: '252404014317',
    projectId: 'cool-app-641a1',
    storageBucket: 'cool-app-641a1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBC6IyF40XXfTxyjrHQ4NLNDXQQ8hgK1gQ',
    appId: '1:252404014317:ios:32cfa8eacbe652065f80e4',
    messagingSenderId: '252404014317',
    projectId: 'cool-app-641a1',
    storageBucket: 'cool-app-641a1.appspot.com',
    iosBundleId: 'com.example.coolApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBC6IyF40XXfTxyjrHQ4NLNDXQQ8hgK1gQ',
    appId: '1:252404014317:ios:11e822dacb7ff71f5f80e4',
    messagingSenderId: '252404014317',
    projectId: 'cool-app-641a1',
    storageBucket: 'cool-app-641a1.appspot.com',
    iosBundleId: 'com.example.coolApp.RunnerTests',
  );
}
