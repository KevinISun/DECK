import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: Column( 
          children: [
            Image.asset('assets/dash.png')
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          // sign out button
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Sign Out',
            
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 30, 187, 231),
      )
      
    );
  }
  AppBar appBar() {  
    return AppBar(
      title: const Text('Welcome to DECK!'),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: 'Itim',
      ),
      backgroundColor: const Color.fromARGB(255, 30, 187, 231),
      elevation: 0.0,
    );
  }
  
      
}