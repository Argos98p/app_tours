import 'package:app_tours/models/Tour.dart';
import 'package:app_tours/pages/search_tour_delegate.dart';
import 'package:app_tours/pages/visualizer_page.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:app_tours/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

class ToursPage extends StatefulWidget {
  const ToursPage({Key? key}) : super(key: key);

  @override
  State<ToursPage> createState() => _ToursPageState();
}

class _ToursPageState extends State<ToursPage> {
  String busqueda = '';
  SharedPref sharedPref = SharedPref();
  TextEditingController textControllerSearch = TextEditingController();
  List<dynamic> tours = [];
  List<dynamic> allTours = [];
  List<String> typeListAvaliables = [];

  @override
  void initState() {
    getTours().then((response) {
      //calling setState will refresh your build method.
      setState(() {
        allTours = response;
        tours = response;
        typeListAvaliables = typeListAvaliable(tours: tours);
        print('essdf tours' + tours.toString());
        //tours=getTourOfType( type: 'Todos',);
        // print(tours.toString());
      });
    });
    super.initState();
  }

  List<String> typeFilter = [];
  String typeFilterSelected = 'Todos';

  List<String> typeListAvaliable({required List<dynamic> tours}) {
    List<String> typeList = ['Todos'];
    tours.forEach((element) {
      if (element['type'] != 'otro') {
        if (!typeList.contains(element['type'])) {
          typeList.add(element['type']);
        }
      } else {
        if (!typeList.contains(element['infoTour']['tipo_aux'])) {
          typeList.add(element['infoTour']['tipo_aux']);
        }
      }
    });
    return typeList;
  }

  //Devuelve los tours de un determinado tipo
  List<dynamic> getTourOfType({required String type}) {
    print(type);
    List<dynamic> toursOfType = [];
    if (type == 'Todos') {
      return allTours;
    }
    allTours.forEach((element) {
      if (element['type'] != 'otro') {
        if (element['type'] == type) {
          toursOfType.add(element);
        }
      } else {
        if (element['infoTour']['tipo_aux'] == type) {
          toursOfType.add(element);
        }
      }
    });
    return toursOfType;
  }

  @override
  Widget build(BuildContext context) {
    //typeListAvaliables=typeListAvaliable(tours: tours);


    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: ()  {
                     showSearch(
                      context: context,
                      delegate: SearchTourDelegate(tours),
                    );

                      getTours().then((response) {
                        //calling setState will refresh your build method.
                        setState(() {
                          allTours = response;
                          tours = response;
                          typeListAvaliables = typeListAvaliable(tours: tours);
                          tours = getTourOfType(type: typeFilterSelected);
                        });

                    });
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.maybeOf(context)!.size.width * 0.7,
                    margin: const EdgeInsets.only(
                        left: 3, right: 2, top: 6, bottom: 3),
                    decoration: BoxDecoration(
                        color: colorsApp['primaryColor'],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 10),
                          child: Icon(
                            FontAwesome5.search,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'Buscar',
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 18),
                            ))
                      ],
                    ),
                  ),
                ),
                DropdownButton<String>(
                  underline: SizedBox(),
                  value: typeFilterSelected,
                  items: List.generate(
                      typeListAvaliables.length,
                      (index) => DropdownMenuItem(
                            child: Text(typeListAvaliables[index]),
                            value: typeListAvaliables[index],
                          )),
                  onChanged: (value) {
                    setState(() {
                      typeFilterSelected = value!;
                      tours = getTourOfType(type: value);
                    });
                  },
                ),
              ],
            ),
            Container(
              child: FutureBuilder(
                future: getTours(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    //print(snapshot.data);
                    allTours=snapshot.data!;
                    tours=getTourOfType(type: typeFilterSelected);
                    List aux = tours;
                    return Expanded(
                      child: ListView.builder(
                          itemCount: aux.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                  onTap: () async {
                                    Tour tourSaved = await context
                                        .read<TourProvider>()
                                        .mapToTour(
                                            tourSaved: snapshot.data![index]);
                                    context.read<TourProvider>().newTour =
                                        tourSaved;

                                    Navigator.pushNamed(context,'/tourGuardado', arguments: tourSaved);

                                    /*Navigator.pushNamed(context,
                                        '/toursDisponibles/${tourSaved.type}',
                                        arguments: {
                                          'formData': tourSaved.infoTour,
                                          'case': true,
                                          'index': index
                                        });*/

                                    //print(snapshot.data![index]);
                                  },
                                  leading: const Icon(Icons.threesixty),
                                  trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                    children: [
                                      MaterialButton(
                                        onPressed: () async {
                                          Tour tourSaved = await context
                                              .read<TourProvider>()
                                              .mapToTour(
                                              tourSaved: snapshot.data![index]);
                                          setState(() {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => VisualizerPage(tourSaved: tourSaved)));

                                          });

                                        },
                                        color: Colors.redAccent,
                                        textColor: Colors.white,
                                        child: const Icon(
                                          Icons.remove_red_eye,
                                          size: 20,
                                        ),
                                        padding: const EdgeInsets.all(1),
                                        shape: const CircleBorder(),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          setState(()  {
                                            print('entra');
                                            sharedPref.remove(
                                                'nuevo_tour', index);

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
                                    ],
                                  ),
                                  subtitle: (aux[index]['type'] != "otro")
                                      ? Text(
                                          aux[index]['type'],
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontSize: 15),
                                        )
                                      : Text(
                                          aux[index]['infoTour']['tipo_aux'],
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontSize: 15),
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
    if (tour == null) {
      return [];
    }
    return tour;
  }

  List<dynamic> searchResult(
      {required List<dynamic> tours, required String nameTour}) {
    List<dynamic> toursFound = [];
    tours.forEach((element) {
      element['title'].contains(nameTour);
      toursFound.add(element);
    });
    return toursFound;
  }
}
