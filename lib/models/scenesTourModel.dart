import 'package:flutter/material.dart';
import 'package:fluttericon/brandico_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

class ScenesInTourModel {
  const ScenesInTourModel({required this.icon, required this.title});
  final String title;
  final IconData icon;
}

List<ScenesInTourModel> houseScenes = [
  ScenesInTourModel(icon: Icons.door_sliding_outlined, title: 'Fachada'),
  ScenesInTourModel(icon: Icons.door_back_door, title: 'Entrada'),
  ScenesInTourModel(icon: Icons.crop_portrait_outlined, title: 'Pasillo'),
  ScenesInTourModel(icon: FontAwesome.cc_paypal, title: 'Sala'),
  ScenesInTourModel(icon: Icons.table_bar_rounded, title: 'Comedor'),
  ScenesInTourModel(icon: Icons.kitchen, title: 'Cocina'),
  ScenesInTourModel(icon: Icons.bathtub_rounded, title: 'Baño'),
  ScenesInTourModel(icon: Icons.stairs, title: 'Escaleras'),
  ScenesInTourModel(icon: Icons.bed_outlined, title: 'Dormitorio'),
  ScenesInTourModel(icon: Icons.add, title: 'Jardin'),
  ScenesInTourModel(icon: Icons.add, title: 'Balcon'),
  ScenesInTourModel(icon: Icons.dashboard, title: 'Otros'),
];

List<ScenesInTourModel> restaurantScenes = [
  ScenesInTourModel(icon: Icons.add, title: 'Restaurant'),
  ScenesInTourModel(icon: Icons.add, title: 'Restaurant')
];

List<ScenesInTourModel> commercerScenes = [
  ScenesInTourModel(icon: Icons.add, title: 'Commerce'),
  ScenesInTourModel(icon: Icons.add, title: 'Commerce')
];

List<ScenesInTourModel> otherScenes = [
  ScenesInTourModel(icon: Icons.add, title: 'other'),
  ScenesInTourModel(icon: Icons.add, title: 'other')
];
