import 'dart:async';
import 'dart:io';

import 'package:app_tours/pages/take_picks/TourCamera.dart';
import 'package:app_tours/pages/take_picks/camera_screen2.dart';
import 'package:camera/camera.dart';
import 'package:app_tours/pages/viewer360Page.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddImagePage extends StatefulWidget {
  String sceneName;
  List<XFile> imageList;
  AddImagePage({Key? key, required this.sceneName, required this.imageList})
      : super(key: key);

  @override
  State<AddImagePage> createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  List<XFile>? imageFileList = [];
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    imageFileList = widget.imageList;
    TourProvider watch = context.watch<TourProvider>();
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              //Text('Tour id: ${_idTour}'),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Agregar fotos de ' + widget.sceneName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Puede elegir multiples imagenes'),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => selectImages(),
                    icon: const Icon(Icons.image),
                    label: const Text('Galeria'),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        fixedSize: const Size(140, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => takePhotos(),
                    icon: const Icon(Icons.add_a_photo),
                    label: const Text('Camara'),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        fixedSize: const Size(140, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: imageFileList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(3),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                print('tap image');
                              },
                              child: Image.file(
                                File(imageFileList![index].path),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Center(
                              child: ElevatedButton(
                                child: const Text('ver'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Viewer360Page(
                                              pathImage:
                                                  imageFileList![index].path)));
                                },
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: InkWell(
                                child: const Icon(
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
                  child: const Text('agregar')),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    Completer<Size> completer = Completer();
    List<XFile> validImages = [];
    if (selectedImages != null) {
      await Future.forEach(selectedImages, (XFile imageInList) async {
        Image image = Image.file(File(imageInList.path));
        var size = await _calculateImageDimension(image);
        if (size.width == size.height * 2) {
          validImages.add(imageInList);
        } else {
          Fluttertoast.showToast(msg: 'La imagen debe ser de realacion 2:1');
        }
      });
      imageFileList!.addAll(validImages);
    }
    setState(() {});
  }

  void takePhotos() async {
    // HapticFe// Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // // Get a specific camera from the list of available cameras.
    // final firstCamera = cameras.first;
    List<XFile> validImages = [];

    final XFile newPhoto = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CameraScreen2(
              cameras: cameras,
              iduser: '1',
              idtour: '52',
              img: 'test',
              scene: 'fac',
            )));
    // Image image = Image.file(File(newPhoto.path));
    validImages.add(newPhoto);
    imageFileList!.addAll(validImages);
    setState(() {});
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
}
