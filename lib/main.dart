import 'package:app_tours/initalConfigurations/ScenesTourModel.dart';
import 'package:app_tours/pages/AddImagePage.dart';
import 'package:app_tours/pages/Home.dart';
import 'package:app_tours/pages/ScenesInTour.dart';
import 'package:app_tours/pages/VirtualToursPage.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<TourProvider>(create: (_)=>TourProvider()),
      ],
      builder: (context,_) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'Roboto',
          ),
          //darkTheme: ThemeData(brightness: Brightness.dark),
          //themeMode: ThemeMode.dark,
          home: Home(index:0),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;

            switch (settings.name) {
              case '/toursDisponibles':
                builder = (BuildContext context) => VirtualTourPage();
                break;
             /* case '/toursDisponibles/informationTour':
                builder=(BuildContext context) => TourInformationPage();
                break;*/
              case '/toursDisponibles/casa':
                builder = (BuildContext context) => ScenesInTour(
                      typeTour: 'casa',
                  infoTour: settings.arguments! as Map<String,String>,
                    );
                break;
              case '/toursDisponibles/restaurant':
                builder = (BuildContext context) => ScenesInTour(
                      typeTour: 'restaurant',
                  infoTour: settings.arguments! as Map<String,String>,
                    );
                break;
              case '/toursDisponibles/comercio':
                builder = (BuildContext context) => ScenesInTour(
                      typeTour: 'comercio',
                  infoTour: settings.arguments! as Map<String,String>,
                    );
                break;
              case '/toursDisponibles/otro':
                builder = (BuildContext context) => ScenesInTour(
                      typeTour: 'otro',
                  infoTour: settings.arguments! as Map<String,String>,
                    );
                break;
              case '/toursDisponibles/agregarEscena':
                builder = (BuildContext context) => AddImagePage(scene: settings.arguments as ScenesInTourModel);
                break;
              default:
                builder = (BuildContext context) => ScenesInTour(
                      typeTour: 'otro',
                  infoTour: settings.arguments! as Map<String,String>,
                    );
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        );
      }
    );
  }
}
