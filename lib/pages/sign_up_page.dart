import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:euas_library_flutter_application/services/book_list.dart';
import 'package:euas_library_flutter_application/services/book_list.dart';
import 'package:euas_library_flutter_application/controller/auth_service.dart';
import 'package:euas_library_flutter_application/pages/varify_email_page.dart';


class SignUpPage extends StatelessWidget {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(fontFamily: 'Roboto')),
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
                    Pattern pattern =
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                    RegExp regex = RegExp(pattern.toString());
                    if (!regex.hasMatch(value)) {
                      return 'Enter a valid email address';
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
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await authService.signUpWithEmailAndPassword(
                          emailController.text, passwordController.text)
                          .then((result) {
                        if (result != null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return VerifyEmailPage();
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
                  child: Text('Sign Up with Email'),
                ),
                SizedBox(height: 20),
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
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


// class SignUpPage extends StatelessWidget {
//   final AuthService authService = AuthService();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up', style: TextStyle(fontFamily: 'Roboto')),
//         backgroundColor: Colors.yellow.shade800,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     labelStyle: TextStyle(color: Colors.yellow.shade800),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.yellow.shade800),
//                     ),
//                   ),
//                   validator: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email.';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     labelStyle: TextStyle(color: Colors.yellow.shade800),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.yellow.shade800),
//                     ),
//                   ),
//                   obscureText: true,
//                   validator: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password.';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       await authService.signUpWithEmailAndPassword(
//                           emailController.text, passwordController.text)
//                           .then((result) {
//                         if (result != null) {
//                           Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return VerifyEmailPage();
//                               },
//                             ),
//                           );
//                         }
//                       });
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.yellow.shade800,
//                     onPrimary: Colors.white,
//                   ),
//                   child: Text('Sign Up with Email'),
//                 ),
//                 SizedBox(height: 20),
//                 SignInButton(
//                   Buttons.Google,
//                   text: "Sign up with Google",
//                   onPressed: () async {
//                     await authService.signInWithGoogle().then((result) {
//                       if (result != null) {
//                         Navigator.of(context).pushReplacement(
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return BookList();
//                             },
//                           ),
//                         );
//                       }
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }