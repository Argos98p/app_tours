import 'package:app_tours/pages/Home.dart';
import 'package:app_tours/pages/ScenesInTour.dart';
import 'package:app_tours/pages/TourInformationPage.dart';
import 'package:app_tours/pages/VirtualToursPage.dart';
import 'package:app_tours/utils/AppTheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
      ),
      //darkTheme: ThemeData(brightness: Brightness.dark),
      //themeMode: ThemeMode.dark,
      home: Home(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case '/toursDisponibles':
            builder = (BuildContext context) => VirtualTourPage();
            break;
          case '/toursDisponibles/informationTour':
            builder=(BuildContext context) => TourInformationPage();
            break;
          case '/toursDisponibles/casa':
            builder = (BuildContext context) => ScenesInTour(
                  typeTour: 'casa',
                );
            break;
          case '/toursDisponibles/restaurant':
            builder = (BuildContext context) => ScenesInTour(
                  typeTour: 'restaurant',
                );
            break;
          case '/toursDisponibles/comercio':
            builder = (BuildContext context) => ScenesInTour(
                  typeTour: 'comercio',
                );
            break;
          case '/toursDisponibles/otro':
            builder = (BuildContext context) => ScenesInTour(
                  typeTour: 'otro',
                );
            break;
          default:
            builder = (BuildContext context) => ScenesInTour(
                  typeTour: 'otro',
                );
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
