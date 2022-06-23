import 'package:app_tours/initalConfigurations/ScenesTourModel.dart';
import 'package:app_tours/models/Tour.dart';
import 'package:app_tours/initalConfigurations/TourAvaliable.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
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
// Initial Selected Value
  String dropdownvalue = 'Piso 1';

  // List of items in our dropdown menu
  var items = [
    'Piso 1',
    'Piso 2',
    'Piso 3',
    'Piso 4',
    'Piso 5',
  ];
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
      case 'restaurant':
        scenes = toursAvaliables['restaurant']!.scenes;
        break;
      case 'comercio':
        scenes = toursAvaliables['comercio']!.scenes;
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
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    'Tours Virtuales',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        color:colorsApp['primaryColor'], //background color of dropdown button
                        //border: Border.all(color: Colors.black38, width:3), //border of dropdown button
                        borderRadius: BorderRadius.circular(30), //border raiuds of dropdown button

                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left:15, right:10),
                      child: DropdownButton(
                        underline: Container(),

                        // Initial Value
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
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
                      context.read<TourProvider>().cancelTour();
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
