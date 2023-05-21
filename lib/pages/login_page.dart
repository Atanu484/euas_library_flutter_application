import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:euas_library_flutter_application/services/book_list.dart';
import 'package:euas_library_flutter_application/controller/auth_service.dart';

class LoginPage extends StatelessWidget {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(fontFamily: 'Roboto')),
        backgroundColor: Colors.yellow.shade800,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.yellow.shade800),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow.shade800),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.yellow.shade800),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow.shade800),
                    ),
                  ),
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await authService.signInWithEmailAndPassword(
                          emailController.text, passwordController.text)
                          .then((result) {
                        if (result != null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return BookList();
                              },
                            ),
                          );
                        }
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow.shade800,
                    onPrimary: Colors.white,
                  ),
                  child: Text('Login with Email'),
                ),
                SizedBox(height: 20),
                SignInButton(
                  Buttons.Google,
                  text: "Login with Google",
                  onPressed: () async {
                    await authService.signInWithGoogle().then((result) {
                      if (result != null) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) {
                              return BookList();
                            },
                          ),
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
