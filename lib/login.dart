import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  void _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/todo');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(64, 64, 64, 1),
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: Container(

        color: Color.fromRGBO(32, 32, 32, 1), // Background color for the entire screen
        padding: const EdgeInsets.all(16.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(

              decoration: BoxDecoration(
                color: Colors.white, // Background color for the TextField
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontSize: 20,
                  //  fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  border: InputBorder.none, // Remove the default border
                  contentPadding: EdgeInsets.all(10.0), // Adjust padding inside TextField
                ),
                style: TextStyle(
                  fontSize: 20,
                //  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16.0), // Add some space between the fields
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Background color for the TextField
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 20,
                 //   fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  border: InputBorder.none, // Remove the default border
                  contentPadding: EdgeInsets.all(10.0), // Adjust padding inside TextField
                ),
                obscureText: true,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: _login,

              child: const Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(102, 102, 255, 1.0), // Background color for the button
              ),

            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text(
                'Don\'t have an account? Sign up here.',
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
