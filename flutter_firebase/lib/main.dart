import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/firebase_options.dart';
import 'package:flutter_firebase/homepage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'loginpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    log("user id ${user?.uid.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'login with firebase',
      debugShowCheckedModeBanner: false,
      home: user != null ? const homepage() : const Loginpage(),
    );
  }
}
