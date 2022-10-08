import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/login_view.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const Homepage(),
  ));
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                // FirebaseAuth.instance.authStateChanges().listen((User? user) {
                //   if (user != null) {
                //     print("user.uid");
                //     print(user.uid);
                //   } else {
                //     print("user.uid is null");
                //   }
                // });

                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  ///  if (user?.emailVerified ?? false) {
                  if (user.emailVerified) {
                    print('you are verified');
                  } else {
                    return const VerifyEmailView();
                  }
                } else {
                  return const LoginView();
                }

                return const Text('dones');

              //break;
              default:
                return const Text('Loading...');
            }
          }),
    );
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Please verify email'),
        TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
            print("send email");
          },
          child: const Text("Send email verification"),
        ),
      ],
    );
  }
}
