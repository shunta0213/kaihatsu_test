import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListPage extends StatelessWidget {
  final String? genre;
  final Widget? icon;

  const ListPage({
    required this.genre,
    required this.icon,
    Key? key,
  }) : super(key: key);

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
              child: icon,
            ),
          ),
          FutureBuilder<QuerySnapshot>(
            future:
                user.collection(genre!).orderBy('date', descending: true).get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
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

                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        tileColor: Colors.white,
                        leading: const Icon(
                          Icons.circle,
                          size: 10,
                        ),
                        title: Text(document.get('name')),
                        subtitle: Column(children: [
                          Text(DateFormat('作成日 : yyyy/MM/dd')
                              .format(document.get('date').toDate())),
                          Text(document.get('notes') ?? ''),
                        ]),
                        trailing: TextButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('User')
                                  .doc(uid)
                                  .collection(genre!)
                                  .doc(document.get('name'))
                                  .delete();
                            },
                            child: const Icon(Icons.delete)),
                        dense: true,
                        contentPadding: const EdgeInsets.all(8),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          child: const Icon(Icons.clear),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
