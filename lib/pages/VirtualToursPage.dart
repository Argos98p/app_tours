import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:app_tours/widgets/itemCard.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/brandico_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';

class VirtualTourPage extends StatefulWidget {
  VirtualTourPage({Key? key}) : super(key: key);

  @override
  State<VirtualTourPage> createState() => _VirtualTourPageState();
}

class _VirtualTourPageState extends State<VirtualTourPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Tours Virtuales',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            gridTours()
          ],
        ),
      ),
    );
  }

  Widget gridTours() {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        padding: EdgeInsets.all(20),
        children: List.generate(toursLista.length, (index) {
          return Center(
            child: SelectCard(
              tourDisponibleApp: toursLista[index],
            ),
          );
        }));
  }
}

class TourDisponiblesApp {
  const TourDisponiblesApp(
      {required this.title, required this.icon, required this.routeName});
  final String title;
  final IconData icon;
  final String routeName;
}

List<TourDisponiblesApp> toursLista = const <TourDisponiblesApp>[
  TourDisponiblesApp(
      title: 'Casa',
      icon: ModernPictograms.home,
      routeName: '/toursDisponibles/casa'),
  TourDisponiblesApp(
      title: 'Restaurante',
      icon: FontAwesome5.utensils,
      routeName: '/toursDisponibles/restaurante'),
  TourDisponiblesApp(
      title: 'Comercial',
      icon: FontAwesome5.hotel,
      routeName: '/toursDisponibles/comercial'),
  TourDisponiblesApp(
      title: 'Otro',
      icon: FontAwesome5.boxes,
      routeName: '/toursDisponibles/otro')
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.tourDisponibleApp})
      : super(key: key);
  final TourDisponiblesApp tourDisponibleApp;

  @override
  Widget build(BuildContext context) {
    //final TextStyle textStyle = Theme.of(context).textTheme.display1;
    final TextStyle textStyle = TextStyle(fontSize: 20);
    return itemCard(context, tourDisponibleApp.icon, tourDisponibleApp.title,
        60, tourDisponibleApp.routeName);
  }
}
