import 'dart:io';

import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/models/Scene.dart';
import 'package:app_tours/models/Tour.dart';
import 'package:app_tours/models/Vescena.dart';
import 'package:app_tours/models/Vfloor.dart';
import 'package:app_tours/models/Vtour.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:app_tours/widgets/fancy_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:panorama/panorama.dart';

class VisualizerPage extends StatefulWidget {
  Tour? tourSaved;
  VisualizerPage({Key? key, this.tourSaved}) : super(key: key);

  @override
  State<VisualizerPage> createState() => _VisualizerPageState();
}

class _VisualizerPageState extends State<VisualizerPage> {
  late Vtour tourPrueba;
  bool reelVisible = true;
  bool floorsVisible = false;
  String imageInVisualizator = '';
  int scenaIndexSelected = 0;
  int floorIndexSelect = 0;

  @override
  void initState() {
    if (widget.tourSaved == null) {
      Fluttertoast.showToast(msg: 'Mostrando tour de prueba');
      tourPrueba = Vtour('tour prueba', [
        Vfloor('1fl', [
          Vescena('assets/images/0.jpg', 'fachada', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/2.jpg', 'fachada', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.app_registration),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/3.jpg', 'comedor', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/4.jpg', 'comedor', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
        ]),
        Vfloor('2fl', [
          Vescena('assets/images/3.jpg', 'sala', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/4.jpg', 'sala', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/5.jpg', 'estar', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/6.jpg', 'estar', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/3.jpg', 'dormitorio', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/4.jpg', 'dormitorio', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
        ]),
        Vfloor('3fl', [
          Vescena('assets/images/7.jpg', 'cocina', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/8.jpg', 'cocina', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/9.jpg', 'pasillo', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/13.jpg', 'pasillo', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/11.jpg', 'dormitorio', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/12.jpg', 'dormitorio', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
        ]),
        Vfloor('4fl', [
          Vescena('assets/images/13.jpg', 'cocina', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/2.jpg', 'cocina', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/4.jpg', 'dormitorio', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
          Vescena('assets/images/6.jpg', 'dormitorio', [
            Hotspot(
              name: 'hola',
              latitude: 0.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
            Hotspot(
              name: 'hola',
              latitude: 20.0,
              longitude: 0.0,
              widget: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {
                  print('hola');
                },
              ),
            ),
          ]),
        ]),
      ]);
    } else {
      print('entra');
      tourPrueba = Vtour('pr', []);
      widget.tourSaved!.floors!.forEach((keyFloor, Floor floor) {
        Vfloor vpiso = Vfloor(keyFloor, []);
        floor.scenes!.forEach((key, Scene scene) {
          for (var imagen in scene.imageList) {
            Vescena vescena = Vescena(imagen.path, scene.slug, []);
            vpiso.scenas.add(vescena);
          }
        });
        tourPrueba.pisos.add(vpiso);
      });
    }

    try {
      setState(() {
        imageInVisualizator = tourPrueba.pisos[0].scenas[0].path;
      });
    } catch (e) {
      print('Error cargando la imagen en el visualizador');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FancyFab(
        icon: Icons.add,
        onPressed: () {},
        tooltip: '',
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: AppColors.primaryColor),
        child: SafeArea(
          child: Stack(
            children: [
              (imageInVisualizator != '')
                  ? Panorama(
                      onTap: (double longitude, double latitude, double tilt) {
                        //print(longitude.toString());
                        //print(latitude.toString());
                        //print(tilt.toString());
                        Hotspot newHotspot = Hotspot(
                            name: 'new hotspot',
                            latitude: latitude,
                            longitude: longitude,
                            widget: IconButton(
                              icon: const Icon(Icons.link),
                              onPressed: () {
                                Fluttertoast.showToast(msg: 'soy un hotspot');
                              },
                            ));
                        setState(() {
                          tourPrueba.pisos[floorIndexSelect]
                              .scenas[scenaIndexSelected].hotspots
                              .add(newHotspot);
                        });
                      },
                      hotspots: tourPrueba.pisos[floorIndexSelect]
                          .scenas[scenaIndexSelected].hotspots,
                      child: (widget.tourSaved == null)
                          ? Image.asset(imageInVisualizator)
                          : Image.file(
                              File(imageInVisualizator),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ),
                    )
                  : const SizedBox(),
              Center(
                child: Column(
                  children: [
                    Visibility(
                      visible: reelVisible,
                      child: Container(
                          //width: double.infinity,
                          height:
                              MediaQuery.maybeOf(context)!.size.height * 0.3,
                          color: AppColors.primaryColorTransparency,
                          child: GridView.count(
                            childAspectRatio: 2 / 4,
                            scrollDirection: Axis.horizontal,
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0,
                            children: tourPrueba.pisos[floorIndexSelect].scenas
                                .map((Vescena escena) {
                              int index = tourPrueba
                                  .pisos[floorIndexSelect].scenas
                                  .indexOf(escena);

                              return cardImage(escena: escena, index: index);
                            }).toList(),
                          )),
                    ),
                    Container(
                      decoration: ShapeDecoration(
                        color: AppColors.primaryColorTransparency,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              reelVisible = !reelVisible;
                            });
                          },
                          icon: const Icon(Icons.apps)),
                    )
                  ],
                ),
              ),
              floorsList(),
              Positioned(
                top: 200,
                child: Draggable(
                  onDragEnd: (details){
                    print(details.offset.dx);
                    print(details.offset.dy);
                    //VPanoramaState aux = VPanoramaState();
                    //print(aux.handleTapUp(details.offset.dx, details.offset.dy));

                  },
                    child: Container(
                      color: Colors.redAccent,
                      width: 40,
                      height: 40,
                    ),
                    feedback: Container(
                      color: Colors.blueAccent,
                      width: 40,
                      height: 40,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget floorsList() {
    return Positioned(
        top: 20,
        left: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: floorsVisible,
              child: Container(
                height: 200,
                width: 60,
                color: AppColors.primaryColorTransparency,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: tourPrueba.pisos.length,
                    itemBuilder: (BuildContext context, int index) {
                      String pisoNombre = tourPrueba.pisos[index].nombre;

                      return TextButton(
                        style: ButtonStyle(
                            //backgroundColor:  MaterialStateProperty.all<Color>( colorsApp['primaryColor']!),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.zero)),
                        onPressed: () {
                          setState(() {
                            reelVisible = true;
                            floorsVisible = false;
                            floorIndexSelect = index;
                          });
                        },
                        child: Text(
                          pisoNombre,
                          style: (pisoNombre ==
                                  tourPrueba.pisos[floorIndexSelect].nombre)
                              ? const TextStyle(fontSize: 16)
                              : const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 0,
                        )),
              ),
            ),
            RotatedBox(
              quarterTurns: 1,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.primaryColorTransparency),
                ),
                onPressed: () {
                  setState(() {
                    floorsVisible = !floorsVisible;
                  });
                },
                child: const Text(
                  'Niveles',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ));
  }

  Widget cardImage({required Vescena escena, required int index}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        LongPressDraggable(
          feedback: Container(
            child: Card(
                color: Colors.transparent,
                elevation: 15,
                semanticContainer: true,
                //shadowColor: palletFuchsia,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      //width: 10,
                      //color: Colors.greenAccent,
                      ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      setState(() {
                        imageInVisualizator = escena.path;
                        scenaIndexSelected = index;
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(16), // Image radius
                        child: (widget.tourSaved == null)
                            ? Image.asset(escena.path,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high)
                            : Image.file(
                                File(escena.path),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ))),
          ),
          child: Container(
            child: Card(
                color: Colors.transparent,
                elevation: 15,
                semanticContainer: true,
                //shadowColor: palletFuchsia,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: (escena.path == imageInVisualizator)
                      ? const BorderSide(
                          width: 2,
                          color: Colors.blueAccent,
                        )
                      : const BorderSide(color: Colors.transparent),
                ),
                child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      setState(() {
                        imageInVisualizator = escena.path;
                        scenaIndexSelected = index;
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(16), // Image radius
                        child: (widget.tourSaved == null)
                            ? Image.asset(escena.path,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high)
                            : Image.file(
                                File(escena.path),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ))),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Text(
            escena.nombreEscena,
            style:
                TextStyle(backgroundColor: AppColors.primaryColorTransparency),
          ),
        )
      ],
    );
  }
}
