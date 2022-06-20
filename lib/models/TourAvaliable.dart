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
      const ScenesInTourModel(icon: Icons.door_sliding_outlined, title: 'Fachada',slug: 'fachada'),
      const ScenesInTourModel(icon: Icons.door_back_door, title: 'Entrada',slug: 'entrada'),
      const ScenesInTourModel(icon: Icons.crop_portrait_outlined, title: 'Pasillo',slug: 'pasillo'),
      const ScenesInTourModel(icon: FontAwesome.cc_paypal, title: 'Sala',slug: 'sala'),
      const ScenesInTourModel(icon: Icons.table_bar_rounded, title: 'Comedor',slug: 'comedor'),
      const ScenesInTourModel(icon: Icons.kitchen, title: 'Cocina',slug: 'cocina'),
      const ScenesInTourModel(icon: Icons.bathtub_rounded, title: 'Baño',slug: 'banio'),
      const ScenesInTourModel(icon: Icons.stairs, title: 'Escaleras',slug: 'escaleras'),
      const ScenesInTourModel(icon: Icons.bed_outlined, title: 'Dormitorio',slug: 'dormitorio'),
      const ScenesInTourModel(icon: Icons.add, title: 'Jardin',slug: 'jardin'),
      const ScenesInTourModel(icon: Icons.add, title: 'Balcon',slug: 'balcon'),
      const ScenesInTourModel(icon: Icons.dashboard, title: 'Otros',slug: 'otros'),
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
      const ScenesInTourModel(icon: Icons.add, title: 'Restaurant',slug: '-'),
      const ScenesInTourModel(icon: Icons.add, title: 'Restaurant',slug: '-')
    ],
    inputs: {
      'titulo':InputsTour(icon: Icons.threesixty_outlined, label: 'Titulo',slug: 'titulo'),
    },
    routeName: '/toursDisponibles/restaurante');

TourAvaliable tourComercio = TourAvaliable(
    icon: FontAwesome5.building,
    title: 'Comercio',
    scenes: [
      const ScenesInTourModel(icon: Icons.add, title: 'Commerce', slug: '-'),
      const ScenesInTourModel(icon: Icons.add, title: 'Commerce', slug: '-')
    ],
    inputs: {
      'titulo':InputsTour(icon: Icons.threesixty_outlined, label: 'Titulo',slug: 'titulo'),
    },
    routeName: '/toursDisponibles/restaurante');

TourAvaliable tourOtro = TourAvaliable(
    icon: Icons.dashboard,
    title: 'Otro',
    scenes: [
      const ScenesInTourModel(icon: Icons.add, title: 'Otro',slug: 'otro'),
      const ScenesInTourModel(icon: Icons.add, title: 'Otro',slug: 'otro')
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
