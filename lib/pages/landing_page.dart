import 'package:flutter/material.dart';
import 'package:euas_library_flutter_application/main.dart';
import 'package:euas_library_flutter_application/pages/login_page.dart';
import 'package:euas_library_flutter_application/pages/landing_page.dart';
import 'package:euas_library_flutter_application/pages/sign_up_page.dart';
import 'package:euas_library_flutter_application/controller/auth_service.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        title: Text('Welcome to EUAS Library', style: TextStyle(color: Colors.yellow.shade800)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Please login or sign up to continue',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.yellow.shade800),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50.0),
              Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  child: Text('Login', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow.shade800,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                height: 60,
                child: OutlinedButton(
                  child: Text('Sign Up', style: TextStyle(fontSize: 20, color: Colors.yellow.shade800)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.yellow.shade800, width: 2),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}