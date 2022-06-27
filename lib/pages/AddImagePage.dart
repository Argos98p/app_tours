
import 'dart:async';
import 'dart:io';

import 'package:app_tours/initalConfigurations/ScenesTourModel.dart';
import 'package:app_tours/models/Scene.dart';
import 'package:app_tours/pages/viewer360Page.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddImagePage extends StatefulWidget {
  String sceneName;
  List<XFile> imageList;
  AddImagePage({Key? key, required this.sceneName, required this.imageList}) : super(key: key);

  @override
  State<AddImagePage> createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  List<XFile>? imageFileList = [];
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    imageFileList=widget.imageList;
    TourProvider watch = context.watch<TourProvider>();
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              //Text('Tour id: ${_idTour}'),
              SizedBox(
                height: 10,
              ),
              Text(
                'Agregar fotos de ' + widget.sceneName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Puede elegir multiples imagenes'),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => selectImages(),
                    icon: Icon(Icons.image),
                    label: Text('Galeria'),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        fixedSize: const Size(140, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => {},
                    icon: Icon(Icons.add_a_photo),
                    label: Text('Camara'),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        fixedSize: const Size(140, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )
                ],
              ),

              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: imageFileList!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(3),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                print('tap image');
                              },
                              child: Image.file(
                                File(imageFileList![index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Center(
                              child: ElevatedButton(
                                child: Text('ver'),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder:(context)=>Viewer360Page(pathImage: imageFileList![index].path)));
                                      
                                },
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: InkWell(
                                child: Icon(
                                  Icons.remove_circle,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  setState(() {
                                    imageFileList!.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )),

              ElevatedButton(
                  onPressed: () {
                    //context.read<TourProvider>().setListScenes(slug_scene: widget.scene.slug, images: imageFileList!);
                    //print( context.read<TourProvider>().newTour.scenes![widget.scene.slug]!.imageList.length);
                    Navigator.pop(context, imageFileList);
                  },
                  child: Text('agregar')),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
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
      imageFileList!.addAll(validImages);
    }
    setState(() {});
  }

  Future<Size> _calculateImageDimension(Image image) {
    Completer<Size> completer = Completer();
    image.image.resolve(ImageConfiguration()).addListener(
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
}
