import 'dart:async';
import 'dart:io';

import 'package:app_tours/initalConfigurations/ScenesTourModel.dart';
import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/initalConfigurations/TourAvaliable.dart';
import 'package:app_tours/models/ReelImage.dart';
import 'package:app_tours/pages/add_tour/add_tour_main_page.dart';
import 'package:app_tours/providers/imagesInReelProvider.dart';
import 'package:basic_utils/basic_utils.dart' as utils;
import 'package:app_tours/pages/add_tour/FloorScenesPage.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:app_tours/utils/SharedPreferences.dart';

import 'package:image_picker/image_picker.dart';
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
      required this.indexTour,
        })
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
  //late List<ReelImage> imagesInReel;
  final FocusNode dropDownFocus = FocusNode();

  List<XFile>? imageFileListSelect = [];
  final ImagePicker imagePicker = ImagePicker();
  List<ScenesInTourModel> scenes = [];
  Map<String, FloorScenesPage> floorScafold = {};

  @override
  void initState() {
    super.initState();
    //imagesInReel=[];
    //imagesToSort=[];
  }



  @override
  Widget build(BuildContext context) {
    context.read<TourProvider>().setInfoTour(infoTour: widget.infoTour);
    context.read<TourProvider>().setType(typeTour: widget.typeTour);
    pisos = context.read<TourProvider>().newTour.floors!;
    //imagesInReel=context.read<ImagesInReelProvider>().imagesInReel;

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
                      'Escenas ' + utils.StringUtils.capitalize(widget.typeTour),
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

                                                                    setState(
                                                                        () {

                                                                      context.read<TourProvider>().renameFloor(newName: newNameController.text, oldName: pisos.keys.toList().elementAt(index));
                                                                      pisos = context.read<TourProvider>().newTour.floors!;

                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: 'Nivel renombrado');
                                                                      Navigator.pop(
                                                                          context);

                                                                      /*context.read<TourProvider>().updateInfoTourInput(keyInput: 'tipo_aux', newValue: newNameController.text);
                                                              Navigator.pop(context);
                                                              widget.infoTour['tipo_aux']=newNameController.text;*/
                                                                      pisoSelec =slugify(newNameController.text,delimiter: '_',lowercase: false);
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
                                            icon: const Icon(Icons.edit))
                                        :const SizedBox(width: 0,height: 0,),
                                        Text(pisos.keys
                                            .toList()
                                            .elementAt(index).replaceAll('_', ' '))
                                      ],
                                    ),
                                    value: pisos.keys.toList().elementAt(index))
                                : DropdownMenuItem(
                                    child: TextButton(
                                      child: const Text('Agregar'),
                                      onPressed: () {
                                        setState(() {});
                                        _dialogAddFloor();

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
              Consumer<ImagesInReelProvider>(builder: (context, pop,_){
     return  SizedBox(
        height: MediaQuery.maybeOf(context)!.size.height*0.15,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: pop.imagesInReel.length+1,
          itemBuilder: (BuildContext context, index){
            if (index<pop.imagesInReel.length){
              return LongPressDraggable(
                onDragCompleted: (){
                  //print(imagesInReel[index].image.path);
                  setState(() {
                    if(getSelectedImages().isNotEmpty){
                      context.read<ImagesInReelProvider>().imagesInReel.removeWhere((ReelImage element) => (element.selected));
                    }else{
                      context.read<ImagesInReelProvider>().imagesInReel.removeAt(index);
                    }
                    //context.read<ImagesInReelProvider>().imagesInReel=imagesInReel;
                  });
                },
                data: (getSelectedImages().isNotEmpty)
                    ?getSelectedImages()
                    :context.read<ImagesInReelProvider>().imagesInReel[index],
                feedback: (getSelectedImages().isNotEmpty)
                    ?CircleAvatar(
                  child: Text(getSelectedImages().length.toString()),)
                    :SizedBox(
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8), // Image border
                    child: SizedBox.fromSize(
                        size: const Size.fromRadius(16), // Image radius
                        child: Image.file(
                          File(context.read<ImagesInReelProvider>().imagesInReel[index].image.path),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill,
                        )

                    ),
                  ),
                )
                ,
                child: Container(
                  //height: MediaQuery.maybeOf(context)!.size.height*0.1,
                  width: 200,
                  decoration: (pop.imagesInReel[index].selected)
                      ?BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.green,
                      ), borderRadius: const BorderRadius.all(Radius.circular(8))
                  )
                      :BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.transparent,
                      ), borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),

                  child: InkWell(

                    onTap: (){
                      setState(() {
                        pop.imagesInReel[index].selected=!context.read<ImagesInReelProvider>().imagesInReel[index].selected;
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Image border
                      child: SizedBox.fromSize(
                          size: const Size.fromRadius(16), // Image radius
                          child: Image.file(
                            File(pop.imagesInReel[index].image.path),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fill,
                          )

                      ),
                    ),
                  ),
                ),
              );

            }else{
              return Container(
                  margin: const EdgeInsets.symmetric(vertical: 35,horizontal: 15),
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                  child: IconButton(onPressed: (){
                    selectImages();
                  }, icon: const Icon(Icons.add)));
            }
          }, separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 10,);
        },
        ),

      );
              }),

              Expanded(child: floorScafold[pisoSelec]!),
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

                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AddTourMainPage()), (route) => false);
                        
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
              controller: floorNameController,
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
                        floorNameSlug = slugify(floorName, delimiter: '_',lowercase: false);
                        floorNameController.text = '';

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

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    Completer<Size> completer = Completer();
    List<XFile> validImages=[];
    if (selectedImages != null)  {
      await Future.forEach(selectedImages, (XFile imageInList) async {
        Image image = Image.file(File(imageInList.path));
        var size= await _calculateImageDimension(image);
        if(size.width==size.height*2){
          validImages.add(imageInList);
        }else{
          Fluttertoast.showToast(msg: 'La imagen debe ser de realacion 2:1');
        }
      });
      imageFileListSelect!.addAll(validImages);
    }
    setState(() {
      if(imageFileListSelect!=null){
        for (var element in imageFileListSelect!) {context.read<ImagesInReelProvider>().imagesInReel.add(ReelImage(image: element, selected: false));}
        imageFileListSelect=[];
        //context.read<ImagesInReelProvider>().imagesInReel = context.read<ImagesInReelProvider>().imagesInReel;

      }
    });

  }

  Future<Size> _calculateImageDimension(Image image) {
    Completer<Size> completer = Completer();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }

  List<ReelImage> getSelectedImages(){
    return context.read<ImagesInReelProvider>().imagesInReel.map(
            (ReelImage image){
          if(image.selected)
          {return image;}
        }
    ).toList().whereType<ReelImage>().toList();
  }
}
