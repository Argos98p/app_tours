
import 'package:app_tours/models/Tour.dart';
import 'package:flutter/foundation.dart';


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
  /*
  Future<void> addFloor({required Floor newfloor})async{
    _newTour.floors!.add(newfloor);
  }*/


/*
  Future<void> setListScenes({required String slug_scene,required List<XFile> images}) async{
    Scene escena = Scene(imageList:images);
    _newTour.scenes![slug_scene]=escena;
  }*/
}