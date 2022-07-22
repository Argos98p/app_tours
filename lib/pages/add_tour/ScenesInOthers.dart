import 'dart:async';
import 'dart:io';

import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/models/ReelImage.dart';
import 'package:app_tours/models/Scene.dart';
import 'package:app_tours/providers/imagesInReelProvider.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  late List<ReelImage> imagesInReel;
  @override
  void initState(){
    super.initState();
    pisoSelec = widget.floorSlug;
    imagesInReel=[];
  }

  List<XFile>? imageFileListSelect = [];
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    TourProvider watch = context.watch<TourProvider>();
    Map<String, Floor> pisos = context.read<TourProvider>().newTour.floors!;
    imagesInReel=context.read<ImagesInReelProvider>().imagesInReel;
    Map<String, Scene> scenes =
        context.read<TourProvider>().newTour.floors![pisoSelec]!.others!;

    TextEditingController newNameSceneController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, ),
          onPressed: (){ Navigator.of(context).pop('j');
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
              SizedBox(
                height: MediaQuery.maybeOf(context)!.size.height*0.15,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: imagesInReel.length+1,
                  itemBuilder: (BuildContext context, index){
                    if (index<imagesInReel.length){
                      return LongPressDraggable(
                        onDragCompleted: (){
                          //print(imagesInReel[index].image.path);
                          setState(() {
                            if(getSelectedImages().isNotEmpty){
                              imagesInReel.removeWhere((ReelImage element) => (element.selected));
                            }else{
                              imagesInReel.removeAt(index);
                            }
                            context.read<ImagesInReelProvider>().setImagesInReel(imagesInReel);
                            //context.read<ImagesInReelProvider>().imagesInReel=imagesInReel;


                          });
                        },
                        data: (getSelectedImages().isNotEmpty)
                            ?getSelectedImages()
                            :imagesInReel[index],
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
                                  File(imagesInReel[index].image.path),
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
                          decoration: (imagesInReel[index].selected)
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

                                imagesInReel[index].selected=!imagesInReel[index].selected;


                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8), // Image border
                              child: SizedBox.fromSize(
                                  size: const Size.fromRadius(16), // Image radius
                                  child: Image.file(
                                    File(imagesInReel[index].image.path),
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

              ),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  padding: const EdgeInsets.all(10),
                  children: List.generate(scenes.keys.length, (index) {
                    return DragTarget(
                      onWillAccept: (data)=>true,
                      onAccept: (dynamic data){
                        if(data.runtimeType == List<ReelImage>){
                          data.map((e) =>
                              context.read<TourProvider>().newTour.floors![widget.floorSlug]!.others!.values.toList()[index].imageList.add(e.image)
                          ).toList();
                        }else{
                          context.read<TourProvider>().newTour.floors![widget.floorSlug]!.others!.values.toList()[index].imageList.add(data.image);
                        }


                      },
                      builder: (BuildContext context,
                          List<Object?> candidateData,
                          List<dynamic> rejectedData) {
                        return CardItem(scenes, index);
                      },

                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CardItem(scenes, index){
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
  }
  Widget numScenesButton(int n){
    //print('numero de escenas en '+widget.floor.slug! +'en la escena '+widget.sceneInTour.slug+' es :'+n.toString());
    if(n>0){

      return  Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(n.toString())));
    }else{

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
    //try{
      Scene scene= context.read<TourProvider>().newTour.floors![floorKey]!.others![sceneKey]!;
      imageFileList = await Navigator.pushNamed(context, '/toursDisponibles/agregarEscena',arguments:{"sceneName":scene.name, 'imageList':scene.imageList});
      print(scene.imageList.length.toString());
    //}
    //catch(e){
     // print('error al recuperar las escenas de "otros" '+e.toString());
    //}

    if(imageFileList != null){
      imageFileList as List<XFile>;
      context.read<TourProvider>().addImageListOthers(floorKey: floorKey, sceneKey: sceneKey, imageList: imageFileList);
      setState(() {
      });

    }
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
        for (var element in imageFileListSelect!) {imagesInReel.add(ReelImage(image: element, selected: false));}
        imageFileListSelect=[];
        context.read<ImagesInReelProvider>().imagesInReel = imagesInReel;
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
    return imagesInReel.map(
            (ReelImage image){
          if(image.selected)
          {return image;}
        }
    ).toList().whereType<ReelImage>().toList();
  }
}
