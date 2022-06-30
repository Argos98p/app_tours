import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/models/Scene.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:app_tours/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:slugify/slugify.dart';

class OtherTour extends StatefulWidget {
  String typeTour;
  Map<String, String> infoTour;
  bool updateTour;
  int indexTour;
  OtherTour(
      {Key? key,
      required this.typeTour,
      required this.infoTour,
      required this.indexTour,
      required this.updateTour})
      : super(key: key);

  @override
  State<OtherTour> createState() => _OtherTourState();
}

class _OtherTourState extends State<OtherTour> {
  late String pisoSelec;
  TextEditingController newSceneController = TextEditingController();
  SharedPref sharedPref = SharedPref();
  @override
  void initState() {
    super.initState();
    pisoSelec = '';
  }

  @override
  Widget build(BuildContext context) {
    pisoSelec=context.read<TourProvider>().newTour.floors!.keys.first;
    context.read<TourProvider>().setInfoTour(infoTour: widget.infoTour);
    context.read<TourProvider>().setType(typeTour: widget.typeTour);
    Map<String, Floor> pisos = context.read<TourProvider>().newTour.floors!;
    //TourProvider watch = context.watch<TourProvider>();

    Map<String, Scene> scenes =
        context.read<TourProvider>().newTour.floors![pisoSelec]!.scenes!;

    print('en el piso ' + pisoSelec + ' hay ' + scenes.length.toString());

    TextEditingController newNameSceneController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Tour ${widget.infoTour['tipo_aux']!}",
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          TextEditingController newNameController = TextEditingController();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                    child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                       TextField(
                                        controller:newNameController,
                                        decoration: const InputDecoration(
                                          labelText:'Editar nombre',
                                          prefixIcon: Icon(Icons.edit),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            child: const Text('Cerrar'),
                                            style: ElevatedButton.styleFrom(
                                              elevation: 5,
                                              primary: Colors.transparent,
                                              shadowColor: Colors.transparent
                                                  .withOpacity(0.1),
                                              side: const BorderSide(
                                                width: 2,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                               print( newNameController.text);
                                               setState(() {
                                                 context.read<TourProvider>().updateInfoTourInput(keyInput: 'tipo_aux', newValue: newNameController.text);
                                                  Navigator.pop(context);
                                                  widget.infoTour['tipo_aux']=newNameController.text;
                                                  //newNameController.dispose();
                                               });
                                              },
                                              child: const Text("Ok")),
                                        ],
                                      )

                                    ],
                                  ),
                                ));
                              });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blueAccent,
                        ),
                      )
                    ],
                  ),
                  DropdownButton<String>(
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
                                children: [IconButton(onPressed: (){
                                  TextEditingController newNameController = TextEditingController();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    controller:newNameController,
                                                    decoration: const InputDecoration(
                                                      labelText:'Editar nombre de nivel',
                                                      prefixIcon: Icon(Icons.edit),
                                                      contentPadding: EdgeInsets.symmetric(
                                                          vertical: 0, horizontal: 10),
                                                      border: OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      ElevatedButton(
                                                        child: const Text('Cerrar'),
                                                        style: ElevatedButton.styleFrom(
                                                          elevation: 5,
                                                          primary: Colors.transparent,
                                                          shadowColor: Colors.transparent
                                                              .withOpacity(0.1),
                                                          side: const BorderSide(
                                                            width: 2,
                                                            color: Colors.redAccent,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            print( newNameController.text);
                                                            setState(() {
                                                              pisoSelec=slugify(newNameController.text);
                                                              context.read<TourProvider>().renameFloor(newName: newNameController.text, oldName:pisos.keys.toList().elementAt(index) );
                                                              Fluttertoast.showToast(msg: 'Nivel renombrado');
                                                              Navigator.pop(context);
                                                              /*context.read<TourProvider>().updateInfoTourInput(keyInput: 'tipo_aux', newValue: newNameController.text);
                                                              Navigator.pop(context);
                                                              widget.infoTour['tipo_aux']=newNameController.text;*/
                                                            });
                                                          },
                                                          child: const Text("Ok")),
                                                    ],
                                                  )

                                                ],
                                              ),
                                            ));
                                      });
                                }, icon: Icon(Icons.edit)),
                                  Text(pisos.keys.toList().elementAt(index))],
                              )
                          ,
                              value: pisos.keys.toList().elementAt(index))
                          //opcion de agregar piso
                          : DropdownMenuItem(
                              child: TextButton(
                                child: const Text('Agregar'),
                                onPressed: () {
                                  print('click crear');
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: Container(
                                            margin: const EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller:
                                                      newSceneController,
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText:
                                                        'Nombre del piso',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation: 5,
                                                          primary: Colors
                                                              .transparent,
                                                          shadowColor: Colors
                                                              .transparent
                                                              .withOpacity(0.1),
                                                          side:
                                                              const BorderSide(
                                                            width: 2,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            "Cerrar")),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {});
                                                          try {
                                                            context
                                                                .read<
                                                                    TourProvider>()
                                                                .addFloor(
                                                                    nameFloor:
                                                                        newSceneController
                                                                            .text);
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Piso creado');
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          } catch (e) {
                                                            Fluttertoast.showToast(
                                                                msg: 'Error ' +
                                                                    e.toString());
                                                          }
                                                        },
                                                        child: const Text(
                                                            'Crear')),
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

                    onChanged: (String? newValue) {
                      if (newValue == null) {
                      } else {
                        setState(() {
                          pisoSelec = newValue;
                          scenes = context
                              .read<TourProvider>()
                              .newTour
                              .floors![pisoSelec]!
                              .scenes!;
                        });
                      }
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: TextField(
                                    controller: newNameSceneController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Nombre de la escena',
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            String nameScene =
                                                newNameSceneController.text;
                                            Scene auxScene = Scene(
                                                imageList: [],
                                                name: nameScene,
                                                slug: slugify(nameScene));
                                            context
                                                .read<TourProvider>()
                                                .addScene(
                                                    scene: auxScene,
                                                    floorKey: pisoSelec);
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: const Text('Crear'))
                                  ],
                                )
                              ],
                            ));
                          });
                    },
                    child: const Text(
                      'Nueva escena',
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  padding: const EdgeInsets.all(10),
                  children: List.generate(scenes.keys.length, (index) {
                    return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: colorsApp['primaryColor'],
                        child: InkWell(
                          onTap: () {
                            _navigateAddImageAndReturn(
                                context,
                                scenes.keys.toList()[index],
                                pisos[pisoSelec]!.slug!);
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Positioned(
                                right: 0,
                                top: 0,
                                child: numScenesButton(scenes.values
                                    .toList()[index]
                                    .imageList
                                    .length),
                              ),
                              Center(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      /*Expanded(*/
                                      Icon(Icons.dashboard,
                                          size: 30,
                                          color: colorsApp['iconColor']),
                                      /*),*/
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
                                          child: Text(
                                              scenes.values
                                                  .toList()[index]
                                                  .name,
                                              style: const TextStyle(
                                                  fontSize: 16))),
                                    ]),
                              ),
                            ],
                          ),
                        ));
                  }),
                ),
              ),
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
                          context.read<TourProvider>().cancelTour();
                          Fluttertoast.showToast(msg: 'Tour actualizado');
                        } else {
                          sharedPref.save("nuevo_tour", tourMap);
                          context.read<TourProvider>().cancelTour();
                          Fluttertoast.showToast(msg: 'Tour creado');
                        }

                        context.read<TourProvider>().cancelTour();

                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                      },
                      child: (widget.updateTour)
                          ? const Text("Actualizar")
                          : const Text('Crear'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget numScenesButton(int n) {
    //print('numero de escenas en '+widget.floor.slug! +'en la escena '+widget.sceneInTour.slug+' es :'+n.toString());
    if (n > 0) {
      setState(() {});
      return Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(n.toString())));
    } else {
      setState(() {});
      return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: colorsApp['secondaryColor'],
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(n.toString())));
    }
  }

  Future _navigateAddImageAndReturn(
      BuildContext context, String sceneKey, String floorKey) async {
    //TourProvider watch = context.watch<TourProvider>();
    var imageFileList;
    //try {
      Scene scene = context
          .read<TourProvider>()
          .newTour
          .floors![floorKey]!
          .scenes![sceneKey]!;
      imageFileList = await Navigator.pushNamed(
          context, '/toursDisponibles/agregarEscena',
          arguments: {"sceneName": scene.name,
            'imageList': scene.imageList});

      print('esto es el tamaño de la imagelist ' +
          scene.imageList.length.toString());
   /* } catch (e) {
      print('error al recuperar las escenas de "otros" ' + e.toString());
    }*/

    if (imageFileList != null) {
      imageFileList as List<XFile>;

      context.read<TourProvider>().addImageListSceneOther(
          floorKey: floorKey, sceneKey: sceneKey, imageList: imageFileList);
      setState(() {});
    }
  }
}
