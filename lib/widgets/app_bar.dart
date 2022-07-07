import 'package:app_tours/pages/Home.dart';
import 'package:flutter/material.dart';

AppBar appBarSpace(context) {
  return AppBar(
    title: const Text('Virtual Space '),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.home_outlined),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
            ModalRoute.withName("/"),
          );
        },
      ),
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
    ],
  );
}
