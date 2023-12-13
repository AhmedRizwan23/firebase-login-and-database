import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/homepage.dart';
import 'package:get/route_manager.dart';

class notescreen extends StatefulWidget {
  const notescreen({super.key});

  @override
  State<notescreen> createState() => _notescreenState();
}

class _notescreenState extends State<notescreen> {
  TextEditingController notecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('edit notes'),
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: notecontroller
                ..text = Get.arguments["note"].toString(),
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("notes")
                      .doc(Get.arguments["docid"])
                      .update(
                    {
                      "note": notecontroller.text.trim(),
                    },
                  ).then((value) => {
                            Get.off(() => const homepage()),
                            log("note updated"),
                          });
                },
                child: const Text("Update"))
          ],
        ),
      ),
    );
  }
}
