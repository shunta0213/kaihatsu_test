import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:kaihatsudojo/view/pages/top.dart';
import 'package:kaihatsudojo/view/pages/addDishes.dart';
import 'package:kaihatsudojo/view/pages/viewPage.dart';
import 'package:kaihatsudojo/view/pages/authentication.dart';
import 'package:kaihatsudojo/components/dishList.dart';
import 'package:kaihatsudojo/model/authenticationData.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AuthenticationDataClass userState = AuthenticationDataClass();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationDataClass(),
      child: MaterialApp(
        // for debug
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        routes: {
          '/loginPage': (context) => LoginPage(),
          '/signUpPage': (context) => const SignUpPage(),
          '/mainPage': (BuildContext context) => const TopPage(),
          '/addDishes': (BuildContext context) => const AddDishes(),
          '/viewPage': (BuildContext context) => const ViewPage(),

          '/chicken': (BuildContext context) => ListPage(
              genre: '鶏肉', icon: Image.asset('assets/images/logo_3.png')
          ),
          '/pig': (BuildContext context) => ListPage(
                genre: '豚',
                icon: Image.asset('assets/images/logo_2.png'),
              ),
          '/cow': (BuildContext context) => ListPage(
                genre: '牛',
                icon: Image.asset('assets/images/logo_1.png'),
              ),
        },
        home: LoginPage(),
      ),
    );
  }
}
