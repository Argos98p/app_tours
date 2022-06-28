import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/models/Scene.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:slugify/slugify.dart';

class OthersScenes extends StatefulWidget {

  String floorSlug;

  OthersScenes({Key? key, required this.floorSlug}) : super(key: key);

  @override
  State<OthersScenes> createState() => _OthersScenesState();
}

class _OthersScenesState extends State<OthersScenes> {
  late String pisoSelec;
  @override
  void initState(){
    super.initState();
    pisoSelec = widget.floorSlug;
  }

  @override
  Widget build(BuildContext context) {
    TourProvider watch = context.watch<TourProvider>();
    Map<String, Floor> pisos = context.read<TourProvider>().newTour.floors!;

    Map<String, Scene> scenes =
        context.read<TourProvider>().newTour.floors![pisoSelec]!.others!;

    TextEditingController newNameSceneController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, ),
          onPressed: (){ Navigator.of(context).pop();
            setState(() {

            });},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Escenas Otros',
                    style: TextStyle(fontSize: 24),
                  ),
/*
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
                              child: Text(
                                  '${pisos.keys.toList().elementAt(index)}'),
                              value: '${pisos.keys.toList().elementAt(index)}')
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
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText:
                                                        'Nombre del piso',
                                                  ),
                                                ),
                                                SizedBox(
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
                                                          side: BorderSide(
                                                            width: 2,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("Cerrar")),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {});

                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Crear')),
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
                              .others!;
                        });
                      }
                    },
                  )
*/
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
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
                                            String nameScene=newNameSceneController.text;
                                            Scene auxScene=Scene(imageList: [], name: nameScene, slug: slugify(nameScene));
                                            context.read<TourProvider>().addOtherScene(scene: auxScene, floorKey: pisoSelec);
                                            Navigator.pop(context);
                                          });

                                        },
                                        child: const Text('Crear'))
                                  ],
                                )
                              ],
                            ));
                          });


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

                            _navigateAddImageAndReturn(context,scenes.keys.toList()[index],widget.floorSlug);
                            setState(() {
                            });
                          },
                          child: Stack(

                            children: [
                              Positioned(
                                right: 0,
                                top: 0,
                                child:numScenesButton(scenes.values.toList()[index].imageList.length),

                              ),
                              Center(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      /*Expanded(*/
                                      Icon(Icons.dashboard,
                                          size: 30, color: colorsApp['iconColor']),
                                      /*),*/
                                      Padding(
                                          padding:
                                              const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          child: Text(
                                              scenes.values.toList()[index].name,
                                              style: const TextStyle(fontSize: 16))),
                                    ]),
                              ),
                            ],
                          ),
                        ));
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget numScenesButton(int n){
    //print('numero de escenas en '+widget.floor.slug! +'en la escena '+widget.sceneInTour.slug+' es :'+n.toString());
    if(n>0){
      setState(() {

      });
      return  Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(n.toString())));
    }else{
      setState(() {

      });
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

  Future _navigateAddImageAndReturn(BuildContext context, String sceneKey, String floorKey) async {
    //TourProvider watch = context.watch<TourProvider>();
    Object? imageFileList;
    try{
      Scene scene= context.read<TourProvider>().newTour.floors![floorKey]!.others![sceneKey]!;
      imageFileList = await Navigator.pushNamed(context, '/toursDisponibles/agregarEscena',arguments:{"sceneName":scene.name, 'imageList':scene.imageList});
      print(scene.imageList.length.toString());
    }
    catch(e){
      print('error al recuperar las escenas de "otros" '+e.toString());
    }

    if(imageFileList != null){
      imageFileList as List<XFile>;
      context.read<TourProvider>().addImageListOthers(floorKey: floorKey, sceneKey: sceneKey, imageList: imageFileList);
      setState(() {

      });

    }
  }
}
