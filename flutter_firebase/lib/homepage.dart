// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/createnotescreen.dart';
import 'package:flutter_firebase/editnotescreen.dart';
import 'package:flutter_firebase/loginpage.dart';
import 'package:get/route_manager.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  User? userid = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.off(() => const Loginpage());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("notes")
            .where("userid", isEqualTo: userid?.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CupertinoActivityIndicator(
              color: Colors.amber,
            ));
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("no data found"));
          }

          if (snapshot != null && snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var note = snapshot.data!.docs[index]["note"];
                var id = snapshot.data!.docs[index]["userid"];
                var docid = snapshot.data!.docs[index].id;
                return Card(
                  child: ListTile(
                    title: Text(note),
                    subtitle: Text(id),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.to(() => const notescreen(),
                                  arguments: {"note": note, "docid": docid});
                            },
                            child: const Icon(Icons.edit)),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection("notes")
                                  .doc(docid)
                                  .delete()
                                  .then((value) => {log("note deleted")});
                            },
                            child: const Icon(Icons.delete)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
              child: CupertinoActivityIndicator(color: Colors.deepOrange));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const createnotescreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
