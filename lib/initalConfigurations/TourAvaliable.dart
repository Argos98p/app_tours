import 'dart:ui';

import 'package:app_tours/initalConfigurations/InputsTour.dart';
import 'package:app_tours/initalConfigurations/ScenesTourModel.dart';
import 'package:app_tours/utils/my_flutter_app_icons.dart';
import 'package:app_tours/widgets/icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';

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
      //const ScenesInTourModel(icon: Icons.door_sliding_outlined, title: 'Fachada',slug: 'fachada'),
      const ScenesInTourModel(icon: FontAwesome5.building, title: 'Fachada',slug: 'fachada'),
      const ScenesInTourModel(icon: Icons.door_back_door, title: 'Entrada',slug: 'entrada'),
      const ScenesInTourModel(icon: UiIcons.corredor, title: 'Pasillo',slug: 'pasillo'),
      const ScenesInTourModel(icon: Icons.chair , title: 'Sala',slug: 'sala'),
      const ScenesInTourModel(icon: Icons.table_bar_rounded, title: 'Comedor',slug: 'comedor'),
      const ScenesInTourModel(icon: Icons.kitchen, title: 'Cocina',slug: 'cocina'),
      const ScenesInTourModel(icon: Icons.bathtub_rounded, title: 'Baño',slug: 'banio'),
      const ScenesInTourModel(icon: Icons.stairs, title: 'Escaleras',slug: 'escaleras'),
      const ScenesInTourModel(icon: Icons.bed_outlined, title: 'Dormitorio',slug: 'dormitorio'),
      const ScenesInTourModel(icon: UiIcons.garden, title: 'Jardin',slug: 'jardin'),
      const ScenesInTourModel(icon: UiIcons.balcon, title: 'Balcon',slug: 'balcon'),
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
      const ScenesInTourModel(icon:  FontAwesome5.building, title: 'Fachada',slug: 'fachada'),
      const ScenesInTourModel(icon: FontAwesome5.door_open, title: 'Entrada',slug: 'entrada'),
      const ScenesInTourModel(icon: UiIcons.recepcion1, title: 'Recepcion',slug: 'recepcion'),
      const ScenesInTourModel(icon: FontAwesome5.couch, title: 'Estar',slug: 'estar'),
      const ScenesInTourModel(icon: Icons.table_bar_rounded, title: 'Comedor',slug: 'comedor'),
      const ScenesInTourModel(icon: Icons.kitchen, title: 'Cocina',slug: 'cocina'),
      const ScenesInTourModel(icon: FontAwesome5.restroom, title: 'Baño',slug: 'banio'),
      const ScenesInTourModel(icon: Icons.stairs, title: 'Escaleras',slug: 'escaleras'),
      const ScenesInTourModel(icon: UiIcons.bar1, title: 'Bar',slug: 'bar'),
      const ScenesInTourModel(icon: FontAwesome5.cash_register, title: 'Caja',slug: 'caja'),
      const ScenesInTourModel(icon: UiIcons.terraza, title: 'Terraza',slug: 'terraza'),
      const ScenesInTourModel(icon: Icons.dashboard, title: 'Otros',slug: 'otros'),



    ],
    inputs: {
      'titulo':InputsTour(icon: Icons.threesixty_outlined, label: 'Titulo',slug: 'titulo'),
      'direccion':InputsTour(icon: Icons.location_on_outlined, label: 'Direccion',slug: 'direccion'),
      'ciudad':InputsTour(icon: Icons.my_location_rounded, label: 'Ciudad',slug: 'ciudad'),
      'ref_ext':InputsTour(icon: Icons.nat_sharp, label: 'Referencia externa',slug: 'ref_externa'),    },
    routeName: '/toursDisponibles/restaurante');

TourAvaliable tourComercio = TourAvaliable(
    icon: FontAwesome5.building,
    title: 'Comercio',
    scenes: [
      const ScenesInTourModel(icon: FontAwesome5.building, title: 'Fachada', slug: 'fachada'),
      const ScenesInTourModel(icon: FontAwesome5.door_open, title: 'Entrada', slug: 'entrada'),
      const ScenesInTourModel(icon: UiIcons.corredor, title: 'Pasillo', slug: 'pasillo'),
      const ScenesInTourModel(icon: FontAwesome5.couch, title: 'Estar', slug: 'estar'),
      const ScenesInTourModel(icon: UiIcons.recepcion, title: 'Serv. Cliente', slug: 'serv_cliente'),
      const ScenesInTourModel(icon: UiIcons.exhibicion, title: 'Exhibicion', slug: 'exhibicion'),
      const ScenesInTourModel(icon: FontAwesome5.restroom, title: 'Baño', slug: 'banio'),
      const ScenesInTourModel(icon: Icons.stairs, title: 'Escaleras', slug: 'escaleras'),
      const ScenesInTourModel(icon: UiIcons.boxes, title: 'Mostrador', slug: 'mostrador'),
      const ScenesInTourModel(icon: FontAwesome5.person_booth, title: 'Vestidor', slug: 'vestidor'),
      const ScenesInTourModel(icon: FontAwesome5.cash_register, title: 'Caja', slug: 'caja'),
      const ScenesInTourModel(icon: Icons.dashboard, title: 'Otros', slug: 'otros'),

    ],
    inputs: {
      'titulo':InputsTour(icon: Icons.threesixty_outlined, label: 'Titulo',slug: 'titulo'),
      'direccion':InputsTour(icon: Icons.location_on_outlined, label: 'Direccion',slug: 'direccion'),
      'ciudad':InputsTour(icon: Icons.my_location_rounded, label: 'Ciudad',slug: 'ciudad'),
      'ref_ext':InputsTour(icon: Icons.nat_sharp, label: 'Referencia externa',slug: 'ref_externa'),    },
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
      'direccion':InputsTour(icon: Icons.location_on_outlined, label: 'Direccion',slug: 'direccion'),
      'ciudad':InputsTour(icon: Icons.my_location_rounded, label: 'Ciudad',slug: 'ciudad'),
      'ref_ext':InputsTour(icon: Icons.nat_sharp, label: 'Referencia externa',slug: 'ref_externa'),    },
    routeName: '/toursDisponibles/restaurante');

Map<String,TourAvaliable> toursAvaliables = {
  "casa": tourCasa,
  "comercio":tourComercio,
  "restaurant":tourRestaurante,
  "otro":tourOtro,
};
