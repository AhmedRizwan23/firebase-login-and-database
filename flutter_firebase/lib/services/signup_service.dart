import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/loginpage.dart';
import 'package:get/get.dart';

signupuser(
  String username,
  String userphone,
  String useremail,
  String userpassword,
) async {
  try {
    User? userid = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      'username': username,
      'userphone': userphone,
      'useremail': useremail,
      'created at': DateTime.now(),
      'userid': userid.uid,
    }).then((value) => {
          log("data added"),
          FirebaseAuth.instance.signOut(),
          Get.to(() => const Loginpage())
        });
  } on FirebaseAuthException catch (e) {
    log("error $e");
  }
}
