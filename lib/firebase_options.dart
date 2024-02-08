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
    apiKey: 'AIzaSyD2f8RXLF7SVksNtGZ2YcIbcDSlL4RLgPw',
    appId: '1:968941252633:web:a84733a7fd2cca49c6ba88',
    messagingSenderId: '968941252633',
    projectId: 'deck-181fe',
    authDomain: 'deck-181fe.firebaseapp.com',
    storageBucket: 'deck-181fe.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDlbB5WUjJwoiSwRELYCY_hVVIhC5sxTp4',
    appId: '1:968941252633:android:716ba33d5f72fb67c6ba88',
    messagingSenderId: '968941252633',
    projectId: 'deck-181fe',
    storageBucket: 'deck-181fe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDCQVyWXIaQE7C5AsuyOq8KzZsIdNEBOjQ',
    appId: '1:968941252633:ios:4c6141c484a34500c6ba88',
    messagingSenderId: '968941252633',
    projectId: 'deck-181fe',
    storageBucket: 'deck-181fe.appspot.com',
    iosBundleId: 'com.example.deckProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDCQVyWXIaQE7C5AsuyOq8KzZsIdNEBOjQ',
    appId: '1:968941252633:ios:c3d48c2d4c4425c0c6ba88',
    messagingSenderId: '968941252633',
    projectId: 'deck-181fe',
    storageBucket: 'deck-181fe.appspot.com',
    iosBundleId: 'com.example.deckProject.RunnerTests',
  );
}
