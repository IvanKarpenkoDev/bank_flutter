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
    apiKey: 'AIzaSyBPcOkDJtihgtfLBy07zJuJHt6M4skEBpo',
    appId: '1:245355388581:web:834eefc690138e1896374c',
    messagingSenderId: '245355388581',
    projectId: 'bank-ee7fd',
    authDomain: 'bank-ee7fd.firebaseapp.com',
    storageBucket: 'bank-ee7fd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJ9XMfnU468eeLq5A3bsi1myGZx4Hthmc',
    appId: '1:245355388581:android:60189449273f575c96374c',
    messagingSenderId: '245355388581',
    projectId: 'bank-ee7fd',
    storageBucket: 'bank-ee7fd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLeqjl6oyAHyE524HBeurM23SS1540KPc',
    appId: '1:245355388581:ios:f58b91cc07a17fa696374c',
    messagingSenderId: '245355388581',
    projectId: 'bank-ee7fd',
    storageBucket: 'bank-ee7fd.appspot.com',
    iosClientId: '245355388581-4k4pd0v61g5ouccf7c7au2se9qso0p1u.apps.googleusercontent.com',
    iosBundleId: 'com.example.bankFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLeqjl6oyAHyE524HBeurM23SS1540KPc',
    appId: '1:245355388581:ios:f58b91cc07a17fa696374c',
    messagingSenderId: '245355388581',
    projectId: 'bank-ee7fd',
    storageBucket: 'bank-ee7fd.appspot.com',
    iosClientId: '245355388581-4k4pd0v61g5ouccf7c7au2se9qso0p1u.apps.googleusercontent.com',
    iosBundleId: 'com.example.bankFlutter',
  );
}
