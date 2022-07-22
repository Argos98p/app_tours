import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:app_tours/pages/viewer360Page.dart';
import 'dart:io';
class SelectImages extends StatefulWidget {
  String typeTour;
  Map<String, String> infoTour;
  bool updateTour;
  int indexTour;

  SelectImages({Key? key, required this.typeTour, required this.infoTour, required this.indexTour, required this.updateTour}) : super(key: key);

  @override
  State<SelectImages> createState() => _SelectImagesState();

}

class _SelectImagesState extends State<SelectImages> {

  List<XFile>? imageFileList = [];
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: (){
                  selectImages();
                },
                child: const Text('Selecionar Imagen')),
            ElevatedButton(
                onPressed: (){},
                child: const Text('Capturar')),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: imageFileList!.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(3),
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  print('tap image');
                                  Navigator.push(context, MaterialPageRoute(builder:(context)=>Viewer360Page(pathImage: imageFileList![index].path)));
                                },
                                child: Image.file(
                                  File(imageFileList![index].path),
                                  filterQuality : FilterQuality.high,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Positioned(
                                right: 0,
                                top: 0,
                                child: InkWell(
                                  child: const Icon(
                                    Icons.remove_circle,
                                    size: 35,
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
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context,'/toursDisponibles/${widget.typeTour}',arguments: { 'formData': widget.infoTour,'case': false,'index': 999, 'imageList':imageFileList
              });
            }, child: const Text('Clasificar fotos'))
          ],
        ),
      ),
    );
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
    print(imageFileList);
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
