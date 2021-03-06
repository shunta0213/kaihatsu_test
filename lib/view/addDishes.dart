import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaihatsudojo/model/addDishesData.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../const/genreList.dart';

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
    CollectionReference user = db.collection(uid);
    //
    return Scaffold(
      // 基本ここに書いていく
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: DropdownButton2(
                alignment: AlignmentDirectional.center,
                isExpanded: true,
                items: Genre.genre
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                        ),
                      ),
                    ).toList(),
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '文字を入力してください';
                  }
                  return null;
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '文字を入力してください';
                  }
                  return null;
                },
              ),
            ),
            TextButton(
              onPressed: () async {
                addDishes(context,
                    uid: uid,
                    dishName: _dishName!,
                    genre: _genre!,
                    notes: _notes!,
                    now: now);
              },
              child: const Icon(
                Icons.check_circle,
                size: 60,
              ),
            ),
          ],
        ),
      ),

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
