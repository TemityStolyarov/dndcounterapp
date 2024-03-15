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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD4xlPB2gH2QvAstmeIUtZKBPhGCiq6EpI',
    appId: '1:596696137075:web:dead9d31c8bfd7608e9906',
    messagingSenderId: '596696137075',
    projectId: 'crit-dnd',
    authDomain: 'crit-dnd.firebaseapp.com',
    databaseURL: 'https://crit-dnd-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'crit-dnd.appspot.com',
    measurementId: 'G-XK3SKELBTE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfBD1dipzCRXYraD0nM05mAX3BUL3djpc',
    appId: '1:596696137075:android:a0e6958662208f008e9906',
    messagingSenderId: '596696137075',
    projectId: 'crit-dnd',
    databaseURL: 'https://crit-dnd-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'crit-dnd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCm7j0f3GFpvpSVpdOdSW43iNz6VEZ50oE',
    appId: '1:596696137075:ios:bda8c1d1dbd869338e9906',
    messagingSenderId: '596696137075',
    projectId: 'crit-dnd',
    databaseURL: 'https://crit-dnd-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'crit-dnd.appspot.com',
    iosBundleId: 'com.example.dndcounterapp',
  );
}
