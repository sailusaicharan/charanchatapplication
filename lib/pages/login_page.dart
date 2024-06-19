import 'package:charan_chat_application/components/my_button.dart';
import 'package:charan_chat_application/components/my_text_field.dart';
import 'package:charan_chat_application/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign in user
  void signIn() async {
    // get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            // Logo
            SafeArea(
              child: Center(
                child: Icon(
                  Icons.message,
                  size: 100,
                  color: Colors.grey[800],
                ),
              ),
            ),

            const SizedBox(height: 50),
            // Welcome back messsage
            const Text(
              "Welcome back you 've been missed!",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),
            // Email textfeild
            MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false),

            const SizedBox(height: 10),

            // Password textfeild
            MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true),

            const SizedBox(height: 25),

            // Sign in button
            MyButton(onTap: signIn, text: "Sign In"),

            const SizedBox(height: 50),

            // Not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not a member ?"),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    "Register Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
