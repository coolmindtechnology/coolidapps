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
    apiKey: 'AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk',
    appId: '1:460609975158:android:4368eef2b9acf8efb38057',
    messagingSenderId: '460609975158',
    projectId: 'my-cool-id',
    storageBucket: 'my-cool-id.firebaseio.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk',
    appId: '1:460609975158:android:4368eef2b9acf8efb38057',
    messagingSenderId: '460609975158',
    projectId: 'my-cool-id',
    storageBucket: 'my-cool-id.firebaseio.com',
    authDomain: 'cool-app-641a1.firebaseapp.com',
    measurementId: 'G-2JY8LGXM4M',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk',
    appId: '1:460609975158:android:4368eef2b9acf8efb38057',
    messagingSenderId: '460609975158',
    projectId: 'my-cool-id',
    storageBucket: 'my-cool-id.firebaseio.com',
    iosBundleId: 'mycool.tech.app',
  );
}
