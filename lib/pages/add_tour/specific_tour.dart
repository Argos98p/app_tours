import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/models/Scene.dart';
import 'package:app_tours/models/Tour.dart';
import 'package:app_tours/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SpecificTour extends StatefulWidget {
  Tour tour;
  int indexTour;
  SpecificTour({Key? key, required this.tour, required this.indexTour}) : super(key: key);

  @override
  State<SpecificTour> createState() => _SpecificTourState();

  SharedPref sharedPref = SharedPref();
}

class _SpecificTourState extends State<SpecificTour> {
  final _storage = const FlutterSecureStorage();


  String idusuario = '';
  String baseUrlApi = 'http://redpanda.sytes.net:8083/api/tours';
  String token = '';

  SharedPref sharedPref = SharedPref();

  Future<void> _readFromStorage() async {
    idusuario=(await _storage.read(key: "user_id"))!;
    token = (await _storage.read(key: "accessToken"))!;
  }
  @override
  void initState(){
    super.initState();
    _readFromStorage();

  }

  @override
  Widget build(BuildContext context) {

    Fluttertoast.showToast(msg: 'pagina para pruebas');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.tour.title!,
              style: const TextStyle(fontSize: 26),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                sendTourToServer(widget.tour);
              },
              child: const Text('Enviar al server')),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurpleAccent)),
              onPressed: () {
                Navigator.pushNamed(context, '/toursDisponibles/${widget.tour.type}',arguments:{"formData":widget.tour.infoTour, "case":true, "index":widget.indexTour} );
              },
              child: const Text('Editar')),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
              onPressed: () {},
              child: const Text('Borrar'))
        ]),
      ),
    );
  }

  Future<void> sendTourToServer(Tour tour) async {
    String id = await createTour(tour);

    if (id != '') {
      //print('ID TOUR CREADO: ' + id);
      await createScenes(tour, id);
      //print('TOUR CREADO CON EL ID: ${id}');
      tour.id_server=id;
      sharedPref.update('nuevo_tour', await tour.toMapForUpdate(),widget.indexTour);
    }else{
      Fluttertoast.showToast(msg: 'Error en el server');
    }
  }

  Future<void> createScenes(Tour tour, id) async {
    try{
    await Future.forEach(tour.floors!.keys, (String floorKey) async {
      Floor floor = tour.floors![floorKey]!;

      await Future.forEach(floor.scenes!.keys, (String sceneKey) async {
        Scene scene = floor.scenes![sceneKey]!;
        String nombreescena = floor.name! + '_' + scene.name;
        var url = baseUrlApi +
            "/newscene/?idtour=$id&nombreescena=$nombreescena&planta=${floor.name}&token=$token&idusuario=$idusuario";

        var response = await http.post(Uri.parse(url));
        print(response.body);

        if (response.body == "0") {
          print('ESCENA CREADA');

          int aux = 0;

          await Future.forEach(scene.imageList, (XFile image) async {
            String nombreimagen = id +
                '_' +
                aux.toString() +
                '_' +
                nombreescena +
                '#' +
                image.name;

            var url = baseUrlApi +
                '/newimagescene/?token=$token&idusuario=$idusuario&idtour=$id&nombreescena=$nombreescena&nombreimagen=$nombreimagen';
            print('url imagen escena ' + nombreimagen);
            var responseEscena = await http.post(Uri.parse(url));
            if (responseEscena.statusCode == 200) {
              print(
                  'Creando scena de imagen: ' + responseEscena.body.toString());
              String urlImageUpload = baseUrlApi +
                  "/save360/?token=$token&idusuario=$idusuario&idtour=$id&nombreescena=$nombreescena&imagen=$nombreimagen";
              print("url imagen archivo " + urlImageUpload);
              var request =
                  http.MultipartRequest('POST', Uri.parse(urlImageUpload));
              request.files
                  .add(await http.MultipartFile.fromPath('file', image.path));
              var uploadImageStatus = await request.send();
              final respStr = await uploadImageStatus.stream.bytesToString();
              print('codigo de la subida de imagenes: ' + respStr);
              aux++;
            }
          });
        } else {}
      });
    });
    Fluttertoast.showToast(msg: 'Tour creado con el id:'+id);
    }
    catch (e){
      Fluttertoast.showToast(msg: 'a ocurrido un problema '+e.toString());
    }
  }

  Future<String> createTour(Tour tour) async {

    try {
      var url = baseUrlApi +
          "/addtour/?token=$token&titulo=${tour.title}&ciudad=${tour.infoTour!['ciudad']}&direccion=${tour.infoTour!['direccion']}&idusuario=$idusuario";
      print(url);
      var response = await http.post(Uri.parse(url));
      var idSavedTour = response.body.split('=').last;
      Fluttertoast.showToast(msg: 'Subiendo tour...');

      if(response.statusCode==200){
        return idSavedTour;
      }else{
        print(response.body);
        return '';
      }

    } catch (e) {
      print('¡Error al crear el tour:' +
          e.toString());
      return '';
    }
  }
}
