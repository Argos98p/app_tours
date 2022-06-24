import 'package:app_tours/models/Floor.dart';


class Tour {
  String? title;
  String? type;
  Map <String,String>? infoTour;
  //Map<String,Scene>? scenes;
  //Map<String, Floor> floors;
 Map<String,Floor>? floors;

  Tour({this.title, this.infoTour, required this.type, Map<String,Floor>? floors}) : floors=floors ??
      {
        'default':Floor(slug: 'default',scenes: {},name: 'default'),
        'pb':Floor(slug: 'pb',scenes: {},name: 'pb')
      };
/*
  List<String> floorsNames (){
    List<String> nombres=[];
    floors!.forEach((element) {nombres.add(element.name!); });
    return nombres;
  }*/

/*
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

*/

}

