import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider {
  String? email;
  int bill = 0;
  Timestamp? entry;
  Timestamp? exit;
  String? regno;
  String? slot;
}

class UserOptions {
  UserProvider? u;
  void addUser(dynamic args) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(args['userid'])
        .set({"email": args['email']});
  }

  Future<List> getSlots() async {
    List lst = [];
    var d =
        await FirebaseFirestore.instance.collection("LOT").doc("Lot1").get();
    lst = d.data()['slots'];
    return lst;
  }

  void fetchUser(String uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        print(documentSnapshot.data());
      }
    });
  }
}
