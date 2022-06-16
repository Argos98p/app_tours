import 'package:flutter/material.dart';
import 'package:fluttericon/brandico_icons.dart';
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
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                'Tours Virtuales',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Expanded(child: gridTours())
            ],
          ),
        ),
      ),
    );
  }

  Widget gridTours() {
    return GridView.count(
        crossAxisCount: 3,
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
  const TourDisponiblesApp({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

List<TourDisponiblesApp> toursLista = const <TourDisponiblesApp>[
  TourDisponiblesApp(title: 'Casa', icon: ModernPictograms.home),
  TourDisponiblesApp(title: 'Restaurante', icon: Maki.restaurant),
  TourDisponiblesApp(title: 'Comercial', icon: FontAwesome.building),
  TourDisponiblesApp(title: 'Otro', icon: FontAwesome.plus)
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.tourDisponibleApp})
      : super(key: key);
  final TourDisponiblesApp tourDisponibleApp;

  @override
  Widget build(BuildContext context) {
    //final TextStyle textStyle = Theme.of(context).textTheme.display1;
    final TextStyle textStyle = TextStyle();

    return Card(
        color: Colors.orange,
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Icon(tourDisponibleApp.icon,
                        size: 50.0, color: textStyle.color)),
                Text(tourDisponibleApp.title, style: textStyle),
              ]),
        ));
  }
}
