import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(hintText: 'Enter email'),
        ),
        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(hintText: 'Enter Password'),
        ),
        TextButton(
          onPressed: () async {
            // await Firebase.initializeApp(
            //   options: DefaultFirebaseOptions.currentPlatform,
            // );

            final email = _email.text;
            final password = _password.text;

            try {
              final userCredential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password);
              // print("Login");
              //print(userCredential.toString());
              //print(FirebaseAuth.instance.currentUser);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                //print('User not found');
              } else if (e.code == 'wrong-password') {
                //  print('Wrong password');
              } else {
                //  print(e.code);
              }
            }
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
