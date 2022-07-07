import 'package:app_tours/initalConfigurations/ScenesTourModel.dart';
import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/initalConfigurations/TourAvaliable.dart';
import 'package:app_tours/pages/add_tour/add_tour_main_page.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:app_tours/pages/add_tour/FloorScenesPage.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:app_tours/utils/SharedPreferences.dart';
import 'package:flutter/scheduler.dart';
import 'package:slugify/slugify.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ScenesInTour extends StatefulWidget {
  String typeTour;
  bool updateTour;
  int indexTour;
  Map<String, String> infoTour;
  ScenesInTour(
      {Key? key,
      required this.typeTour,
      required this.infoTour,
      required this.updateTour,
      required this.indexTour})
      : super(key: key);
  @override
  State<ScenesInTour> createState() => _ScenesInTourState();
}

class _ScenesInTourState extends State<ScenesInTour> {
  SharedPref sharedPref = SharedPref();
  TextEditingController floorNameController = TextEditingController();
  String floorName = '';
  String floorNameSlug = '';
  String pisoSelec = '';
  Map<String, Floor> pisos = {};
  final FocusNode dropDownFocus = FocusNode();

  @override
  void initState() {


    super.initState();
  }

  List<ScenesInTourModel> scenes = [];
  Map<String, FloorScenesPage> floorScafold = {};

  @override
  Widget build(BuildContext context) {

    //
    context.read<TourProvider>().setInfoTour(infoTour: widget.infoTour);
    context.read<TourProvider>().setType(typeTour: widget.typeTour);
    //pisos = context.read<TourProvider>().newTour.floors ?? [];
    pisos = context.read<TourProvider>().newTour.floors!;

    if(pisoSelec==''){
      pisoSelec= context.read<TourProvider>().newTour.floors!.keys.first;
    }
    print('UPDATE:' + widget.updateTour.toString());
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
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Escenas ' + StringUtils.capitalize(widget.typeTour),
                      style: const TextStyle(
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
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        child: DropdownButton<String>(
                          focusNode: dropDownFocus,
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
                                    child: Row(
                                      children: [
                                        (pisoSelec==pisos.keys
                                            .toList()
                                            .elementAt(index))
                                        ?
                                        IconButton(
                                            onPressed: () {
                                              TextEditingController
                                                  newNameController =
                                                  TextEditingController();
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {

                                                    return Dialog(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          TextField(
                                                            controller:
                                                                newNameController,
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  'Editar nombre de nivel',
                                                              prefixIcon: Icon(
                                                                  Icons.edit),
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          0,
                                                                      horizontal:
                                                                          10),
                                                              border:
                                                                  OutlineInputBorder(),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ElevatedButton(
                                                                child: const Text(
                                                                    'Cerrar'),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  elevation: 5,
                                                                  primary: Colors
                                                                      .transparent,
                                                                  shadowColor: Colors
                                                                      .transparent
                                                                      .withOpacity(
                                                                          0.1),
                                                                  side:
                                                                      const BorderSide(
                                                                    width: 2,
                                                                    color: Colors
                                                                        .redAccent,
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);

                                                                },
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    print(newNameController
                                                                        .text);
                                                                    setState(
                                                                        () {
                                                                      pisoSelec =
                                                                          slugify(
                                                                              newNameController.text);
                                                                      context.read<TourProvider>().renameFloor(
                                                                          newName: newNameController
                                                                              .text,
                                                                          oldName: pisos
                                                                              .keys
                                                                              .toList()
                                                                              .elementAt(index));
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: 'Nivel renombrado');
                                                                      Navigator.pop(
                                                                          context);

                                                                      /*context.read<TourProvider>().updateInfoTourInput(keyInput: 'tipo_aux', newValue: newNameController.text);
                                                              Navigator.pop(context);
                                                              widget.infoTour['tipo_aux']=newNameController.text;*/
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "Ok")),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ));
                                                  });
                                            },
                                            icon: Icon(Icons.edit))
                                        :const SizedBox(width: 0,height: 0,),
                                        Text(pisos.keys
                                            .toList()
                                            .elementAt(index))
                                      ],
                                    ),
                                    value: pisos.keys.toList().elementAt(index))
                                : DropdownMenuItem(
                                    child: TextButton(
                                      child: const Text('Agregar'),
                                      onPressed: () {
                                        setState(() {});
                                        _dialogAddFloor();
                                        print('click crear');
                                      },
                                    ),
                                  ),
                          ),
                          onChanged: (String? newValue) {
                            if (newValue == null) {
                            } else {
                              setState(() {
                                pisoSelec = newValue;
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
                      onPressed: () async {
                        Map<String, dynamic> tourMap =
                            await context.read<TourProvider>().newTour.toMap();
                        if (widget.updateTour) {
                          sharedPref.update(
                              "nuevo_tour", tourMap, widget.indexTour);
                          Fluttertoast.showToast(msg: 'Tour actualizado');
                        } else {
                          sharedPref.save("nuevo_tour", tourMap);
                          Fluttertoast.showToast(msg: 'Tour creado');
                        }
                        context.read<TourProvider>().cancelTour();

                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AddTourMainPage()), (route) => false);
                        
                      },
                      child: (widget.updateTour)
                          ? const Text('Actualizar')
                          : const Text("Crear"))
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  _dialogAddFloor() {
    var myDialog = Dialog(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: this.floorNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre del piso',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent.withOpacity(0.1),
                      side: const BorderSide(
                        width: 2,
                        color: Colors.redAccent,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cerrar")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        floorName = floorNameController.text;
                        floorNameSlug = slugify(floorName, delimiter: '_');
                        floorNameController.text = '';
                        print(floorName + '   ' + floorNameSlug);

                        Floor nuevoFloor = Floor(
                            slug: floorNameSlug,
                            scenes: {},
                            others: {},
                            name: floorName);
                        var aux = FloorScenesPage(
                          floor: nuevoFloor,
                          scenes: scenes,
                        );

                        floorScafold[floorNameSlug] = aux;
                        pisos[floorNameSlug] = nuevoFloor;
                        context
                            .read<TourProvider>()
                            .newTour
                            .floors![floorNameSlug] = nuevoFloor;
                        dropDownFocus.unfocus();
                        Fluttertoast.showToast(msg: 'Nuevo piso creado');
                        Navigator.of(context).pop();
                        Navigator.pop(context);
                        //pisoSelec=floorNameSlug;
                      });
                    },
                    child: const Text('Crear')),
              ],
            )
          ],
        ),
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return myDialog;
        });
  }
}
