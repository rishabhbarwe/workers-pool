import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'login_form.dart';
import 'signup_form.dart';
import 'style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Daily',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
      home: AuthenticationPage(),
    );
  }
}

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool _showLogin = true;

  void _toggleForm() {
    setState(() {
      _showLogin = !_showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _showLogin ? 'Work Daily' : 'Work Daily',
          style: AppStyles.appBarTitle,
        ),
        backgroundColor: AppStyles.appBarColor,
      ),
      body: Center(
        child: _showLogin ? LoginForm() : SignupForm(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.deepPurple,
          ),
          onPressed: _toggleForm,
          child: Text(_showLogin
              ? 'Don\'t have an account? Sign Up'
              : 'Already have an account? Login'),
        ),
      ),
    );
  }
}
