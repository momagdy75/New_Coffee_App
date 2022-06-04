import 'package:flutter/material.dart';
import 'package:new_coffee_hub/CartScreen.dart';
import 'package:new_coffee_hub/Home.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff22151F),
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF1C161E))
      ),
      home: const HomeScreen(),
    );
  }
}

