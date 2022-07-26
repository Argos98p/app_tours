import 'dart:io';

import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/utils/SharedPreferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

class Tour {
  String? title;
  String? idTour;
  String? type;

  String? id_server;
  Map<String, String>? infoTour;
  Map<String, Floor>? floors;

  Tour(
      {this.title,
      this.infoTour,
        this.id_server,
      required this.type,
        this.idTour,
      Map<String, Floor>? floors})
      : floors = floors ??
            {
              'Planta_1': Floor(
                  slug: 'Planta_1', scenes: {}, others: {}, name: 'Planta 1'),
            };


  //funcion para actualizar el id_server obtenido en el envio
  Future<Map<String, dynamic>> toMapForUpdate() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    SharedPref sharedPref = SharedPref();
    print('el id local es'+idTour!);
    data['idTour']=idTour;
    print('el id server es '+id_server!);
    data['idTourServer']=id_server;

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

      await Future.forEach(floors![floorKey]!.others!.keys, (sceneKey) async {
        List<String> imagePaths = [];
        await Future.forEach(floors![floorKey]!.others![sceneKey]!.imageList,
                (XFile element) async {
              String newPath = await saveImage(element);
              print(newPath);
              imagePaths.add(newPath);
            });
        data['floors'][floorKey]['others'][sceneKey] = imagePaths;
      });

    });

    print(data.toString());
    return data;
  }



  Future<Map<String, dynamic>> toMap() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    SharedPref sharedPref = SharedPref();

    var aux= await sharedPref.nextId('nuevo_tour');
    idTour=aux.toString();
    print('el id local '+idTour!);
    data['idTour']=idTour;
    if(id_server==null){
      data['idTourServer']='9999';
    }else{
      data['idTourServer']=id_server;
    }

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

      await Future.forEach(floors![floorKey]!.others!.keys, (sceneKey) async {
        List<String> imagePaths = [];
        await Future.forEach(floors![floorKey]!.others![sceneKey]!.imageList,
                (XFile element) async {
              String newPath = await saveImage(element);
              print(newPath);
              imagePaths.add(newPath);
            });
        data['floors'][floorKey]['others'][sceneKey] = imagePaths;
      });

    });

    print(data.toString());
    return data;
  }

  Future<String> saveImage(XFile archivo) async {
    final Directory? directory = await getExternalStorageDirectory();
    String directoryPath = directory!.path;
    final File image = File(archivo.path);
    if(await File("$directoryPath/${Path.basename(image.path)}").exists()){
      return "$directoryPath/${Path.basename(image.path)}";
    }

    final File newImage = await image.copy('$directoryPath/${Path.basename(image.path)}');
    return newImage.path;
  }



}
