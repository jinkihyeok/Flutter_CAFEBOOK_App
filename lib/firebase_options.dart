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
    apiKey: 'AIzaSyD6c5PW_qsbRbSOvxq30lN749gasZMnlZQ',
    appId: '1:212625524713:web:fd37b6b3a3b32ce9312d78',
    messagingSenderId: '212625524713',
    projectId: 'jin-caffe-app',
    authDomain: 'jin-caffe-app.firebaseapp.com',
    storageBucket: 'jin-caffe-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxDR1xkUTCo7YNYNGl-oyyVxj3_yTnq5w',
    appId: '1:212625524713:android:f22c58c91c9135f5312d78',
    messagingSenderId: '212625524713',
    projectId: 'jin-caffe-app',
    storageBucket: 'jin-caffe-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5qgn6vHM2rK8Ee0t_OKcbp5Q5r00YJLk',
    appId: '1:212625524713:ios:763c0af0776e0bf7312d78',
    messagingSenderId: '212625524713',
    projectId: 'jin-caffe-app',
    storageBucket: 'jin-caffe-app.appspot.com',
    iosClientId: '212625524713-apn5rs81549nitliosrp90cocrkn041u.apps.googleusercontent.com',
    iosBundleId: 'com.example.caffeApp',
  );
}
