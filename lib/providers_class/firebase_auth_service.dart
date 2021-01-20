import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rokit/data_model/firebaseUser_model.dart';
import 'package:provider/provider.dart';

enum PhoneLoginState { init, authVerified, authFailed, codeSent, codeAutoRetrievalTimeout }


class FirebaseAuthService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  PhoneLoginState phoneLoginState;

  FirebaseUserModel _userFromFirebase(User user) {


    return user == null ? null
        : FirebaseUserModel(uid: user.uid, displayName: user.displayName, phoneNumber: user.phoneNumber, email: user.email);
  }

  void changePhoneAuthState(PhoneLoginState state) {
    phoneLoginState = state;
    notifyListeners();
  }

  Stream<FirebaseUserModel> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}