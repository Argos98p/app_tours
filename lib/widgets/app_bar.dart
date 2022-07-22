import 'package:app_tours/pages/Home.dart';
import 'package:flutter/material.dart';

AppBar appBarSpace(context, bool isEditor) {


  return AppBar(
    title: (isEditor)
      ?const Text('Editor ')
      :const Text('Virtual Space '),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.home_outlined),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
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
