import 'package:app_tours/models/InputsTour.dart';
import 'package:app_tours/models/ScenesTourModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:slugify/slugify.dart';

class TourAvaliable {
  IconData icon;
  String title;
  String routeName;
  List<ScenesInTourModel> scenes;
  Map<String,InputsTour> inputs;

  TourAvaliable(
      {required this.icon,
      required this.title,
      required this.scenes,
      required this.inputs,
      required this.routeName});


}

TourAvaliable tourCasa = TourAvaliable(
    icon: ModernPictograms.home,
    title: 'Casa',
    scenes: <ScenesInTourModel>[
      const ScenesInTourModel(icon: Icons.door_sliding_outlined, title: 'Fachada'),
      const ScenesInTourModel(icon: Icons.door_back_door, title: 'Entrada'),
      const ScenesInTourModel(icon: Icons.crop_portrait_outlined, title: 'Pasillo'),
      const ScenesInTourModel(icon: FontAwesome.cc_paypal, title: 'Sala'),
      const ScenesInTourModel(icon: Icons.table_bar_rounded, title: 'Comedor'),
      const ScenesInTourModel(icon: Icons.kitchen, title: 'Cocina'),
      const ScenesInTourModel(icon: Icons.bathtub_rounded, title: 'Baño'),
      const ScenesInTourModel(icon: Icons.stairs, title: 'Escaleras'),
      const ScenesInTourModel(icon: Icons.bed_outlined, title: 'Dormitorio'),
      const ScenesInTourModel(icon: Icons.add, title: 'Jardin'),
      const ScenesInTourModel(icon: Icons.add, title: 'Balcon'),
      const ScenesInTourModel(icon: Icons.dashboard, title: 'Otros'),
    ],
    inputs: <String,InputsTour>{
      'titulo':InputsTour(icon: Icons.threesixty_outlined, label: 'Titulo',slug: 'titulo'),
      'direccion':InputsTour(icon: Icons.location_on_outlined, label: 'Direccion',slug: 'direccion'),
      'ciudad':InputsTour(icon: Icons.my_location_rounded, label: 'Ciudad',slug: 'ciudad'),
      'ref_ext':InputsTour(icon: Icons.nat_sharp, label: 'Referencia externa',slug: 'ref_externa'),
    },
    routeName: '/toursDisponibles/casa');

TourAvaliable tourRestaurante = TourAvaliable(
    icon: FontAwesome5.utensils,
    title: 'Restaurante',
    scenes: [
      const ScenesInTourModel(icon: Icons.add, title: 'Restaurant'),
      const ScenesInTourModel(icon: Icons.add, title: 'Restaurant')
    ],
    inputs: {
      'titulo':InputsTour(icon: Icons.threesixty_outlined, label: 'Titulo',slug: 'titulo'),
    },
    routeName: '/toursDisponibles/restaurante');

TourAvaliable tourComercio = TourAvaliable(
    icon: FontAwesome5.building,
    title: 'Comercio',
    scenes: [
      const ScenesInTourModel(icon: Icons.add, title: 'Commerce'),
      const ScenesInTourModel(icon: Icons.add, title: 'Commerce')
    ],
    inputs: {
      'titulo':InputsTour(icon: Icons.threesixty_outlined, label: 'Titulo',slug: 'titulo'),
    },
    routeName: '/toursDisponibles/restaurante');

TourAvaliable tourOtro = TourAvaliable(
    icon: Icons.dashboard,
    title: 'Otro',
    scenes: [
      const ScenesInTourModel(icon: Icons.add, title: 'Otro'),
      const ScenesInTourModel(icon: Icons.add, title: 'Otro')
    ],
    inputs: {
     'titulo':InputsTour(icon: Icons.threesixty_outlined, label: 'Titulo',slug: 'titulo'),
    },
    routeName: '/toursDisponibles/restaurante');

Map<String,TourAvaliable> toursAvaliables = {
  "casa": tourCasa,
  "comercio":tourComercio,
  "restuarante":tourRestaurante,
  "otro":tourOtro,
};
