import 'package:panorama/panorama.dart';

class Vescena{
  String _path;
  String _nombreEscena;
  List<Hotspot> _hotspots;

  Vescena(this._path, this._nombreEscena, this._hotspots);

  List<Hotspot> get hotspots => _hotspots;

  set hotspots(List<Hotspot> value) {
    _hotspots = value;
  }

  String get nombreEscena => _nombreEscena;

  set nombreEscena(String value) {
    _nombreEscena = value;
  }

  String get path => _path;

  set path(String value) {
    _path = value;
  }
}