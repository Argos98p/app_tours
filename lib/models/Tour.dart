import 'dart:io';

import 'package:app_tours/models/Floor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

class Tour {
  String? title;
  String? type;
  Map<String, String>? infoTour;
  Map<String, Floor>? floors;

  Tour(
      {this.title,
      this.infoTour,
      required this.type,
      Map<String, Floor>? floors})
      : floors = floors ??
            {
              'default': Floor(
                  slug: 'default', scenes: {}, others: {}, name: 'default'),
            };

/*
  List<String> floorsNames (){
    List<String> nombres=[];
    floors!.forEach((element) {nombres.add(element.name!); });
    return nombres;
  }*/

  Future<Map<String, dynamic>> toMap() async {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = infoTour!['titulo'];
    data['type'] = type;
    data['infoTour'] = infoTour;
    data['floors'] = {};
    //List<String> floorKeys = floors!.keys.toList(); //fachada, puerra, baaño,etc

    await Future.forEach(floors!.keys, (String floorKey) async {
      data['floors'][floorKey] = {};
      data['floors'][floorKey]['scenes'] = {};
      data['floors'][floorKey]['others'] = {};

      await Future.forEach(floors![floorKey]!.scenes!.keys, (sceneKey) async {
        List<String> imagePaths = [];
        await Future.forEach(floors![floorKey]!.scenes![sceneKey]!.imageList,
            (XFile element) async {
          String newPath = await saveImage(element);
          print(newPath);
          imagePaths.add(newPath);
        });
        data['floors'][floorKey]['scenes'][sceneKey] = imagePaths;
      });
    });

    print(data.toString());
    return data;
  }

  Future<String> saveImage(XFile archivo) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    String directoryPath = directory.path;
    final File image = File(archivo.path);
    final String imageName = Path.basename(image.path);
    final File newImage = await image.copy('$directoryPath/$imageName');
    return newImage.path;
  }



}
