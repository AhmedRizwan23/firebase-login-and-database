import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, Key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    bool passhide = true;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: 
              // Add an image for your logo
                width: 150,
                height: 150,
              ),
            ),
            const Text(
              'Welcome to Your App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                obscureText: passhide, // For password input
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffix: IconButton(
                        onPressed: () {
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
                        icon: Icon(
                          (passhide == true)
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ))),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add login functionality here
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}