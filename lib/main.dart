import 'package:deck_project/auth/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:deck_project/pages/login_page.dart';
import 'package:deck_project/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( const MyApp() );
}


