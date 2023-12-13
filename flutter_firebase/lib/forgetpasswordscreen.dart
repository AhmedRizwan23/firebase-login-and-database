// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/loginpage.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

class forgetpasswordscreen extends StatefulWidget {
  const forgetpasswordscreen({super.key});

  @override
  State<forgetpasswordscreen> createState() => _forgetpasswordscreenState();
}

class _forgetpasswordscreenState extends State<forgetpasswordscreen> {
  var passhide = true;
  TextEditingController forgetpasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('password recovery'),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 200,
                alignment: Alignment.center,
                child: Lottie.asset("assets/animation_lka1h0dt.json")),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: forgetpasswordcontroller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  var resetpass = forgetpasswordcontroller.text.trim();
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: resetpass)
                        .then((value) => {
                              log("email send"),
                              Get.off(() => const Loginpage())
                            });
                  } on FirebaseAuthException catch (e) {
                    log("error $e");
                  }
                },
                child: const Text("Forget Password")),
          ],
        ),
      ),
    );
  }
}
