import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final String uid = auth.currentUser!.uid;
    final DocumentReference user = db.collection('User').doc(uid);

    return Scaffold(
      backgroundColor: Colors.white70,
      body: StreamBuilder<QuerySnapshot>(
          stream: user.collection('鶏肉').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                DateTime time = document.get('date').toDate();
                DateFormat dateFormat = DateFormat('[MM/dd]');
                String date = dateFormat.format(time);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.white,
                    leading: const Icon(Icons.circle, size: 10,),
                    title: Text(document.get('name')),
                    subtitle: Text(date + document.get('notes')),
                    dense: true,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                );
              }).toList(),
            );
          },
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_left_outlined),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
