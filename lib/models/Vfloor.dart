import 'package:app_tours/models/Vescena.dart';

class Vfloor{
String _nombre;
List<Vescena> _scenas;

Vfloor(this._nombre, this._scenas);

List<Vescena> get scenas => _scenas;

  set scenas(List<Vescena> value) {
    _scenas = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

/*
  Map<String,List<Vimagen>> imgObjEnPiso(){
    Map<String,List<Vimagen>> imagenesPiso={};
    _escenas.forEach((Vescena escena) {
      imagenesPiso[escena.name]=escena.imagenesEnEscena;
    });
    return imagenesPiso;
  }*/
}