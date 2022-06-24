import 'package:app_tours/initalConfigurations/ScenesTourModel.dart';
import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/initalConfigurations/TourAvaliable.dart';
import 'package:app_tours/pages/FloorScenesPage.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:app_tours/utils/SharedPreferences.dart';
import 'package:slugify/slugify.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ScenesInTour extends StatefulWidget {
  String typeTour;
  //Map<String,String> infoTour;
  Map<String, String> infoTour;
  ScenesInTour({Key? key, required this.typeTour, required this.infoTour})
      : super(key: key);
  @override
  State<ScenesInTour> createState() => _ScenesInTourState();
}

class _ScenesInTourState extends State<ScenesInTour> {
  SharedPref sharedPref = SharedPref();
  TextEditingController floorNameController = TextEditingController();
  String floorName = '';
  String floorNameSlug = '';
  @override
  void initState() {
    super.initState();
  }

  List<ScenesInTourModel> scenes = [];
  Map<String, FloorScenesPage> floorScafold = {};
// Initial Selected Value
  String pisoSelec = 'default';

  // List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {
    TourProvider watch = context.watch<TourProvider>();
    context.read<TourProvider>().setInfoTour(infoTour: widget.infoTour);
    context.read<TourProvider>().setType(typeTour: widget.typeTour);
    //pisos = context.read<TourProvider>().newTour.floors ?? [];
    Map<String, Floor> pisos = context.read<TourProvider>().newTour.floors!;

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

    pisos.forEach((key, floor) {
      setState(() {
        var aux = FloorScenesPage(
          floor: floor,
          scenes: scenes,
        );
        floorScafold[key] = aux;
      });
    });
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
                        color: colorsApp[
                            'primaryColor'], //background color of dropdown button
                        //border: Border.all(color: Colors.black38, width:3), //border of dropdown button
                        borderRadius: BorderRadius.circular(
                            30), //border raiuds of dropdown button
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 10),
                        child: DropdownButton<String>(
                          underline: Container(),
                          // Initial Value
                          value: pisoSelec,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          // Array list of items
                          items: List.generate(
                            pisos.keys.length + 1,
                            (index) => index < pisos.keys.length
                                ? DropdownMenuItem(
                                    child: Text(
                                        '${pisos.keys.toList().elementAt(index)}'),
                                    value:
                                        '${pisos.keys.toList().elementAt(index)}')
                                : DropdownMenuItem(
                                    child: TextButton(
                                      child: Text('Agregar'),
                                      onPressed: () {
                                        print('click crear');
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                child: Container(
                                                  margin: EdgeInsets.all(20),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            floorNameController,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Nombre del piso',
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                elevation: 5,
                                                                primary: Colors.transparent,
                                                                shadowColor: Colors.transparent.withOpacity(0.1),
                                                                side: BorderSide(
                                                                  width: 2,
                                                                  color: Colors.redAccent,
                                                                ),),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: Text("Cerrar")),
                                                          ElevatedButton(onPressed: (){
                                                              floorName=floorNameController.text;
                                                              floorNameSlug=slugify(floorName,delimiter: '_');
                                                              floorNameController.text='';
                                                              print(floorName+'   '+floorNameSlug);

                                                              Floor nuevoFloor = Floor(slug: floorNameSlug,scenes: {},name: floorName);
                                                              var aux = FloorScenesPage(
                                                                floor: nuevoFloor,
                                                                scenes: scenes,
                                                              );
                                                              floorScafold[floorNameSlug] = aux;

                                                              setState(() {
                                                                context.read<TourProvider>().newTour.floors![floorName]=nuevoFloor;
                                                              });

                                                              Fluttertoast.showToast(msg: 'Nuevo piso creado');
                                                              Navigator.of(context).pop();
                                                          }, child: Text('Crear')),

                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                  ),
                          ),

                          /*pisos.keys.toList().map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );,
                          }).toList(),*/
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            if (newValue == null) {
                            } else {
                              setState(() {
                                pisoSelec = newValue;
                                /*pisoSelecccionado =
                                  pisosNombres.indexOf(newValue);*/
                                print('piso seleccionado:' + pisoSelec);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: floorScafold[pisoSelec]!),

              //Expanded(child: gridScenes(scenes)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent.withOpacity(0.1),
                        side: BorderSide(
                          width: 2,
                          color: Colors.blueAccent,
                        ),
                      ),
                      onPressed: () {
                        context.read<TourProvider>().cancelTour();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                      },
                      child: Text("Cancelar")),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //print(context.read<TourProvider>().newTour.toMap());
                        //sharedPref.remove('nuevo_tour');
                        // sharedPref.save("nuevo_tour", context.read<TourProvider>().newTour.toMap());
                        Fluttertoast.showToast(msg: 'Tour creado');
                        context.read<TourProvider>().cancelTour();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                      },
                      child: Text("Crear"))
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
