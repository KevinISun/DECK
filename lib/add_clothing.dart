import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: appBar(),
              body: Center(
                child: Column(
                  children: [
                    Image.asset('assets/icon.png'),
                  ],
                ),
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
                  BottomNavigationBarItem(
                    icon: Icon(Icons.logout),
                    label: 'Sign Out',
                  ),
                ],
                selectedItemColor: const Color.fromARGB(255, 30, 187, 231),
                onTap: (index) {
                  if (index == 1) {
                    // Navigate to the page you want to show when "Add" is pressed
                    Navigator.pushNamed(context,
                        '/add'); // Replace '/add' with the route name of your add page
                  }
                },
              ),
            );
          },
        );
      },
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
