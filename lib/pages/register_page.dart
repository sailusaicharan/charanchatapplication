import 'package:charan_chat_application/components/my_button.dart';
import 'package:charan_chat_application/components/my_text_field.dart';
import 'package:charan_chat_application/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign up user
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match!"),
        ),
      );
      return;
    }
    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpwithEmailandPassword(
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

            // Create account message
            const Text(
              "Let's create an account for you!",
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

            const SizedBox(height: 10),

            MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true),

            const SizedBox(height: 25),

            // Sign in button
            MyButton(onTap: signUp, text: "Sign up"),

            const SizedBox(height: 50),

            // Not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a member ? "),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Login Now",
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
