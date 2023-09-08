// import 'package:flutter/material.dart';

// class LoginSignUpPage extends StatefulWidget {
//   @override
//   _LoginSignUpPageState createState() => _LoginSignUpPageState();
// }

// class _LoginSignUpPageState extends State<LoginSignUpPage> {
//   bool _isLoginMode = true; // Set initial mode to login

//   void _toggleMode() {
//     setState(() {
//       _isLoginMode = !_isLoginMode;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_isLoginMode ? 'Login' : 'Sign Up'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement login or sign-up logic here
//               },
//               child: Text(_isLoginMode ? 'Login' : 'Sign Up'),
//             ),
//             TextButton(
//               onPressed: _toggleMode,
//               child: Text(_isLoginMode
//                   ? 'Don\'t have an account? Sign Up'
//                   : 'Already have an account? Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
