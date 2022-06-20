import 'package:app_tours/models/ScenesTourModel.dart';
import 'package:app_tours/models/Tour.dart';
import 'package:app_tours/models/TourAvaliable.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/SharedPreferences.dart';
import 'package:app_tours/widgets/itemCard.dart';
import 'package:app_tours/widgets/itemCardScene.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ScenesInTour extends StatefulWidget {
  String typeTour;
  //Map<String,String> infoTour;
  Map<String,String> infoTour;



  ScenesInTour({Key? key, required this.typeTour,required this.infoTour}) : super(key: key);

  @override
  State<ScenesInTour> createState() => _ScenesInTourState();
}

class _ScenesInTourState extends State<ScenesInTour> {

  SharedPref sharedPref = SharedPref();

  @override
  void initState(){
    super.initState();

  }


  List<ScenesInTourModel> scenes = [];




  @override
  Widget build(BuildContext context) {
    TourProvider watch = context.watch<TourProvider>();

    //print('info desde l widget'+widget.infoTour.toString());
    context.read<TourProvider>().setInfoTour(infoTour: widget.infoTour);
    print(widget.typeTour);
    context.read<TourProvider>().setType(typeTour: widget.typeTour);
    //print('tour con provider:'+context.read<TourProvider>().newTour.infoTour.toString());
    switch (widget.typeTour) {
      case 'casa':
        scenes = toursAvaliables['casa']!.scenes;
        break;
      case 'restaurante':
        scenes = toursAvaliables['restaurante']!.scenes;
        break;
      case 'comercial':
        scenes = toursAvaliables['comercial']!.scenes;
        break;

      case 'otro':
        scenes = toursAvaliables['otro']!.scenes;
        break;
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Text(
                'Tours Virtuales',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Expanded(child: gridScenes(scenes)),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent.withOpacity(0.1),
                      side: BorderSide(
                        width: 2,
                        color: Colors.blueAccent,
                      ),),
                    onPressed: () {
                      context.read<TourProvider>().cancelTour();
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);

                    },
                    child: Text("Cancelar")),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      //print(context.read<TourProvider>().newTour.toMap());
                      //sharedPref.remove('nuevo_tour');
                      sharedPref.save("nuevo_tour", context.read<TourProvider>().newTour.toMap());
                      Fluttertoast.showToast(msg: 'Tour creado');
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    },
                    child: Text("Crear"))
              ],
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  Widget gridScenes(List<ScenesInTourModel> scenesTour) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: EdgeInsets.all(10),
        children: List.generate(scenesTour.length, (index) {
          return Center(
              child: ItemCardScene(
                scene:scenesTour[index])
                  );
        }));
  }
}
