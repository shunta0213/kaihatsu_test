import 'package:cloud_firestore/cloud_firestore.dart';

void deleteDish({uid, document}) async {
  await FirebaseFirestore.instance.collection(uid).doc(document.get('name')).delete();
}
