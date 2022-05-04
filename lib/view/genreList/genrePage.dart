import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaihatsudojo/view/genreList/genreButton.dart';

import '../../const/images.dart';

// import 'package:kaihatsudojo/components/icons/test_icon_icons.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // For BottomBar
    int _currentIndex = 1;
    List<String> pages = ['/mainPage', '/viewPage'];
    bool _currentIndexColor = true;
    setState(() {
      if (_currentIndex == 0) {
        _currentIndexColor = true;
      } else {
        _currentIndexColor = false;
      }
    });
    //end

    double _sizedBoxHeight = 120;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenreButton(genre: 'cow',image: Images.cow, height: _sizedBoxHeight),
                GenreButton(genre: 'pig',image: Images.pig, height: _sizedBoxHeight)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenreButton(genre: 'chicken',image: Images.chicken, height: _sizedBoxHeight),
                GenreButton(genre: 'fish',image: Images.fish, height: _sizedBoxHeight),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenreButton(genre: 'salad',image: Images.salad, height: _sizedBoxHeight),
                GenreButton(genre: 'soup',image: Images.soup, height: _sizedBoxHeight),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenreButton(genre: 'noodle',image: Images.noodle, height: _sizedBoxHeight),
                GenreButton(genre: 'others',image: Images.others, height: _sizedBoxHeight),
              ],
            ),
          ],
        ),
      ),

      // BottomBar 部分
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          _currentIndex = index;
          Navigator.of(context).pushReplacementNamed(pages[_currentIndex]);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              label: 'home',
              icon: Icon(
                Icons.home,
                size: 30,
                color: _currentIndexColor ? Colors.orange : Colors.black,
              )),
          BottomNavigationBarItem(
              label: 'list',
              icon: Icon(
                Icons.list_alt_rounded,
                size: 30,
                color: !_currentIndexColor ? Colors.orange : Colors.black,
              ))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/addDishes'),
      ),
    );
  }
}
