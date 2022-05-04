import 'package:flutter/cupertino.dart';

import '../view/authentication/singUp.dart';
import '../view/dishList.dart';
import '../view/top.dart';
import '../view/genreList/genrePage.dart';
import '../view/addDishes.dart';
import '../view/authentication/singIn.dart';
import 'images.dart';

class PageRoutes {
  static Map<String, Widget Function(BuildContext)> pageRoutes = <String, Widget Function(BuildContext)>{
    '/loginPage': (context) => const LoginPage(),
    '/signUpPage': (context) => const SignUpPage(),
    '/mainPage': (BuildContext context) => const TopPage(),
    '/addDishes': (BuildContext context) => const AddDishes(),
    '/viewPage': (BuildContext context) => const ViewPage(),
    '/cow': (BuildContext context) => ListPage(genre: '牛',icon: Images.cow),
    '/pig': (BuildContext context) => ListPage(genre: '豚',icon: Images.pig),
    '/chicken': (BuildContext context) => ListPage(genre: '鶏肉', icon: Images.chicken),
    '/fish' : (BuildContext context) => ListPage(genre: '魚', icon: Images.fish,),
    '/salad' : (BuildContext context) => ListPage(genre: 'サラダ', icon: Images.salad),
    '/soup' : (BuildContext context) => ListPage(genre: 'スープ', icon: Images.soup),
    '/noodle' :(BuildContext context) => ListPage(genre: '麺', icon: Images.noodle),
    '/others' : (BuildContext context) => ListPage(genre: 'その他', icon: Images.others,),
  };
}