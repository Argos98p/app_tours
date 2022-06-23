import 'dart:io';

import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class Viewer360Page extends StatefulWidget {
  final String pathImage;
  const Viewer360Page({Key? key, required this.pathImage}) : super(key: key);

  @override
  State<Viewer360Page> createState() => _Viewer360PageState();
}

class _Viewer360PageState extends State<Viewer360Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Panorama(child: Image.file(File(widget.pathImage))),
      ),
    );
  }
}
