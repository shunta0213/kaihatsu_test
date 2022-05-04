import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int _currentIndex = 0;
  List<String> pages = ['/TopPage', '/viewPage'];

  @override
  Widget build(BuildContext context) {
    // For Firebase Auth and Firestore
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference userDishes = FirebaseFirestore.instance
        .collection(uid);

    // For Bottom Bar
    bool _currentIndexColor = true;
    setState(() {
      if (_currentIndex == 0) {
        _currentIndexColor = true;
      } else {
        _currentIndexColor = false;
      }
    });
    List<BottomNavigationBarItem> barItem = [
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
    ];
    // end

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final double deviceHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      // 基本はここに書いていく
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(today.toString()),
          FutureBuilder<QuerySnapshot>(
            future: userDishes.orderBy('date', descending: false).startAt(
                [Timestamp.fromDate(today)]).get(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong.');
              } else if (snapshot.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }

              return SizedBox(
                height: deviceHeight * 0.5,
                child: ListView(
                  children: snapshot.data!.docs.map((
                      DocumentSnapshot document) {
                    return ListTile(
                      title: Text(document.get('name')),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),

      // BottomBar部分
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          _currentIndex = index;
          Navigator.of(context).pushReplacementNamed(pages[_currentIndex]);
        },
        items: barItem,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/addDishes'),
      ),
    );
  }
}
