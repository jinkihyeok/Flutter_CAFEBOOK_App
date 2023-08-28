import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;

  User? get user => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithEmail(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  var acs = ActionCodeSettings(
    url: "https://caffeapp.page.link",
    handleCodeInApp: true,
    iOSBundleId: "com.example.caffeApp",
    androidPackageName: "com.example.caffe_app",
    androidInstallApp: true,
    androidMinimumVersion: "16",
  );

  Future<void> sendSignInLink(String email) async {
    try {
      await _firebaseAuth.sendSignInLinkToEmail(email: email, actionCodeSettings: acs);
      print('Successfully sent email verification');
    } catch (error) {
      if (error is FirebaseAuthException) {
        print('Error Code: ${error.code}');
        print('Error Message: ${error.message}');
      } else {
        print('An unexpected error occurred: $error');
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

final authRepo = Provider(
  (ref) => AuthenticationRepository(),
);

final authState = StreamProvider(
  (ref) => ref.watch(authRepo).authStateChanges(),
);
