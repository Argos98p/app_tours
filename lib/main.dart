import 'package:app_tours/pages/AddImagePage.dart';
import 'package:app_tours/pages/LoginPage.dart';
import 'package:app_tours/pages/OtherTourPage.dart';
import 'package:app_tours/pages/ScenesInTour.dart';
import 'package:app_tours/pages/VirtualToursPage.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
          home:/* Home(index:0),*/const Login(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;

            switch (settings.name) {
              case '/toursDisponibles':
                builder = (BuildContext context) => const VirtualTourPage();
                break;
             /* case '/toursDisponibles/informationTour':
                builder=(BuildContext context) => TourInformationPage();
                break;*/
              case '/toursDisponibles/casa':
                Map<String,dynamic> aux= settings.arguments as Map<String,dynamic>;
                builder = (BuildContext context) => ScenesInTour(
                      typeTour: 'casa',
                  infoTour: aux['formData'] as Map<String,String>,
                  updateTour: aux['case'] as bool,
                  indexTour: aux['index'] as int,
                    );
                break;
              case '/toursDisponibles/restaurant':
                Map<String,dynamic> aux= settings.arguments as Map<String,dynamic>;

                builder = (BuildContext context) => ScenesInTour(
                      typeTour: 'restaurant',
                  infoTour: aux['formData'] as Map<String,String>,
                  updateTour: aux['case'] as bool,
                  indexTour: aux['index'] as int,
                    );
                break;
              case '/toursDisponibles/comercio':
                Map<String,dynamic> aux= settings.arguments as Map<String,dynamic>;

                builder = (BuildContext context) => ScenesInTour(
                      typeTour: 'comercio',
                  infoTour: aux['formData'] as Map<String,String>,
                  updateTour: aux['case'] as bool,
                  indexTour: aux['index'] as int,
                    );
                break;
              case '/toursDisponibles/otro':
                Map<String,dynamic> aux= settings.arguments as Map<String,dynamic>;

                builder = (BuildContext context) => OtherTour(
                      typeTour: 'otro',
                  infoTour: aux['formData'] as Map<String,String>,
                  updateTour: aux['case'] as bool,
                  indexTour: aux['index'] as int,
                    );
                break;
              case '/toursDisponibles/agregarEscena':
                    Map<String,dynamic> aux= settings.arguments as Map<String,dynamic>;
                builder = (BuildContext context) => AddImagePage(sceneName: aux['sceneName'] as String, imageList: aux['imageList'] as List<XFile>);
                break;
              default:
                Map<String,dynamic> aux= settings.arguments as Map<String,dynamic>;
                builder = (BuildContext context) => ScenesInTour(
                  typeTour: 'otro',
                  infoTour: aux['formData'] as Map<String,String>,
                  updateTour: aux['case'] as bool,
                  indexTour: aux['index'] as int,
                    );
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        );
      }
    );
  }
}
