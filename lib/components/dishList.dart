import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListPage extends StatelessWidget {
  final String? genre;

  ListPage({this.genre, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final String uid = auth.currentUser!.uid;
    final DocumentReference user = db.collection('User').doc(uid);
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              flex: 1,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Hello',
                  ))),
          FutureBuilder<QuerySnapshot>(
            future: user.collection(genre!).orderBy('date', descending: true).get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

              if(snapshot.hasError){
                return const Text('Something went wrong');
              } else if (snapshot.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }

              return Flexible(
                flex: 8,
                child: SizedBox(
                  height: deviceHeight * 0.7,
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      DateTime time = document.get('date').toDate();
                      DateFormat dateFormat = DateFormat('[MM/dd]');
                      String date = dateFormat.format(time);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tileColor: Colors.white,
                          leading: const Icon(
                            Icons.circle,
                            size: 10,
                          ),
                          title: Text(document.get('name')),
                          subtitle: Text(date + document.get('notes')),
                          dense: true,
                          contentPadding: const EdgeInsets.all(8),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          child: const Icon(Icons.arrow_left_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
