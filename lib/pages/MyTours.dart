import 'package:app_tours/models/Tour.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToursPage extends StatefulWidget {
  const ToursPage({Key? key}) : super(key: key);

  @override
  State<ToursPage> createState() => _ToursPageState();
}

class _ToursPageState extends State<ToursPage> {
  SharedPref sharedPref = SharedPref();
  List<dynamic> tours = [];
  @override
  void initState() {
    getTours().then((response) {
      //calling setState will refresh your build method.
      setState(() {
        tours = response;
        // print(tours.toString());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            
                FutureBuilder(
              future: getTours(),
              builder: (BuildContext context,AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  //print(snapshot.data);
                  List aux = snapshot.data!;
                  return Expanded(
                    child: ListView.builder( itemCount:aux.length ,itemBuilder: (BuildContext context, int index){
                      return Card(
                        child: ListTile(
                          onTap: () async{
                            Tour tourSaved= await context.read<TourProvider>().mapToTour(tourSaved: snapshot.data![index]);
                            if(tourSaved.type!= 'other'){
                              context.read<TourProvider>().newTour=tourSaved;
                              Navigator.pushNamed(context, '/toursDisponibles/${tourSaved.type}',arguments:{'formData':tourSaved.infoTour, 'case':true,'index':index});
                            }
                            //print(snapshot.data![index]);
                          },
                            leading: const Icon(Icons.threesixty),
                            trailing:
                            MaterialButton(
                              onPressed: () {
                                sharedPref.remove('nuevo_tour', index);
                                setState(() {

                                });
                              },
                              color: Colors.redAccent,
                              textColor: Colors.white,
                              child: const Icon(
                                Icons.delete,
                                size: 20,
                              ),
                              padding: const EdgeInsets.all(1),
                              shape: const CircleBorder(),
                            ),


                            subtitle:Text(aux[index]['type'],
                              style: const TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            title: Text(aux[index]['title'])),
                      );
                    }),
                  );
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }


              },
            ),
/*
                ListView.builder(
                  //shrinkWrap: false,
                    itemCount: tours.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          leading: const Icon(Icons.list),
                          trailing: Text(
                            tours[index]['infoList']['titulo'],
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          title: Text("List item $index"));
                    })
                */
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> getTours() async {
    var tour = await sharedPref.read("nuevo_tour");
    if(tour == null){
      return [];
    }
    return tour;
  }
}
