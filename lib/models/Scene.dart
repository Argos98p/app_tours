import 'package:image_picker/image_picker.dart';

class Scene {
  String name;
  String slug;
  //List<String> imagesPath;
  List<XFile> imageList;

  Scene({ required this.imageList, required this.name, required this.slug});

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