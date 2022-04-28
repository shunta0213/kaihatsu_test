import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddDishes extends StatefulWidget {
  const AddDishes({Key? key}) : super(key: key);

  @override
  State<AddDishes> createState() => _AddDishesState();
}


class _AddDishesState extends State<AddDishes> {
  // For FireStore
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  String? _dishName;
  String? _genre;
  String? _notes;
  // Get date
  DateTime now = DateTime.now();
  DateFormat formattedDate = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    // For Firestore
    final uid = auth.currentUser!.uid;
    DocumentReference user = db.collection('User').doc(uid);
    Future<void> addDishes() {
      return user.collection(_genre!).doc(_dishName).set({
        'name': _dishName,
        'genre': _genre,
        'notes': _notes,
        'date': now,
      }).catchError((error) => print('error : $error'));
    }

    return Scaffold(
      // 基本ここに書いていく
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: DropdownButton(
                alignment: AlignmentDirectional.center,
                isExpanded: true,
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    child: Text('牛'),
                    value: '牛',
                  ),
                  DropdownMenuItem(
                    child: Text('鶏肉'),
                    value: '鶏肉',
                  ),
                  DropdownMenuItem(
                    child: Text('豚'),
                    value: '豚',
                  ),
                ],
                value: _genre,
                onChanged: (String? value) {
                  setState(() {
                    _genre = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'メニュー名',
                  labelText: 'メニュー名',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? value) {
                  _dishName = value;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'メモ',
                  labelText: 'メモ',
                  border: OutlineInputBorder(),
                ),
                minLines: 3,
                maxLines: 8,
                onChanged: (String? value) {
                  _notes = value;
                },
              ),
            ),
            TextButton(
              onPressed: addDishes,
              child: const Icon(
                Icons.check_circle,
                size: 40,
              ),
            ),
          ],
        ),
      ),

      // Xボタン
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          child: const Icon(Icons.clear),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
