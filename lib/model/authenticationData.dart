import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/// Authentication まわりのデータ管理

class AuthenticationDataClass extends ChangeNotifier {

  /// Userの変更を通知するメソッド
  User? user;
  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }


  /// ErrorTextの変更を通知するメソッド
  void setErrorText(String errorText, String newErrorText) {
    errorText = newErrorText;
    notifyListeners();
  }

  /// obscureText の変更を通知するメソッド
  bool passwordVeil = true;
  void setPasswordVeil(){
    passwordVeil = !passwordVeil;
    notifyListeners();
  }

}
