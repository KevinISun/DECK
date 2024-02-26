import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google SignIn'),
      ),
      body: _user != null ? _userInfo() : _googleSignInButton(),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
          height: 50,
          child: SignInButton(
            Buttons.Google,
            text: "Sign in with Google",
            onPressed: _handleGoogleSignIn,
          )),
    );
  }

  Widget _userInfo() {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          const Text('User Information'),
          const SizedBox(height: 20),
          CircleAvatar(
            backgroundImage: NetworkImage(_user!.photoURL!),
            radius: 50,
          ),
          const SizedBox(height: 20),
          Text('Name: ${_user!.displayName}'),
          const SizedBox(height: 20),
          Text('Email: ${_user!.email}'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _auth.signOut();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _handleGoogleSignIn() async {
    try {
      print("here: handle google sign in function called");
      GoogleSignIn googleSignIn = GoogleSignIn();
      print("here: ${googleSignIn}");
      try {
        GoogleSignInAccount? account = await googleSignIn.signIn();
        print('here: Sign-in successful');
        print("here: Account: ${account}");
        if (account != null) {
          GoogleSignInAuthentication googleAuth = await account.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          UserCredential userCredential =
          await _auth.signInWithCredential(credential);
          setState(() {
            _user = userCredential.user;
          });
          print("here: User Name: ${_user!.displayName}");
        }
      } catch (e) {
        print('here: Error signing in: $e'); // Print any exceptions that occur during sign-in.
      }
      // GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      // _auth.signInWithProvider(_googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }
}
