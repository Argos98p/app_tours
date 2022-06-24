import 'package:app_tours/models/Scene.dart';

class Floor{
  String? name;
  String? slug;
  //Map <String,Scene> scenes;
  Map<String,Scene>? scenes;
  Floor({this.scenes, this.slug, this.name});

}