import 'package:flutter/cupertino.dart';

class PisosProviders with ChangeNotifier{

  List<String> pisos=['default','agregar'];

  //PisosProviders(this.pisos);

  addPiso(String piso){
    pisos.add(piso);
    notifyListeners();
    //print(pisos);
  }

  getPiso(){
    print(pisos.length.toString());
    return pisos;
  }
}