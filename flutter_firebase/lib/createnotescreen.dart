import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/homepage.dart';
import 'package:get/route_manager.dart';

class createnotescreen extends StatefulWidget {
  const createnotescreen({super.key});

  @override
  State<createnotescreen> createState() => _createnotescreenState();
}

class _createnotescreenState extends State<createnotescreen> {
  TextEditingController notecontroller = TextEditingController();
  User? userid = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('create note'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                maxLines: null,
                controller: notecontroller,
                decoration: const InputDecoration(
                  hintText: "add note",
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  var usernote = notecontroller.text.trim();
                  if (usernote != "") {
                    try {
                      await FirebaseFirestore.instance
                          .collection("notes")
                          .doc()
                          .set({
                        "created at ": DateTime.now(),
                        "note": usernote,
                        "userid": userid?.uid,
                      }).then((value) => {
                                Get.off(() => const homepage()),
                                log("note created")
                              });
                    } catch (e) {
                      log("Error $e");
                    }
                  }
                },
                child: const Text("Add note"))
          ],
        ),
      ),
    );
  }
}
