import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/models/Scene.dart';
import 'package:app_tours/models/Tour.dart';
import 'package:app_tours/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SpecificTour extends StatefulWidget {
  Tour tour;
  SpecificTour({Key? key, required this.tour}) : super(key: key);

  @override
  State<SpecificTour> createState() => _SpecificTourState();
}

class _SpecificTourState extends State<SpecificTour> {
  String idusuario='5';
  String baseUrlApi ='http://redpanda.sytes.net:8083/api/tours';
  String token='eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyaWNhcmRvLmphcnJvIiwiaWF0IjoxNjU3MTQzNDQ1LCJleHAiOjE2NTcyMjk4NDV9.7hTAjZDj5MnQghXNXCA_J2l6PyvZXi3Ji9kskO_2fhhpcsOKIdt02gcNsF0B_Cr3V8LmrN-QoI0DivP_M_VgJg';


  SharedPref sharedPref = SharedPref();
  @override
  Widget build(BuildContext context) {
    print(widget.tour.title!.toString());
    return Scaffold(
      appBar: AppBar(),
      body: Column(

        children:[
          Padding(

            padding: const EdgeInsets.all(8.0),
            child: Text(widget.tour.title!, style: TextStyle(fontSize: 26),),
          ),
          ElevatedButton(onPressed: (){
            sendTourToServer(widget.tour);
          }, child: Text('Enviar'))
        ]

      ),
    );
  }

  Future<void> sendTourToServer(Tour tour) async {
    String id=await createTour(tour);
    print(id);
    await createScenes(tour, id);

  }

  Future <void> createScenes(Tour tour, id) async {

    await Future.forEach(tour.floors!.keys, (String floorKey) async {
      Floor floor = tour.floors![floorKey]!;

      await Future.forEach(floor.scenes!.keys, (String sceneKey) async {
        Scene scene = floor.scenes![sceneKey]!;
        String nombreescena= floor.name!+scene.name;
        var url = baseUrlApi +"/newscene/?idtour=${id}&nombreescena=${nombreescena}&planta=${floor.name}&token=$token&idusuario=$idusuario";

        var response = await http.post(Uri.parse(url));
        print(response.body);

        if(response.body == "0"){
          print('Escena creada');
          await Future.forEach(scene.imageList, (image) {
            var url = baseUrlApi+'/newimagescene/?${id}&nombreescena=${nombreescena}&nombreimagen=${3}';
          });

        }else{

        }
      });
    });

  }

  Future<String> createTour(Tour tour ) async {

    var url = baseUrlApi+"/addtour/?token=$token&titulo=${tour.title}&ciudad=${tour.infoTour!['ciudad']}&direccion=${tour.infoTour!['direccion']}&idusuario=$idusuario";

    var response = await http.post(Uri.parse(url));
    var idSavedTour = response.body.split('=').last;
    return idSavedTour;

  }

}
