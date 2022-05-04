import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

    ButtonStyle buttonStyle () {
      return ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        fixedSize: Size(_sizedBoxHeight-12, _sizedBoxHeight-12),
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      );
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: SizedBox(
                    height: _sizedBoxHeight,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pushNamed('/cow'),
                      child: Image.asset('assets/images/logo_1.png'),
                      style: buttonStyle(),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: SizedBox(
                    height: _sizedBoxHeight,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pushNamed('/pig'),
                      child: Image.asset('assets/images/logo_2.png'),
                      style: buttonStyle(),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: SizedBox(
                    height: _sizedBoxHeight,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pushNamed('/chicken'),
                      child: Image.asset('assets/images/logo_3.png'),
                      style: buttonStyle(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: SizedBox(
                    height: _sizedBoxHeight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Image.asset('assets/images/logo_4.png'),
                      style: buttonStyle(),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: SizedBox(
                    height: _sizedBoxHeight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Image.asset('assets/images/logo_5.png'),
                      style: buttonStyle()
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: SizedBox(
                    height: _sizedBoxHeight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child:Image.asset('assets/images/logo_6.png') ,
                      style: buttonStyle()
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: SizedBox(
                    height: _sizedBoxHeight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Image.asset('assets/images/logo_7.png'),
                      style: buttonStyle()
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: SizedBox(
                    height: _sizedBoxHeight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Image.asset('assets/images/logo_8.png'),
                      style: buttonStyle()
                    ),
                  ),
                )
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
