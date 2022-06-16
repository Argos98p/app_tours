import 'package:app_tours/pages/Home.dart';
import 'package:app_tours/pages/VirtualToursPage.dart';
import 'package:app_tours/utils/AppTheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      //darkTheme: ThemeData(brightness: Brightness.dark),
      //themeMode: ThemeMode.dark,
      home: VirtualTourPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
