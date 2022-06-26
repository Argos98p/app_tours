
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
      print('error al insertar las imagenes:asdadfad' +e.toString());
    }
  }
  //inserta la lista de imagenes a una escena del tour 'otro'
  Future<void> addImageListSceneOther({required String floorKey, required String sceneKey, required List<XFile> imageList})async {
    //try{
      print(_newTour.floors![floorKey]!.scenes![sceneKey]!.imageList);
      _newTour.floors![floorKey]!.scenes![sceneKey]!.imageList=imageList;
      notifyListeners();
    /*}catch(e){
      print('error al insertar las imagenes:' +e.toString());
    }*/
  }
  Future<Tour> mapToTour({required Map<String, dynamic> tourSaved}) async {
    Tour auxTour = Tour(infoTour: {},title: tourSaved['title'] ,type: tourSaved['type']);
    auxTour.floors={};
    auxTour.infoTour={};

    await Future.forEach(tourSaved['infoTour'].keys, (String element) {
      auxTour.infoTour![element]=tourSaved['infoTour'][element];
    });

    Map<String, dynamic> floorsMap =  Map<String,dynamic>.from(tourSaved['floors']);
    List<String> floorKeys= floorsMap.keys.toList();


    await Future.forEach(floorKeys, (String floorKey) async {
      Floor floor = Floor();
      floor.slug=floorKey;
      floor.name=floorKey;
      floor.scenes={};
      floor.others={};

      Map<String, dynamic> scenesMap = Map<String, dynamic>.from(floorsMap[floorKey]['scenes']);

      await Future.forEach(scenesMap.keys.toList(), (String sceneKey) async {
        Scene scene = Scene(imageList: [], name: sceneKey, slug: sceneKey);
        List<String> imagesFormScene=List<String>.from(scenesMap[sceneKey]);
        await Future.forEach(imagesFormScene, (String imageFilePath)  {
          XFile imageFile = XFile(imageFilePath);
          scene.imageList.add(imageFile);
        });

        floor.scenes![sceneKey]=scene;
      });

      Map<String, dynamic> scenesOthersMap = Map<String, dynamic>.from(floorsMap[floorKey]['others']);

      await Future.forEach(scenesOthersMap.keys.toList(), (String sceneKey) async {
        Scene scene = Scene(imageList: [], name: sceneKey, slug: sceneKey);
        List<String> imagesFormScene=List<String>.from(scenesOthersMap[sceneKey]);
        await Future.forEach(imagesFormScene, (String imageFilePath)  {
          XFile imageFile = XFile(imageFilePath);
          scene.imageList.add(imageFile);
        });

        floor.others![sceneKey]=scene;
      });
      auxTour.floors![floorKey]=floor;
    });
    _newTour=auxTour;
    notifyListeners();
    return auxTour;
  }

  /*
    Future<void> mapToOtherTour({required Map<String, dynamic> tourSaved}) async {
      Floor floor = Floor();
      floor.slug=floorKey;
      floor.name=floorKey;
      floor.scenes={};
      floor.others={};
    }*/

  }