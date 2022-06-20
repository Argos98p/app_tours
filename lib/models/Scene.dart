import 'package:image_picker/image_picker.dart';

class Scene {
  //String name;
  //List<String> imagesPath;
  List<XFile> imageList;

  Scene({ required this.imageList});

  List<String> getPath (){
    List<String> paths=[];
    imageList.forEach((element) {
      paths.add(element.path.toString());

    });
    return paths;
}
/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fachad'] = this.fachad;
    return data;
  }*/
}