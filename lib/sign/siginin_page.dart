import 'package:flutter/material.dart';
import 'package:meditationapp/providers/auth_proider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class SigninPage extends StatelessWidget {
  SigninPage({Key? key}) : super(key: key);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Sign In"),
            TextField(
              decoration: const InputDecoration(hintText: 'Username'),
              controller: usernameController,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Password'),
              controller: passwordController,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                var result =
                    await Provider.of<AuthProvider>(context, listen: false)
                        .signin(
                  username: usernameController.text,
                  password: passwordController.text,
                );

                if (result) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("You are Signed in")),
                  );
                  context.go('/home');
                }
              },
              child: const Text("Sign In"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/signup');
              },
              child: const Text("Sign up"),
            )
          ],
        ),
      ),
    );
  }
}
