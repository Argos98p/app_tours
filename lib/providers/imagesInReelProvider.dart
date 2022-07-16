import 'package:app_tours/models/ReelImage.dart';
import 'package:flutter/material.dart';
class ImagesInReelProvider with ChangeNotifier{

  List <ReelImage> _imagesInReel = [];

  List<ReelImage> get imagesInReel => _imagesInReel;

  set imagesInReel(List<ReelImage> value) {
    _imagesInReel = value;
    notifyListeners();
  }

  void setImagesInReel(List<ReelImage> value) {
    _imagesInReel = value;
    notifyListeners();
  }

  void addImage(ReelImage image){
    _imagesInReel.add(image);
    notifyListeners();
  }


  void removeImageWithIndex(int index){
    _imagesInReel.removeAt(index);
    notifyListeners();
  }

  void removeImageWithValue(ReelImage value){
    _imagesInReel.remove(value);
    notifyListeners();
  }





}