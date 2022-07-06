import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var response= json.decode(prefs.getString(key)!);
      return response;
    } catch (e) {
      return null;
    }
  }

   nextId(String key) async{
    try{
      List tour = await read(key);
      int lastID=tour.last['idTour'];

      return lastID+1;
    }catch(e){
      print('Error al generar el id: '+e.toString());
      return 0;
    }

  }


  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();

   var aux = await read(key);

    if(aux != null){
      aux.add(value);
      prefs.setString(key, jsonEncode(aux));
    }else{
      List aux2= [value];
      prefs.setString(key, json.encode(aux2));
    }
  }

  update(String key, value,int index) async {
    final prefs = await SharedPreferences.getInstance();
    var aux = await read(key);

    if(aux != null){
      aux[index]=value;
      prefs.setString(key, jsonEncode(aux));
    }else{
      List aux2= [value];
      prefs.setString(key, json.encode(aux2));
    }

  }

  remove(String key,int index) async {
    final prefs = await SharedPreferences.getInstance();
    var aux = await read(key);

    if(aux != null){
      aux.removeAt(index);
      prefs.setString(key, json.encode(aux));
    }else{

    }
    //prefs.remove(key);
  }
}