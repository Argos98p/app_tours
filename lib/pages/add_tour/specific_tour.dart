import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/models/Scene.dart';
import 'package:app_tours/models/Tour.dart';
import 'package:app_tours/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SpecificTour extends StatefulWidget {
  Tour tour;
  SpecificTour({Key? key, required this.tour}) : super(key: key);

  @override
  State<SpecificTour> createState() => _SpecificTourState();
}

class _SpecificTourState extends State<SpecificTour> {
  String idusuario = '5';
  String baseUrlApi = 'http://redpanda.sytes.net:8083/api/tours';
  String token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyaWNhcmRvLmphcnJvIiwiaWF0IjoxNjU3MTQzNDQ1LCJleHAiOjE2NTcyMjk4NDV9.7hTAjZDj5MnQghXNXCA_J2l6PyvZXi3Ji9kskO_2fhhpcsOKIdt02gcNsF0B_Cr3V8LmrN-QoI0DivP_M_VgJg';

  SharedPref sharedPref = SharedPref();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.tour.title!,
              style: TextStyle(fontSize: 26),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                sendTourToServer(widget.tour);
              },
              child: Text('Enviar al server')),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent)
            ),
              onPressed: () {

              },
              child: Text('Editar')),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.redAccent)
            ),
              onPressed: (){}, child: Text('Borrar'))
        ]),
      ),
    );
  }

  Future<void> sendTourToServer(Tour tour) async {
    String id = await createTour(tour);
    print(id);
    await createScenes(tour, id);
  }

  Future<void> createScenes(Tour tour, id) async {
    await Future.forEach(tour.floors!.keys, (String floorKey) async {
      Floor floor = tour.floors![floorKey]!;

      await Future.forEach(floor.scenes!.keys, (String sceneKey) async {
        Scene scene = floor.scenes![sceneKey]!;
        String nombreescena = floor.name! + '_' + scene.name;
        var url = baseUrlApi +
            "/newscene/?idtour=${id}&nombreescena=${nombreescena}&planta=${floor.name}&token=$token&idusuario=$idusuario";

        var response = await http.post(Uri.parse(url));
        print(response.body);

        if (response.body == "0") {
          print('Escena creada');

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
            var response = await http.post(Uri.parse(url));
            print('Creando scena de imagen: ' + response.body.toString());

            String urlImageUpload = baseUrlApi +
                "/save360/?token=$token&idusuario=$idusuario&idtour=$id&nombreescena=$nombreescena&imagen=$nombreimagen";
            print("url imagen archivo " + urlImageUpload);
            var request =
                http.MultipartRequest('POST', Uri.parse(urlImageUpload));
            request.files
                .add(await http.MultipartFile.fromPath('file', image.path));
            var uploadImageStatus = await request.send();
            final respStr = await uploadImageStatus.stream.bytesToString();
            print('codigo de la subida de imagenes: ' +
                respStr);
            aux++;
          });
        } else {}
      });
    });
  }

  Future<String> createTour(Tour tour) async {
    var url = baseUrlApi +
        "/addtour/?token=$token&titulo=${tour.title}&ciudad=${tour.infoTour!['ciudad']}&direccion=${tour.infoTour!['direccion']}&idusuario=$idusuario";

    var response = await http.post(Uri.parse(url));
    var idSavedTour = response.body.split('=').last;
    return idSavedTour;
  }
}
