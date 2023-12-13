// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/loginpage.dart';
import 'package:flutter_firebase/services/signup_service.dart';
import 'package:lottie/lottie.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<Signupscreen> {
  var passhide = true;
  TextEditingController Usernamecontroller = TextEditingController();
  TextEditingController Userphonecontroller = TextEditingController();
  TextEditingController Useremailcontroller = TextEditingController();
  TextEditingController Userpasswordcontroller = TextEditingController();
  User? currentuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('signup page'),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 200,
                alignment: Alignment.center,
                child: Lottie.asset("assets/animation_lka04qs1.json")),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: Usernamecontroller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2),
                  hintText: "Username",
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: Userphonecontroller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Phone",
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: Useremailcontroller,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: Userpasswordcontroller,
                obscureText: passhide,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  suffix: IconButton(
                    onPressed: () {
                      // setState(() {
                      //   //ternary operator
                      //   (passHide== true) ? passHide = false : passHide = true;
                      // });
                      if (passhide == true) {
                        setState(() {
                          passhide = false;
                        });
                      } else {
                        setState(() {
                          passhide = true;
                        });
                      }
                    },
                    icon: Icon((passhide == true)
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  hintText: "Password",
                  enabledBorder: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                var username = Usernamecontroller.text.trim();
                var userphone = Userphonecontroller.text.trim();
                var useremail = Useremailcontroller.text.trim();
                var userpassword = Userpasswordcontroller.text.trim();
                await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: useremail, password: userpassword)
                    .then((value) => {
                          log("user created"),
                          signupuser(
                          username,
                            userphone,
                            useremail,
                            userpassword,
                          )
                        });
              },
              child: const Text("Sign up"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Loginpage()));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child:
                    const Card(child: Text("Already have an account signin")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
