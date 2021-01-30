import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = '';

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User.fromData(user.uid) : null;
  }

  Future<String> currentUserIdFromAuth() async {
    final FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      final String uid = user.uid;
      if (uid.isNotEmpty) return uid;
    }
    return "";
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future<void> verifyPhone(String userPhoneNumber,
      Function smsUIUpdate, Function updateUser,{Function phoneNumberNotOkay}) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {

      signInWithPhoneNumber(authResult, '', updateUser);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print('${authException.message}');
      if(phoneNumberNotOkay!=null){
        phoneNumberNotOkay(authException.message);
      }

    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      smsUIUpdate(
          false); //False means that the the sms has just been sent wait for 50 seconds and start countdown
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String varId) {
      this.verificationId = varId;
      smsUIUpdate(true); //True means show the resend button
    };
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: userPhoneNumber,
          timeout: const Duration(seconds: 45),
          verificationCompleted: verified,
          verificationFailed: verificationFailed,
          codeSent: smsSent,
          codeAutoRetrievalTimeout: autoTimeout);

      Fluttertoast.showToast(
          msg: "The code is sent to phone number",
          toastLength: Toast.LENGTH_SHORT,

          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
    on Exception catch (e){
      print(e);
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

    }
  }

  Future<bool> signInWithPhoneNumber(AuthCredential credential,
      String enteredCode, Function updateUser) async {
    if (credential == null)
      if (enteredCode != null) {
        credential = PhoneAuthProvider.getCredential(
            verificationId: verificationId, smsCode: enteredCode);
      }
      else {
        return false;
      }
    try {
      bool isValid = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        if (value != null) {
          updateUser(value.user.uid);
          return true;
        } else {
          return false;
        }
      });
      if (!isValid) return false;
      return true;
    }
    on Exception{
      return false;
    }
  }

// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
