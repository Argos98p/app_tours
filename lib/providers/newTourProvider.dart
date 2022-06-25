
import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/models/Scene.dart';
import 'package:app_tours/models/Tour.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slugify/slugify.dart';


class TourProvider with ChangeNotifier{
  Tour _newTour = Tour(infoTour: {},title: '' ,type: '');
  Tour get newTour => _newTour;

  Future<void> cancelTour() async{
    _newTour = Tour(infoTour: {},title: '' ,type: '');
  }



  Future<void> setTour({required Tour tour})async {
    _newTour=tour;
    notifyListeners();
  }
  Future<void> setInfoTour({required Map <String,String> infoTour} ) async{
    _newTour.infoTour=infoTour;
  }
  Future<void> setType({required String typeTour} ) async{
    _newTour.type=typeTour;
  }

  Future<void> addOtherScene({required Scene scene,required String floorKey})async{
    _newTour.floors![floorKey]!.others![scene.slug]=scene;
    notifyListeners();

  }
  Future<void> addScene({required Scene scene,required String floorKey})async{
    _newTour.floors![floorKey]!.scenes![scene.slug]=scene;
    notifyListeners();
  }

  Future<void> addFloor({required String nameFloor}) async {
    Floor newFloor=Floor(scenes: {},slug: slugify(nameFloor),name:nameFloor );
    _newTour.floors![slugify(nameFloor)]=newFloor;
    notifyListeners();
  }

  //inserta la lista de imagenes a la escena 'otros' de los tours conocidos(restaurant, casa, comercio)
  Future<void> addImageListOthers({required String floorKey, required String sceneKey, required List<XFile> imageList})async {
    try{
    _newTour.floors![floorKey]!.others![sceneKey]!.imageList=imageList;
    notifyListeners();
    }catch(e){
      print('error al insertar las imagenes:' +e.toString());
    }
  }
  //inserta la lista de imagenes a una escena del tour 'otro'
  Future<void> addImageListSceneOther({required String floorKey, required String sceneKey, required List<XFile> imageList})async {
    try{
      _newTour.floors![floorKey]!.scenes![sceneKey]!.imageList=imageList;
      notifyListeners();
    }catch(e){
      print('error al insertar las imagenes:' +e.toString());
    }
  }

  }