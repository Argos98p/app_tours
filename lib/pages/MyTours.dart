import 'package:flutter/material.dart';

class ToursPage extends StatefulWidget {
  ToursPage({Key? key}) : super(key: key);

  @override
  State<ToursPage> createState() => _ToursPageState();
}

class _ToursPageState extends State<ToursPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('My Tours'),
    );
  }
}
