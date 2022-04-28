import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:kaihatsudojo/pages/top.dart';
import 'package:kaihatsudojo/pages/addDishes.dart';
import 'package:kaihatsudojo/pages/viewPage.dart';
import 'package:kaihatsudojo/pages/authentication.dart';
import 'package:kaihatsudojo/components/dishList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class UserState extends ChangeNotifier {
  User? user;

  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final UserState userState = UserState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserState>(
      create: (context) => UserState(),
      child: MaterialApp(
        // for debug
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        routes: {
          '/loginPage': (context) => const LoginPage(),
          '/signUpPage': (context) => const SignUpPage(),
          '/mainPage': (BuildContext context) => const TopPage(),
          '/addDishes': (BuildContext context) => const AddDishes(),
          '/viewPage': (BuildContext context) => const ViewPage(),

          '/chicken' : (BuildContext context) => ListPage(genre: '鶏肉'),
          '/pig' : (BuildContext context) => ListPage(genre: '豚'),
          '/cow' :(BuildContext context) => ListPage(genre: '牛',)
        },
        home: const LoginPage(),
      ),
    );
  }
}
