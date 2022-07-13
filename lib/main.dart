import 'package:flutter/material.dart';
import 'package:pembayaran_listrik/view/splash/splash_screen.dart';

import 'components/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: appBarTheme,
        textTheme: textTheme,
        elevatedButtonTheme: elevatedButtonTheme,
      ),
      home: const SplashScreen(),
    );
  }
}
