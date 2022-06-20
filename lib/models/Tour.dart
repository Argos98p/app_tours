import 'dart:convert';

import 'package:app_tours/models/Scene.dart';

class Tour {
  String? title;
  String? type;
  Map <String,String>? infoTour;
  Map<String,Scene>? scenes;

  Tour({this.title, this.infoTour, this.scenes, required this.type});

  Map<String,dynamic> toMap(){
    final Map<String,dynamic> data=  Map<String, dynamic>();
    data['title']=infoTour!['titulo'];
    data['type']=type;
    data['infoTour']=infoTour;
    data['scenes']={};
    List<String> sceneskeys= scenes!.keys.toList(); //fachada, puerra, baaño,etc
    
    scenes!.forEach((key,  value) {
      data['scenes'][key]=[];
      List aux= [];
      value.imageList.forEach((element) {
        aux.add(element.path.toString());
      });
      data['scenes'][key]=aux;
    });
    /*
    for(var i=0;i<sceneskeys.length;i++){
      List imagesInScenes=[];
      for(var j=0;j<scenes![sceneskeys[i]]!.imageList.length;i++){
        imagesInScenes.add(scenes![sceneskeys[i]]!.imageList[j].path.toString());
      }

      data[sceneskeys[i]]=imagesInScenes;
    }*/
    print(json.encode(data));
    return data;
  }



}

