import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:parking_lot/Models/user.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../Providers/user_provider.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

enum AuthMode { Signup, Login }

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int count = 0;
  UserOptions user = new UserOptions();
  var args;
  void didChangeDependencies() {
    args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{})
        as Map;
    super.didChangeDependencies();
    print(args['type']);
    if (args["type"] == "login") {
      user.fetchUser(args["userid"]);
    } else {
      user.addUser(args);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Scan"),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Icon(
                Icons.menu,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(args['userid'])
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData)
                  return new Text('Loading...');
                else {
                  count++;
                  if (count > 1 && count <= 2) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushNamed('parking', arguments: {
                          ...args,
                          'slot': snapshot.data.get('slot')
                        });
                      });
                    }
                  }
                }
                return SizedBox();
              },
            ),
            Container(
              child: Text("Welcome,",
                  style: GoogleFonts.bebasNeue(
                      textStyle: TextStyle(fontSize: 25))),
            ),
            Container(
              child: Text(args['email'],
                  style: GoogleFonts.bebasNeue(
                      textStyle: TextStyle(fontSize: 25))),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: QrImage(
                data: args["userid"],
                version: QrVersions.auto,
                size: 300,
                gapless: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
