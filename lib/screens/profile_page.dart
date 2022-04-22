import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:csi464_lab6/models/models.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(snapshot.data.toString());
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

//TODO: For future use
  Future<AppUser> getProfileInfo() async {
    return await users.doc(_auth.currentUser!.uid)
        .withConverter<AppUser>(
          fromFirestore: (snapshots, _) => AppUser.fromJson(snapshots.data()!),
          toFirestore: (appUser, _) => appUser.toJson(),
        )
        .get()
        .then((value) {
      return AppUser.fromJson(value.data()!.toJson());
    });
  }

  Future<String?> getCurrentUser() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    return currentUser!.email;
  }
}
