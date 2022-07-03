import 'package:app_tours/models/Vfloor.dart';

class Vtour{
  String _nombre;
  List<Vfloor> _pisos;
  Vtour(this._nombre, this._pisos);

  List<Vfloor> get pisos => _pisos;

  set pisos(List<Vfloor> value) {
    _pisos = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }
}