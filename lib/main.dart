import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/views/login_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const RegisterView(),
  ));
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration:
                          const InputDecoration(hintText: 'Enter email'),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration:
                          const InputDecoration(hintText: 'Enter Password'),
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
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                          debugPrint(userCredential.toString());
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('weak password');
                          } else if (e.code == 'email-already-in-use') {
                            print('email is in use.');
                          } else if (e.code == 'invalid-email') {
                            print('invalid email.');
                          } else {
                            print(e.code);
                          }
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ],
                );
              // break;
              default:
                return const Text('Loading...');
            }
          }),
    );
  }
}
